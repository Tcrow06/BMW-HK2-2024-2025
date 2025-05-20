package com.webecommerce.controller.web;

import com.webecommerce.constant.ModelConstant;
import com.webecommerce.dto.ProductDTO;
import com.webecommerce.filter.FilterProduct;
import com.webecommerce.filter.FilterProductVariant;
import com.webecommerce.paging.PageRequest;
import com.webecommerce.paging.Pageable;
import com.webecommerce.service.ICategoryService;
import com.webecommerce.service.IProductService;
import com.webecommerce.sort.Sorter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import static com.webecommerce.utils.StringUtils.sanitizeInput;
import static com.webecommerce.utils.StringUtils.sanitizeXsltInput;

@WebServlet(urlPatterns = {"/danh-sach-san-pham"})
public class ProductController extends HttpServlet {

    private static final Logger logger = LoggerFactory.getLogger(ProductController.class);

    @Inject
    private IProductService productService;

    @Inject
    private ICategoryService categoryService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> listNames = productService.getAllProductName();
        ProductDTO product = new ProductDTO();

        // Xử lý tham số brand: chỉ cho phép chữ, số, khoảng trắng, dấu gạch ngang
        String brand = sanitizeXsltInput(request.getParameter("brand"));
        if (brand != null && !brand.matches("^[a-zA-Z0-9\\s-]{0,50}$")) {
            brand = null;
        }

        // Xử lý tham số page
        int page = 1; // Giá trị mặc định
        String pageParam = sanitizeInput(request.getParameter("page"));
        if (pageParam != null && pageParam.matches("^\\d+$")) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) {
                    page = 1;
                }
            } catch (NumberFormatException e) {
                logger.error("Invalid page parameter: {}", pageParam);
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid page parameter");
                return;
            }
        } else if (pageParam != null) {
            logger.error("Invalid page format: {}", pageParam);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid page format");
            return;
        }

        // Xử lý tham số maxPageItem
        int maxPageItem = 10; // Giá trị mặc định
        String maxPageItemParam = sanitizeXsltInput(request.getParameter("maxPageItem"));
        if (maxPageItemParam != null && maxPageItemParam.matches("^\\d+$")) {
            try {
                maxPageItem = Integer.parseInt(maxPageItemParam);
                if (maxPageItem < 1 || maxPageItem > 100) {
                    maxPageItem = 10;
                }
            } catch (NumberFormatException e) {
                logger.error("Invalid maxPageItem: {}", maxPageItemParam);
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid maxPageItem parameter");
                return;
            }
        } else if (maxPageItemParam != null) {
            logger.error("Invalid maxPageItem format: {}", maxPageItemParam);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid maxPageItem format");
            return;
        }

        // Xử lý tham số tag, sort, searchName
        String tag = sanitizeInput(request.getParameter("tag"));
        if (tag != null && !tag.matches("^[a-zA-Z0-9\\s-]{0,50}$")) {
            tag = null;
        }

        String sort = sanitizeInput(request.getParameter("sort"));
        if (sort != null && !isValidSort(sort)) {
            sort = null;
        }

        String searchName = sanitizeInput(request.getParameter("ten"));
        if (searchName != null && !searchName.isEmpty()) {
            searchName = searchName.trim();
            if (searchName.length() > 100 || !searchName.matches("^[a-zA-Z0-9\\s-]*$")) {
                searchName = null;
            }
        }

        product.setPage(page);
        product.setMaxPageItem(maxPageItem);

        // Xử lý tham số category
        String categoryParam = sanitizeXsltInput(request.getParameter("category"));
        int categoryId = -1; // Giá trị mặc định
        if (categoryParam != null && categoryParam.matches("^\\d+$")) {
            try {
                categoryId = Integer.parseInt(categoryParam);
                if (categoryId < 1 || categoryId > 1000) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid category ID");
                    return;
                }
            } catch (NumberFormatException e) {
                logger.error("Invalid category: {}", categoryParam);
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid category format");
                return;
            }
        } else if (categoryParam != null) {
            logger.error("Invalid category format: {}", categoryParam);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid category format");
            return;
        }

        // Xử lý tham số minPrice và maxPrice
        double minPrice = 0; // Giá trị mặc định
        double maxPrice = Double.MAX_VALUE; // Giá trị mặc định
        String minPriceStr = sanitizeInput(request.getParameter("minPrice"));
        String maxPriceStr = sanitizeInput(request.getParameter("maxPrice"));

        if (minPriceStr != null && minPriceStr.matches("^\\d+(\\.\\d+)?$")) {
            try {
                minPrice = Double.parseDouble(minPriceStr);
                if (minPrice < 0) {
                    minPrice = 0;
                }
            } catch (NumberFormatException e) {
                logger.error("Invalid minPrice: {}", minPriceStr);
            }
        } else if (minPriceStr != null) {
            logger.error("Invalid minPrice format: {}", minPriceStr);
        }

        if (maxPriceStr != null && maxPriceStr.matches("^\\d+(\\.\\d+)?$")) {
            try {
                maxPrice = Double.parseDouble(maxPriceStr);
                if (maxPrice < minPrice) {
                    maxPrice = minPrice;
                }
            } catch (NumberFormatException e) {
                logger.error("Invalid maxPrice: {}", maxPriceStr);
            }
        } else if (maxPriceStr != null) {
            logger.error("Invalid maxPrice format: {}", maxPriceStr);
        }

        if (sort != null) {
            product.setSortBy(sort);
        }

        // Tạo Pageable với các tham số đã vệ sinh
        Pageable pageable = new PageRequest(product.getPage(), product.getMaxPageItem(),
                new FilterProduct(categoryId, brand, tag),
                new FilterProductVariant(minPrice, maxPrice), new Sorter(product.getSortBy()));

        // Lấy danh sách sản phẩm
        List<ProductDTO> productDTOList;
        try {
            productDTOList = productService.findAll(pageable);
            if (searchName != null && !searchName.isEmpty()) {
                productDTOList = productService.findAllByName(pageable, searchName);
            }
            product.setResultList(productDTOList);
        } catch (Exception e) {
            logger.error("Error fetching products: {}", e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching products");
            return;
        }

        // Tính tổng số trang và số bản ghi
        product.setTotalItem(productService.getTotalItems());
        product.setTotalPage(productService.setTotalPage(product.getTotalItem(), product.getMaxPageItem()));

        // Thiết lập các thuộc tính cho JSP
        request.setAttribute(ModelConstant.MODEL2, productService.getBrands());
        request.setAttribute(ModelConstant.MODEL1, categoryService.findAll());
        request.setAttribute(ModelConstant.MODEL, product);
        request.setAttribute("listNames", listNames);
        request.getRequestDispatcher("/views/web/product-list.jsp").forward(request, response);
    }

    // Hàm kiểm tra giá trị sort hợp lệ
    private boolean isValidSort(String sort) {
        if (sort == null) return false;
        return sort.equals("price-asc") || sort.equals("price-desc") ||
                sort.equals("name-asc") || sort.equals("name-desc");
    }
}
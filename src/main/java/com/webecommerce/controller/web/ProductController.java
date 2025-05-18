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

@WebServlet(urlPatterns = {"/danh-sach-san-pham"})
public class ProductController extends HttpServlet {

    private static final Logger logger = LoggerFactory.getLogger(ProductController.class);

    @Inject
    private IProductService productService;

    @Inject
    private ICategoryService categoryService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Lấy danh sách tên sản phẩm
            List<String> listNames = productService.getAllProductName();
            ProductDTO product = new ProductDTO();

            // Lấy và xác thực tham số
            String category = request.getParameter("category");
            String brand = request.getParameter("brand");
            String pageStr = request.getParameter("page");
            String maxPageItemStr = request.getParameter("maxPageItem");
            String minPriceStr = request.getParameter("minPrice");
            String maxPriceStr = request.getParameter("maxPrice");
            String tag = request.getParameter("tag");
            String sort = request.getParameter("sort");
            String searchName = request.getParameter("ten");

            // Xác thực và đặt giá trị mặc định cho page
            int page = 1;
            try {
                if (pageStr != null && !pageStr.isEmpty()) {
                    page = Integer.parseInt(pageStr);
                    if (page < 1) {
                        page = 1; // Đảm bảo page không âm
                    }
                }
            } catch (NumberFormatException e) {
                logger.warn("Invalid page parameter: {}", pageStr);
                page = 1;
            }

            // Xác thực và đặt giá trị mặc định cho maxPageItem
            int maxPageItem = 9;
            try {
                if (maxPageItemStr != null && !maxPageItemStr.isEmpty()) {
                    maxPageItem = Integer.parseInt(maxPageItemStr);
                    if (maxPageItem < 1 || maxPageItem > 100) {
                        maxPageItem = 9; // Giới hạn maxPageItem
                    }
                }
            } catch (NumberFormatException e) {
                logger.warn("Invalid maxPageItem parameter: {}", maxPageItemStr);
                maxPageItem = 9;
            }

            // Xác thực categoryId
            int categoryId = -1;
            try {
                if (category != null && !category.isEmpty()) {
                    categoryId = Integer.parseInt(category);
                    if (categoryId < 0) {
                        categoryId = -1; // Đặt lại nếu không hợp lệ
                    }
                }
            } catch (NumberFormatException e) {
                logger.warn("Invalid category parameter: {}", category);
            }

            // Xác thực minPrice và maxPrice
            double minPrice = 0;
            double maxPrice = Double.MAX_VALUE;
            try {
                if (minPriceStr != null && !minPriceStr.isEmpty()) {
                    minPrice = Double.parseDouble(minPriceStr);
                    if (minPrice < 0) {
                        minPrice = 0; // Giá không âm
                    }
                }
                if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
                    maxPrice = Double.parseDouble(maxPriceStr);
                    if (maxPrice < minPrice) {
                        maxPrice = Double.MAX_VALUE; // Đảm bảo maxPrice hợp lý
                    }
                }
            } catch (NumberFormatException e) {
                logger.warn("Invalid price parameters: minPrice={}, maxPrice={}", minPriceStr, maxPriceStr);
            }

            // Xác thực sort
            if (sort != null && !isValidSort(sort)) {
                sort = null; // Chỉ chấp nhận các giá trị sort hợp lệ
            }

            // Vệ sinh searchName
            if (searchName != null && !searchName.isEmpty()) {
                searchName = searchName.trim();
                if (searchName.length() > 100) {
                    searchName = searchName.substring(0, 100); // Giới hạn độ dài
                }
            }

            // Thiết lập ProductDTO
            product.setPage(page);
            product.setMaxPageItem(maxPageItem);
            if (sort != null) {
                product.setSortBy(sort);
            }

            // Tạo Pageable
            Pageable pageable = new PageRequest(
                    product.getPage(),
                    product.getMaxPageItem(),
                    new FilterProduct(categoryId, brand, tag),
                    new FilterProductVariant(minPrice, maxPrice),
                    new Sorter(product.getSortBy())
            );

            // Lấy danh sách sản phẩm
            List<ProductDTO> productDTOList;
            if (searchName != null && !searchName.isEmpty()) {
                productDTOList = productService.findAllByName(pageable, searchName);
            } else {
                productDTOList = productService.findAll(pageable);
            }
            product.setResultList(productDTOList);

            // Tính toán tổng số trang và mục
            product.setTotalItem(productService.getTotalItems());
            product.setTotalPage(productService.setTotalPage(product.getTotalItem(), product.getMaxPageItem()));

            // Thiết lập thuộc tính request
            request.setAttribute(ModelConstant.MODEL2, productService.getBrands());
            request.setAttribute(ModelConstant.MODEL1, categoryService.findAll());
            request.setAttribute(ModelConstant.MODEL, product);
            request.setAttribute("listNames", listNames);

            // Chuyển tiếp đến JSP
            request.getRequestDispatcher("/views/web/product-list.jsp").forward(request, response);

        } catch (Exception e) {
            logger.error("Error processing product list", e);
            response.sendRedirect("/danh-sach-san-pham?page=1&maxPageItem=9");
        }
    }

    // Hàm kiểm tra giá trị sort hợp lệ
    private boolean isValidSort(String sort) {
        if (sort == null) return false;
        // Chỉ cho phép các giá trị sort được định nghĩa trước
        return sort.equals("price-asc") || sort.equals("price-desc") ||
                sort.equals("name-asc") || sort.equals("name-desc");
    }
}
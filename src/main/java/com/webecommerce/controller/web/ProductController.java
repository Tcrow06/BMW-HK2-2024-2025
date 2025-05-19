package com.webecommerce.controller.web;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.webecommerce.constant.ModelConstant;
import com.webecommerce.dao.product.IProductDAO;
import com.webecommerce.dto.ProductDTO;
import com.webecommerce.filter.FilterProduct;
import com.webecommerce.filter.FilterProductVariant;
import com.webecommerce.paging.PageRequest;
import com.webecommerce.paging.Pageable;
import com.webecommerce.service.ICategoryService;
import com.webecommerce.service.IProductService;
import com.webecommerce.sort.Sorter;

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

    @Inject
    private IProductService productService;
    @Inject
    private ICategoryService categoryService;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> listNames = productService.getAllProductName();
        ProductDTO product = new ProductDTO();

        String brand = sanitizeXsltInput(request.getParameter("brand"));

        int page = 1; // Giá trị mặc định
        String pageParam = sanitizeInput(request.getParameter("page"));
        if (pageParam != null && pageParam.matches("^\\d+$")) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                System.out.println(String.format("Invalid page: %s", pageParam));
            }
        }

        int maxPageItem = 10; // Giá trị mặc định
        String maxPageItemParam = sanitizeXsltInput(request.getParameter("maxPageItem"));
        if (maxPageItemParam != null && maxPageItemParam.matches("^\\d+$")) {
            try {
                maxPageItem = Integer.parseInt(maxPageItemParam);
            } catch (NumberFormatException e) {
                System.out.println(String.format("Invalid maxPageItem: %s", maxPageItemParam));
            }
        }


        String tag = sanitizeInput(request.getParameter("tag"));
        String sort = sanitizeInput(request.getParameter("sort"));
        String searchName = sanitizeInput(request.getParameter("ten"));

        product.setPage(page);
        product.setMaxPageItem(maxPageItem);



//        String categoryParam = sanitizeXsltInput(request.getParameter("category"));
        String categoryParam = (request.getParameter("category"));

        int categoryId = -1;

        try {
            categoryId = Integer.parseInt(categoryParam);
        }
        catch (NumberFormatException e) {
            System.out.println(e);
        }

//        int categoryId = -1; // Giá trị mặc định
//        if (categoryParam == null || !categoryParam.matches("^[a-zA-Z0-9_-]+$")) {
//            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid category");
//            return;
//        }
//        try {
//            if (!categoryParam.isEmpty() && categoryParam.matches("^\\d+$")) {
//                categoryId = Integer.parseInt(categoryParam);
//                if (categoryId < 1 || categoryId > 1000) {
//                    categoryId = -1; // Reset nếu ngoài giới hạn
//                }
//            }
//        } catch (NumberFormatException e) {
//            System.out.println(String.format("Invalid category: %s", categoryParam));
//        }


        double minPrice = Integer.MIN_VALUE; // Giá trị mặc định
        double maxPrice = Integer.MAX_VALUE; // Giá trị mặc định
        String minPriceStr = sanitizeInput(request.getParameter("minPrice"));
        String maxPriceStr = sanitizeInput(request.getParameter("maxPrice"));

        if (minPriceStr != null && minPriceStr.matches("^\\d+(\\.\\d+)?$")) {
            minPrice = Double.parseDouble(minPriceStr);
        }
        if (maxPriceStr != null && maxPriceStr.matches("^\\d+(\\.\\d+)?$")) {
            maxPrice = Double.parseDouble(maxPriceStr);
        }

        if (sort != null) {
            product.setSortBy(sort);
        }


        Pageable pageable = new PageRequest(product.getPage(), product.getMaxPageItem(), new FilterProduct(categoryId, brand, tag),
                new FilterProductVariant(minPrice, maxPrice), new Sorter(product.getSortBy()));


        List<ProductDTO> productDTOList = productService.findAll(pageable);
        if (searchName != null && !searchName.isEmpty()) {
            productDTOList = productService.findAllByName(pageable, searchName);
        }
        product.setResultList(productDTOList);

        //nháp

        product.setTotalItem(productService.getTotalItems());

        //hết nháp
        product.setTotalPage(productService.setTotalPage(product.getTotalItem(),
                product.getMaxPageItem()));

        request.setAttribute(ModelConstant.MODEL2, productService.getBrands());
        request.setAttribute(ModelConstant.MODEL1, categoryService.findAll());

        request.setAttribute(ModelConstant.MODEL, product);
        request.setAttribute("listNames", listNames);
        request.getRequestDispatcher("/views/web/product-list.jsp").forward(request, response);
    }
}

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

@WebServlet(urlPatterns = {"/danh-sach-san-pham"})
public class ProductController extends HttpServlet {

    @Inject
    private IProductService productService;
    @Inject
    private ICategoryService categoryService;

    private static final int MAX_PARAM_LENGTH = 10, MAX_PAGE = 1000, MAX_ITEMS_PER_PAGE = 100;
    private static final int DEFAULT_PAGE = 1, DEFAULT_MAX_PAGE_ITEM = 9;
    private static final int MAX_TEXT_LENGTH = 100;
    private static final double MAX_PRICE = 1_000_000_000.0, MIN_PRICE = 0.0;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> listNames = productService.getAllProductName();
        ProductDTO product = new ProductDTO();

        String category = request.getParameter("category");
        String brand = request.getParameter("brand");
        String pageStr = request.getParameter("page");
        String  maxPageItemStr = request.getParameter("maxPageItem");
        String minPriceStr = (request.getParameter("minPrice"));
        String maxPriceStr = request.getParameter("maxPrice");
        String tag = request.getParameter("tag");
        String sort = request.getParameter("sort");

        String searchName = request.getParameter("ten");

        if ((minPriceStr != null && minPriceStr.length() > MAX_PARAM_LENGTH) ||
                (maxPriceStr != null && maxPriceStr.length() > MAX_PARAM_LENGTH) ||
                (category != null && category.length() > MAX_PARAM_LENGTH) ||
                (brand != null && brand.length() > MAX_TEXT_LENGTH) ||
                (tag != null && tag.length() > MAX_TEXT_LENGTH) ||
                (sort != null && sort.length() > MAX_TEXT_LENGTH) ||
                (searchName != null && searchName.length() > MAX_TEXT_LENGTH)||
                pageStr != null && pageStr.length() > MAX_PARAM_LENGTH ||
                maxPageItemStr != null && maxPageItemStr.length() > MAX_PARAM_LENGTH) {
            response.sendError(400, "Parameter too long");
            return;
        }

        int page = DEFAULT_PAGE;
        try {
            if (pageStr != null && !pageStr.isEmpty()) {
                page = Integer.parseInt(pageStr);
                if (page < 1 || page > MAX_PAGE) throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            response.sendError(400, "Invalid page");
            return;
        }

        int maxPageItem = DEFAULT_MAX_PAGE_ITEM;
        try {
            if (maxPageItemStr != null && !maxPageItemStr.isEmpty()) {
                maxPageItem = Integer.parseInt(maxPageItemStr);
                if (maxPageItem < 1 || maxPageItem > MAX_ITEMS_PER_PAGE) throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            response.sendError(400, "Invalid maxPageItem");
            return;
        }
        double minPrice = Integer.MIN_VALUE;
        double maxPrice = Integer.MAX_VALUE;
        try {
            if (minPriceStr != null && !minPriceStr.isEmpty()) {
                minPrice = Double.parseDouble(minPriceStr);
                if (minPrice < MIN_PRICE || minPrice > MAX_PRICE) throw new NumberFormatException();
            }
            if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
                maxPrice = Double.parseDouble(maxPriceStr);
                if (maxPrice < MIN_PRICE || maxPrice > MAX_PRICE) throw new NumberFormatException();
            }
            if (minPrice != Integer.MIN_VALUE && maxPrice != Integer.MAX_VALUE && minPrice > maxPrice) {
                response.sendError(400, "minPrice cannot be greater than maxPrice");
                return;
            }
        } catch (NumberFormatException e) {
            response.sendError(400, "Invalid price format");
            return;
        }


        product.setPage(page);
        product.setMaxPageItem(maxPageItem);

        int categoryId = -1;

        try {
            categoryId = Integer.parseInt(category);
        }
        catch (NumberFormatException e) {
            System.out.println(e);
        }



        if(sort != null) {
            product.setSortBy(sort);
        }
        Pageable pageable =new PageRequest(product.getPage(), product.getMaxPageItem(), new FilterProduct(categoryId, brand, tag),
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

        request.setAttribute(ModelConstant.MODEL,product);
        request.setAttribute("listNames", listNames);
        request.getRequestDispatcher("/views/web/product-list.jsp").forward(request, response);
    }
}

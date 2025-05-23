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
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static com.webecommerce.utils.StringUtils.sanitizeXsltInputNumber;

@WebServlet(urlPatterns = {"/danh-sach-san-pham"})
public class ProductController extends HttpServlet {

    private static final Logger logger = LoggerFactory.getLogger(ProductController.class);

    @Inject
    private IProductService productService;

    @Inject
    private ICategoryService categoryService;

    // Hàm vệ sinh đầu vào với kiểm tra Path Traversal
    public static String sanitizeInput(String input) {
        if (input == null) return null;
        try {
            // Giải mã URL để xử lý các chuỗi như %2e%2e%2f
            String decoded = URLDecoder.decode(input, StandardCharsets.UTF_8.name());
            // Kiểm tra các chuỗi Path Traversal
            if (decoded.contains("../") || decoded.contains("..\\") || decoded.contains("%00") ||
                    decoded.contains("./") || decoded.contains(".\\")) {
                logger.warn("Potential Path Traversal attempt detected: {}", decoded);
                return null;
            }
            // Loại bỏ các ký tự nguy hiểm khác
            return decoded.replaceAll("[<>\"';]", "").trim();
        } catch (UnsupportedEncodingException e) {
            logger.error("Error decoding input: {}", input, e);
            return null;
        }
    }

    // Hàm vệ sinh đầu vào cho XSLT (tương tự nhưng có thể tùy chỉnh thêm nếu cần)
    public static String sanitizeXsltInput(String input) {
        if (input == null) return null;
        // Chặn các hàm nguy hiểm trong XSLT
        String[] dangerousPatterns = {
                "xsl:", "document\\(", "system-property\\(", "xsl:value-of", "xsl:template", "xsl:stylesheet", "<", ">", "\"", "'"
        };
        String sanitized = input.toLowerCase();
        for (String pattern : dangerousPatterns) {
            sanitized = sanitized.replaceAll("(?i)" + pattern, ""); // loại bỏ bất kể hoa/thường
        }
        return sanitized;
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> listNames = productService.getAllProductName();
        ProductDTO product = new ProductDTO();

        // Xử lý tham số brand
        String brand = sanitizeXsltInput(request.getParameter("brand"));
        if (brand != null && !brand.matches("^[a-zA-Z0-9\\s-]{0,50}$")) {
            logger.warn("Invalid brand format: {}", brand);
            brand = null;
        } else if (brand != null && !isValidBrand(brand)) {
            logger.warn("Brand not found in valid list: {}", brand);
            brand = null;
        }

        // Xử lý tham số page
        int page = 1; // Giá trị mặc định
        String pageParam = sanitizeXsltInputNumber(request.getParameter("page"));
        boolean redirectNeeded = false;

        if (pageParam != null && pageParam.matches("^\\d+$")) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) {
                    redirectNeeded = true;
                }
            } catch (NumberFormatException e) {
                logger.error("Invalid page format: {}", pageParam);
                redirectNeeded = true;
            }
        } else if (pageParam != null) {
            logger.warn("Potential malicious page input: {}", pageParam);
            redirectNeeded = true;
        }

        // Xử lý tham số maxPageItem
        int maxPageItem = 9; // Giá trị mặc định
        String maxPageItemParam = sanitizeXsltInputNumber(request.getParameter("maxPageItem"));

        if (maxPageItemParam != null && maxPageItemParam.matches("^\\d+$")) {
            try {
                maxPageItem = Integer.parseInt(maxPageItemParam);
                if (maxPageItem < 1 || maxPageItem > 100) {
                    logger.warn("Invalid maxPageItem: {}", maxPageItemParam);
                    redirectNeeded = true;
                }
            } catch (NumberFormatException e) {
                logger.error("Invalid maxPageItem format: {}", maxPageItemParam);
                redirectNeeded = true;
            }
        } else if (maxPageItemParam != null) {
            logger.warn("Potential malicious maxPageItem input: {}", maxPageItemParam);
            redirectNeeded = true;
        }

        // Chuyển hướng nếu có tham số không hợp lệ
        if (redirectNeeded) {
            Map<String, String[]> paramMap = new HashMap<>(request.getParameterMap());
            paramMap.put("page", new String[]{"1"});
            paramMap.put("maxPageItem", new String[]{"9"});

            String query = paramMap.entrySet().stream()
                    .flatMap(entry -> Arrays.stream(entry.getValue())
                            .map(value -> entry.getKey() + "=" + URLEncoder.encode(value, StandardCharsets.UTF_8)))
                    .collect(Collectors.joining("&"));

            response.sendRedirect(request.getRequestURI() + "?" + query);
            return;
        }

        // Xử lý tham số tag
        String tag = sanitizeInput(request.getParameter("tag"));
        if (tag != null && !tag.matches("^[a-zA-Z0-9\\s-]{0,50}$")) {
            logger.warn("Invalid tag format: {}", tag);
            tag = null;
        }

        // Xử lý tham số sort
        String sort = sanitizeInput(request.getParameter("sort"));
        if (sort != null && !isValidSort(sort)) {
            logger.warn("Invalid sort value: {}", sort);
            sort = null;
        }

        // Xử lý tham số ten (tên sản phẩm)
        String searchName = sanitizeInput(request.getParameter("ten"));
        if (searchName != null && !searchName.isEmpty()) {
            searchName = searchName.trim();
            if (searchName.length() > 100 || !searchName.matches("^[a-zA-Z0-9\\s-]*$")) {
                logger.warn("Invalid searchName format: {}", searchName);
                searchName = null;
            }
        }

        // Xử lý tham số category
        String categoryParam = sanitizeXsltInput(request.getParameter("category"));
        int categoryId = -1; // Giá trị mặc định
        if (categoryParam != null && !categoryParam.isEmpty()) {
            if (categoryParam.matches("^\\d+$")) {
                try {
                    categoryId = Integer.parseInt(categoryParam);
                    if (categoryId < 1 || categoryId > 1000) {
                        logger.warn("Invalid category ID: {}", categoryParam);
                        response.sendRedirect(request.getContextPath() + "/danh-sach-san-pham?page=1&maxPageItem=9");
                        return;
                    }
                } catch (NumberFormatException e) {
                    logger.error("Invalid category format: {}", categoryParam);
                    response.sendRedirect(request.getContextPath() + "/danh-sach-san-pham?page=1&maxPageItem=9");
                    return;
                }
            } else {
                logger.warn("Potential malicious category input: {}", categoryParam);
                response.sendRedirect(request.getContextPath() + "/danh-sach-san-pham?page=1&maxPageItem=9");
                return;
            }
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
                logger.error("Invalid minPrice format: {}", minPriceStr);
            }
        } else if (minPriceStr != null) {
            logger.warn("Potential malicious minPrice input: {}", minPriceStr);
        }

        if (maxPriceStr != null && maxPriceStr.matches("^\\d+(\\.\\d+)?$")) {
            try {
                maxPrice = Double.parseDouble(maxPriceStr);
                if (maxPrice < minPrice) {
                    maxPrice = minPrice;
                }
            } catch (NumberFormatException e) {
                logger.error("Invalid maxPrice format: {}", maxPriceStr);
            }
        } else if (maxPriceStr != null) {
            logger.warn("Potential malicious maxPrice input: {}", maxPriceStr);
        }

        // Thiết lập các tham số cho ProductDTO
        product.setPage(page);
        product.setMaxPageItem(maxPageItem);
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
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi lấy danh sách sản phẩm");
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

        // Chuyển hướng đến JSP
        request.getRequestDispatcher("/views/web/product-list.jsp").forward(request, response);
    }

    // Hàm kiểm tra giá trị sort hợp lệ
    private boolean isValidSort(String sort) {
        if (sort == null) return false;
        return sort.equals("price-asc") || sort.equals("price-desc") ||
                sort.equals("name-asc") || sort.equals("name-desc");
    }

    // Hàm kiểm tra brand hợp lệ (dựa trên danh sách từ productService)
    private boolean isValidBrand(String brand) {
        List<String> validBrands = productService.getBrands();
        return brand != null && validBrands.contains(brand);
    }
}
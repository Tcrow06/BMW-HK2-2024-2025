package com.webecommerce.controller.web;

import com.webecommerce.constant.ModelConstant;
import com.webecommerce.dto.ProductDTO;
import com.webecommerce.dto.review.ProductReviewDTO;
import com.webecommerce.service.IProductReviewService;
import com.webecommerce.service.IProductService;
import com.webecommerce.utils.JWTUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/san-pham"})
public class ProductDetailController extends HttpServlet {

    @Inject
    private IProductService productService;

    private static final Logger logger = LoggerFactory.getLogger(ProductDetailController.class);

    // Hàm vệ sinh input cơ bản (không chứa ký tự nguy hiểm)
    private String sanitizeInput(String input) {
        if (input == null) return null;
        return input.replaceAll("[<>\"'%;()&+]", "").trim();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy và vệ sinh tham số id
        String idRaw = sanitizeInput(request.getParameter("id"));
        Long id = null;

        try {
            if (idRaw != null && idRaw.matches("^\\d{1,10}$")) { // cho phép số có tối đa 10 chữ số
                id = Long.valueOf(idRaw);
            } else {
                throw new NumberFormatException("ID không hợp lệ hoặc bị thiếu.");
            }
        } catch (NumberFormatException e) {
            logger.warn("Lỗi chuyển đổi ID sản phẩm: {}", e.getMessage());
            request.setAttribute("errorMessage", "ID sản phẩm không hợp lệ.");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
            return;
        }

        // Truy vấn sản phẩm nếu ID hợp lệ
        ProductDTO product = productService.getProductDetailById(id);
        if (product == null) {
            request.getRequestDispatcher("/views/web/product-not-found.jsp").forward(request, response);
            return;
        }

        // Gán dữ liệu cho view
        String userRole = JWTUtil.getRole(request);
        if ("OWNER".equals(userRole)) {
            request.setAttribute(ModelConstant.ROLE, userRole);
        }

        request.setAttribute(ModelConstant.MODEL, product);
        request.setAttribute(ModelConstant.REVIEW, product.getProductReviews());
        request.setAttribute(ModelConstant.SUGGEST, product.getResultList());

        request.getRequestDispatcher("/views/web/product-detail.jsp").forward(request, response);
    }
}


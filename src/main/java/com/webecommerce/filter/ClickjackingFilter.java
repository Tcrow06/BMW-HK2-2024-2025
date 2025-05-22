package com.webecommerce.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ClickjackingFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Không cần cấu hình gì thêm
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        if (response instanceof HttpServletResponse) {
            HttpServletResponse httpResp = (HttpServletResponse) response;
            // Chặn iframe toàn bộ
            httpResp.setHeader("X-Frame-Options", "DENY");

            // Hoặc dùng SAMEORIGIN nếu cần nhúng từ cùng domain
            // httpResp.setHeader("X-Frame-Options", "SAMEORIGIN");
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Không cần làm gì
    }
}

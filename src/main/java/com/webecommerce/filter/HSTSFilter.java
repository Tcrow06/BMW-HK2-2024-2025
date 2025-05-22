package com.webecommerce.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class HSTSFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        if (request instanceof HttpServletRequest && response instanceof HttpServletResponse) {
            HttpServletRequest httpRequest = (HttpServletRequest) request;
            HttpServletResponse httpResponse = (HttpServletResponse) response;

            if (httpRequest.isSecure()) { // Chỉ thêm nếu là HTTPS
                httpResponse.setHeader("Strict-Transport-Security",
                        "max-age=31536000; includeSubDomains; preload");
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}

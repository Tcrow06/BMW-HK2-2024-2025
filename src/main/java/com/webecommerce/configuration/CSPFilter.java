package com.webecommerce.configuration;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.UUID;

@WebFilter("/*")
public class CSPFilter implements Filter {


    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletResponse response = (HttpServletResponse) res;


        response.setHeader("Content-Security-Policy",
                "default-src 'self'; " +
                        "script-src 'self' https://cdn.jsdelivr.net https://code.jquery.com https://kit.fontawesome.com; " +
                        "style-src 'self' https://cdn.jsdelivr.net https://fonts.googleapis.com https://stackpath.bootstrapcdn.com https://cdnjs.cloudflare.com; " +
                        "font-src 'self' https://fonts.gstatic.com https://cdnjs.cloudflare.com; " +
                        "img-src 'self' data:;");
        chain.doFilter(req, res);



//        response.setHeader("Content-Security-Policy",
//                "default-src 'self'; " +
//                        "script-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net https://code.jquery.com https://kit.fontawesome.com; " +
//                        "style-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net https://fonts.googleapis.com https://stackpath.bootstrapcdn.com https://cdnjs.cloudflare.com; " +
//                        "font-src 'self' https://fonts.gstatic.com https://cdnjs.cloudflare.com; " +
//                        "img-src 'self' data:;");
//


//        String nonce = UUID.randomUUID().toString();
//        response.setHeader("Content-Security-Policy",
//                "default-src 'self'; " +
//                        "script-src 'self' 'nonce-" + nonce + "' https://cdn.jsdelivr.net https://code.jquery.com https://kit.fontawesome.com; " +
//                        "style-src 'self' 'nonce-" + nonce + "' https://cdn.jsdelivr.net https://fonts.googleapis.com https://stackpath.bootstrapcdn.com https://cdnjs.cloudflare.com; " +
//                        "font-src 'self' https://fonts.gstatic.com https://cdnjs.cloudflare.com; " +
//                        "img-src 'self' data:;");
//
//        req.setAttribute("cspNonce", nonce);



    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }
    @Override
    public void destroy() {

    }
}

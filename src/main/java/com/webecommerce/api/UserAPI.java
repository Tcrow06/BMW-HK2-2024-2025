package com.webecommerce.api;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.webecommerce.dao.people.ICustomerDAO;
import com.webecommerce.entity.people.CustomerEntity;
import com.webecommerce.service.IAccountService;
import com.webecommerce.service.ICustomerService;
import com.webecommerce.utils.HttpUtils;
import com.webecommerce.utils.JWTUtil;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;

@WebServlet(urlPatterns = {"/api/update-user"})
public class UserAPI extends HttpServlet {

    @Inject
    ICustomerService customerService;

    @Inject
    IAccountService accountService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");


        try {
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String id = String.valueOf(JWTUtil.getIdUser(req));
            String csrfToken = req.getParameter("csrfToken");

            //đầu tiên kiểm tra csrf Token
            HttpSession session = req.getSession();
            String sessionCsrf = (String) session.getAttribute("csrfToken");
            if (sessionCsrf == null || !sessionCsrf.equals(csrfToken)) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN, "CSRF token không hợp lệ");
                return;
            }


            String updateResult = customerService.updateInforCustomer(id, name, email, phone);
            if ("oke".equals(updateResult)) {
                resp.setStatus(HttpServletResponse.SC_OK);
                resp.getWriter().write("{\"message\": \"Cập nhật thành công!\"}");
            } else {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp.getWriter().write("{\"error\": \"Đã xảy ra lỗi khi cập nhật thông tin.\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("{\"error\": \"Có lỗi xảy ra, vui lòng thử lại.\"}");
        }
    }

}

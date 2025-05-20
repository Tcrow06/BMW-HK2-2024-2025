package com.webecommerce.controller.web;

import com.webecommerce.constant.EnumAccountStatus;
import com.webecommerce.constant.EnumRole;
import com.webecommerce.dto.CartItemDTO;
import com.webecommerce.dto.PlacedOrder.CheckOutRequestDTO;
import com.webecommerce.dto.request.other.AccountRequest;
import com.webecommerce.dto.request.people.CustomerRequest;
import com.webecommerce.dto.response.people.CustomerResponse;
import com.webecommerce.dto.response.people.UserResponse;
import com.webecommerce.exception.DuplicateFieldException;
import com.webecommerce.service.IAccountService;
import com.webecommerce.service.ICartItemService;
import com.webecommerce.utils.FormUtils;
import com.webecommerce.utils.JWTUtil;
import com.webecommerce.utils.SessionUtil;
import org.owasp.encoder.Encode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.PropertyResourceBundle;
import java.util.ResourceBundle;

import static com.webecommerce.utils.StringUtils.sanitizeInput;

@WebServlet(urlPatterns = {"/dang-nhap", "/dang-ky"})
public class AuthController extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(AuthController.class);

    @Inject
    private IAccountService accountService;

    @Inject
    private ICartItemService cartItemService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ResourceBundle resourceBundle;
        try {
            resourceBundle = new PropertyResourceBundle(
                    new InputStreamReader(
                            this.getClass().getClassLoader().getResourceAsStream("message.properties"),
                            StandardCharsets.UTF_8
                    )
            );
        } catch (Exception e) {
            logger.error("Error loading message.properties: {}", e.getMessage());
            resourceBundle = ResourceBundle.getBundle("message");
        }

        HttpSession session = request.getSession();
        String sendDirection = sanitizeInput(request.getParameter("send-direction"));
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        if (sendDirection != null && sendDirection.matches("^[a-zA-Z0-9/\\-]{0,100}$")) {
            session.setAttribute("send-direction", sendDirection);
        }

        String action = sanitizeInput(request.getParameter("action"));
        if (action != null && (action.equals("login") || action.equals("register") || action.equals("verify"))) {
            String message = sanitizeInput(request.getParameter("message"));
            String alert = sanitizeInput(request.getParameter("alert"));
            String link = sanitizeInput(request.getParameter("link"));

            // Allow list cho alert
            if (alert != null && !alert.matches("^(success|danger)$")) {
                alert = null;
            }

            // Allow list cho message
            String[] validMessages = {
                    "unverified", "username_is_block", "username_password_invalid",
                    "duplicate_phone", "duplicate_email", "duplicate_username",
                    "duplicate_information", "verify_success", "verify_failed",
                    "expired_otp", "verify_retry"
            };
            boolean isValidMessage = false;
            if (message != null) {
                for (String validMsg : validMessages) {
                    if (validMsg.equals(message)) {
                        isValidMessage = true;
                        break;
                    }
                }
            }
            if (!isValidMessage) {
                message = null;
            }

            // Mã hóa đầu ra
            if (message != null && alert != null) {
                try {
                    request.setAttribute("message", Encode.forHtml(resourceBundle.getString(message)));
                    request.setAttribute("alert", Encode.forHtmlAttribute(alert));
                    request.setAttribute("link", Encode.forHtmlAttribute(link));
                } catch (Exception e) {
                    logger.error("Invalid message key: {}", message);
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid message");
                    return;
                }
            }

            if (action.equals("verify")) {
                request.getRequestDispatcher("/views/web/enter-OTP.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/decorators/auth.jsp").forward(request, response);
            }
        } else {
            request.getRequestDispatcher("/decorators/auth.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String action = sanitizeInput(request.getParameter("action"));
        CheckOutRequestDTO checkOutRequestDTO = (CheckOutRequestDTO) session.getAttribute("orderNotHandler");

        if (action != null && action.equals("login")) {
            AccountRequest account = FormUtils.toModel(AccountRequest.class, request);
            String messageStr = accountService.checkLogin(account);
            if (!messageStr.trim().isEmpty()) {
                session.setAttribute("loginData", account);
                response.sendRedirect(request.getContextPath() + "/dang-nhap?action=login&message=" + Encode.forUriComponent(messageStr) + "&alert=danger");
                return;
            }

            UserResponse foundUser = accountService.findByUserNameAndPasswordAndStatus(account.getUserName(), account.getPassword(), "UNVERIFIED");
            if (foundUser != null) {
                accountService.sendOTPToEmail(foundUser.getEmail(), foundUser.getId(), "register");
                response.sendRedirect(request.getContextPath() + "/dang-ky?action=verify&id=" + Encode.forUriComponent(foundUser.getId().toString()) + "&message=unverified&alert=danger");
                return;
            }

            UserResponse user = accountService.findByUserNameAndPassword(account.getUserName(), account.getPassword());
            if (user != null) {
                if (user.getStatus().equals(EnumAccountStatus.BLOCK)) {
                    session.setAttribute("loginData", account);
                    response.sendRedirect(request.getContextPath() + "/dang-nhap?action=login&message=username_is_block&alert=danger&link=help");
                    return;
                }

                SessionUtil.getInstance().putValue(request, "USERINFO", user);
                String path = null;
                String jwtToken = null;

                if (user.getRole().equals(EnumRole.OWNER)) {
                    jwtToken = JWTUtil.generateToken(user);
                    path = "/chu-cua-hang";
                } else if (user.getRole().equals(EnumRole.CUSTOMER)) {
                    HashMap<Long, CartItemDTO> cart = (HashMap<Long, CartItemDTO>) session.getAttribute("cart");
                    cart = cartItemService.updateCartWhenLogin(cart, user.getId());
                    if (checkOutRequestDTO != null) {
                        cart = cartItemService.updateCartWhenBuy(user.getId(), checkOutRequestDTO);
                    }
                    request.getSession().setAttribute("cart", cart);
                    jwtToken = JWTUtil.generateToken(user);
                    path = "/trang-chu";
                    if (session.getAttribute("send-direction") != null) {
                        path = session.getAttribute("send-direction").toString();
                        session.removeAttribute("send-direction");
                    }
                }

                // Thiết lập cookie với HttpOnly và Secure
                Cookie cookie = new Cookie("token", jwtToken);
                cookie.setHttpOnly(true);
                cookie.setSecure(true); // Chỉ truyền qua HTTPS
                cookie.setPath("/");
                response.addCookie(cookie);

                response.sendRedirect(request.getContextPath() + path);
            } else {
                session.setAttribute("loginData", account);
                response.sendRedirect(request.getContextPath() + "/dang-nhap?action=login&message=username_password_invalid&alert=danger");
            }
        } else if (action != null && action.equals("register")) {
            CustomerRequest customerRequest = FormUtils.toModel(CustomerRequest.class, request);
            try {
                CustomerResponse customerResponse = accountService.save(customerRequest);
                if (customerResponse != null) {
                    boolean ok = accountService.sendOTPToEmail(customerResponse.getEmail(), customerResponse.getId(), "register");
                    if (ok) {
                        response.sendRedirect(request.getContextPath() + "/dang-ky?action=verify&id=" + Encode.forUriComponent(customerResponse.getId().toString()));
                    } else {
                        response.sendRedirect(request.getContextPath() + "/dang-nhap?action=register&message=send_otp_failed&alert=danger");
                    }
                }
            } catch (DuplicateFieldException e) {
                session.setAttribute("registrationData", customerRequest);
                String errorMessage;
                switch (e.getFieldName()) {
                    case "phone":
                        errorMessage = "duplicate_phone";
                        break;
                    case "email":
                        errorMessage = "duplicate_email";
                        break;
                    case "username":
                        errorMessage = "duplicate_username";
                        break;
                    default:
                        errorMessage = "duplicate_information";
                        break;
                }
                response.sendRedirect(request.getContextPath() + "/dang-nhap?action=register&message=" + errorMessage + "&alert=danger");
            }
        } else if (action != null && action.equals("verify")) {
            String otp = sanitizeInput(request.getParameter("otp"));
            String id = sanitizeInput(request.getParameter("id"));
            if (otp == null || !otp.matches("^\\d{6}$") || id == null || !id.matches("^\\d+$")) {
                response.sendRedirect(request.getContextPath() + "/dang-ky?action=verify&id=" + Encode.forUriComponent(id) + "&message=invalid_otp_or_id&alert=danger");
                return;
            }

            int count = accountService.verifyOTP(id, otp);
            if (count == 0) {
                response.sendRedirect(request.getContextPath() + "/dang-nhap?action=login&message=verify_success&alert=success");
            } else if (count == -1) {
                response.sendRedirect(request.getContextPath() + "/dang-ky?action=verify&id=" + Encode.forUriComponent(id) + "&message=verify_failed&alert=danger");
            } else if (count == -2) {
                response.sendRedirect(request.getContextPath() + "/dang-ky?action=verify&id=" + Encode.forUriComponent(id) + "&message=expired_otp&alert=danger");
            } else {
                response.sendRedirect(request.getContextPath() + "/dang-ky?action=verify&id=" + Encode.forUriComponent(id) + "&message=verify_retry&alert=danger");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }
}
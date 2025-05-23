package com.webecommerce.dto.request.other;

import org.owasp.encoder.Encode;

public class AccountRequest {
    private String userName;
    private String password;
    private String status;
    private String role;

    public String getUserName() {
        return Encode.forHtmlAttribute(userName);
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return Encode.forHtmlAttribute(password);
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getStatus() {
        return Encode.forHtmlAttribute(status);
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRole() {
        return Encode.forHtmlAttribute(role);
    }

    public void setRole(String role) {
        this.role = role;
    }
}

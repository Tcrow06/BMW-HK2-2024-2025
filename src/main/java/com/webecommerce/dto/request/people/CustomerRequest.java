package com.webecommerce.dto.request.people;

import org.owasp.encoder.Encode;

import javax.persistence.Column;

import org.owasp.encoder.Encode;

public class CustomerRequest extends UserRequest {
    private String ggID;
    private String fbID;
    private String userName;
    private String password;
    private String avatar;

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

    public String getGgID() {
        return Encode.forHtmlAttribute(ggID);
    }

    public void setGgID(String ggID) {
        this.ggID = ggID;
    }

    public String getFbID() {
        return Encode.forHtmlAttribute(fbID);
    }

    public void setFbID(String fbID) {
        this.fbID = fbID;
    }

    @Override
    public String getAvatar() {
        return Encode.forHtmlAttribute(avatar);
    }

    @Override
    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
}

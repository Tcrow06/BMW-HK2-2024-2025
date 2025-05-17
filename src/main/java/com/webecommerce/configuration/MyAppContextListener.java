package com.webecommerce.configuration;

import com.webecommerce.utils.HibernateUtil;
import com.zaxxer.hikari.HikariDataSource;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.sql.DataSource;

@WebListener // nếu dùng annotation, hoặc khai báo trong web.xml
public class MyAppContextListener implements ServletContextListener {


    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Log nếu cần
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Khi ứng dụng dừng (Tomcat stop hoặc reload), dọn tài nguyên
        HibernateUtil.shutdown();
    }
}


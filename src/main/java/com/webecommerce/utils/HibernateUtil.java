package com.webecommerce.utils;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class HibernateUtil {
    private static final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("ecommerce");

    public static EntityManagerFactory getEmFactory() {
        return emf;
    }

    // Thêm phương thức shutdown để đóng factory khi ứng dụng dừng
    public static void shutdown() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }

        // Dừng cleanup thread của MySQL JDBC nếu dùng MySQL
        com.mysql.cj.jdbc.AbandonedConnectionCleanupThread.checkedShutdown();
    }

}

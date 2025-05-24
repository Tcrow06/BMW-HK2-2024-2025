package com.webecommerce.utils;

import org.apache.commons.lang3.StringEscapeUtils;

public class StringUtils {
    public static String sanitizeInput(String input) {
        return StringEscapeUtils.escapeXml11(input);
    }

    public static String sanitizeXsltInput(String input) {
        if (input == null) {
            return "";
        }

        // Bước 1: Loại bỏ ký tự điều khiển và ký tự không hợp lệ trong XML
        input = input.replaceAll("[\\x00-\\x08\\x0B\\x0C\\x0E-\\x1F\\x7F-\\x84\\x86-\\x9F\\uFDD0-\\uFDEF\\uFFFE\\uFFFF]", "");

        // Bước 2: Loại bỏ các từ khóa và biểu thức XSLT nguy hiểm
        input = input.replaceAll("(?i)system-property|xsl:|vendor|document|value-of|select", "");

        // Bước 3: Loại bỏ ký tự nguy hiểm có thể dùng trong XSLT
        input = input.replaceAll("[<>\"'\\\\=\\(\\)\\[\\]\\{\\}\\$\\@\\!\\%\\*\\+\\|;]", "");

        // Bước 4: Chỉ cho phép ký tự số (vì category phải là số)
        input = input.replaceAll("[^0-9]", "");

        // Bước 5: Trim và escape XML
        return StringEscapeUtils.escapeXml11(input.trim());
    }

    public static String sanitizeXsltInput2(String input) {
        if (input == null) return "";

        // Bước 1: Loại bỏ ký tự điều khiển và ký tự không hợp lệ trong XML
        input = input.replaceAll("[\\x00-\\x08\\x0B\\x0C\\x0E-\\x1F\\x7F-\\x84\\x86-\\x9F\\uFDD0-\\uFDEF\\uFFFE\\uFFFF]", "");

        // Bước 2: Loại bỏ bất kỳ chuỗi nào liên quan đến XSLT hoặc XML
        // Loại bỏ thẻ XML và các đoạn mã có thể là XSLT
        input = input.replaceAll("(?i)<[^>]*>|xsl:[a-zA-Z0-9\\-]*|system-property|document|value-of|select", "");

        // Bước 3: Loại bỏ ký tự đặc biệt nguy hiểm có thể được sử dụng trong XSLT
        input = input.replaceAll("[\"'<>\\\\=\\(\\)\\[\\]\\{\\}\\$\\@\\!\\%\\*\\+\\|;]", "");

        // Bước 4: Chỉ cho phép các ký tự an toàn (whitelist approach)
        input = input.replaceAll("[^a-zA-Z0-9\\s-]", "");

        // Bước 5: Trim và escape XML
        input = StringEscapeUtils.escapeXml11(input.trim());

        // Bước 6: Giới hạn độ dài tối đa để tránh các payload dài bất thường
        if (input.length() > 50) {
            input = input.substring(0, 50);
        }

        return input;
    }

    public static String sanitizeXsltInputNumber(String input) {
        if (input == null) return "";

        // Bước 1: Loại bỏ ký tự điều khiển và ký tự không hợp lệ trong XML
        input = input.replaceAll("[\\x00-\\x08\\x0B\\x0C\\x0E-\\x1F\\x7F-\\x84\\x86-\\x9F\\uFDD0-\\uFDEF\\uFFFE\\uFFFF]", "");

        // Bước 2: Loại bỏ các từ khóa và biểu thức XSLT nguy hiểm
        input = input.replaceAll("(?i)system-property|xsl:|vendor|document|value-of|select", "");

        // Bước 3: Loại bỏ ký tự nguy hiểm có thể dùng trong XSLT
        input = input.replaceAll("[<>\"'\\\\=\\(\\)\\[\\]\\{\\}\\$\\@\\!\\%\\*\\+\\|;]", "");

        // Bước 4: Chỉ cho phép chữ số (vì maxPageItem là số)
        input = input.replaceAll("[^0-9]", "");

        // Bước 5: Trim và escape XML
        input = StringEscapeUtils.escapeXml11(input.trim());

        // Bước 6: Giới hạn độ dài tối đa
        if (input.length() > 10) {
            input = input.substring(0, 10);
        }

        return input;
    }

    public static String sanitizeXsltInputs(String input) {
        if (input == null) return null;
        // Chặn các hàm nguy hiểm trong XSLT
        String[] dangerousPatterns = {
                "xsl:", "document\\(", "system-property\\(", "xsl:value-of", "xsl:template", "xsl:stylesheet", "<", ">", "\"", "'"
        };
        String sanitized = input.toLowerCase();
        for (String pattern : dangerousPatterns) {
            sanitized = sanitized.replaceAll("(?i)" + pattern, ""); // loại bỏ bất kể hoa/thường
        }
        return sanitized;
    }

    public static Integer safeParseInteger(String input, int min, int max) {
        if (input == null || !input.matches("^\\d{1,10}$")) return null;
        try {
            int value = Integer.parseInt(input);
            if (value < min || value > max) return null;
            return value;
        } catch (NumberFormatException e) {
            return null;
        }
    }



}

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
        // Chỉ loại bỏ các ký tự nguy hiểm, không làm mất các ký tự số và dấu '-'
        input = input.replaceAll("[<>\"'\\\\]", "");
        return StringEscapeUtils.escapeXml11(input.trim());
    }
}

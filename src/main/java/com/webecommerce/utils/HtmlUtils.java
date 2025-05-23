package com.webecommerce.utils;

public class HtmlUtils {
    public static String escapeHtml(String input) {
        if (input == null) {
            return null;
        }

        return input.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#x27;");
    }
}

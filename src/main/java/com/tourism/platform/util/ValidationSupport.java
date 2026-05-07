package com.tourism.platform.util;

import java.util.regex.Pattern;

/** Shared guards for MVC forms backed by comma-separated storage. */
public final class ValidationSupport {

    private static final Pattern EMAIL = Pattern.compile("^[\\w.+-]+@[\\w.-]+\\.[a-zA-Z]{2,}$");
    private static final Pattern USERNAME = Pattern.compile("^[a-zA-Z0-9._-]{3,120}$");
    /** Optional SL-style numbers: spaces/dashes OK; 9–15 digits after cleanup. */
    private static final Pattern PHONE_DIGITS = Pattern.compile("^[0-9]{9,15}$");

    private ValidationSupport() {
    }

    public static boolean isBlank(String s) {
        return s == null || s.isBlank();
    }

    public static boolean nonBlank(String s) {
        return !isBlank(s);
    }

    public static boolean validEmail(String email) {
        if (isBlank(email) || email.length() > 160) {
            return false;
        }
        return EMAIL.matcher(email.trim()).matches();
    }

    public static boolean validUsername(String username) {
        if (isBlank(username)) {
            return false;
        }
        String t = username.trim();
        return USERNAME.matcher(t).matches();
    }

    /** Empty phone is OK; otherwise must compress to 9–15 digits. */
    public static boolean validOptionalPhone(String phone) {
        if (isBlank(phone)) {
            return true;
        }
        if (phone.length() > 60) {
            return false;
        }
        String digits = phone.trim().replaceAll("[^0-9]", "");
        return !digits.isEmpty() && PHONE_DIGITS.matcher(digits).matches();
    }

    public static boolean validPositivePriceLkr(double price) {
        return !Double.isNaN(price) && !Double.isInfinite(price) && price > 0;
    }

    public static boolean inRange(int rating, int min, int max) {
        return rating >= min && rating <= max;
    }

    public static String trimLen(String text, int maxLen) {
        if (text == null) {
            return "";
        }
        String t = text.trim();
        return t.length() <= maxLen ? t : t.substring(0, maxLen);
    }
}

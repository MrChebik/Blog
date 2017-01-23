package ru.mrchebik.session;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.List;

/**
 * Created by mrchebik on 14.01.17.
 */
@Component
@Scope("session")
public class UserSession {
    private static String code;
    private static int pages;
    private static int count = 10;
    private static String email;

    public static String getCode() {
        return code;
    }

    public static void setCode(String code) {
        UserSession.code = code;
    }

    public static int getPages() {
        return pages;
    }

    public static void setPages(List list, int count) {
        pages = BigDecimal.valueOf((double) list.size() / count).setScale(0, BigDecimal.ROUND_CEILING).intValue();
    }

    public static String getEmail() {
        return email;
    }

    public static void setEmail(String email) {
        UserSession.email = email;
    }

    public static int getCount() {
        return count;
    }

    public static void setCount(int count) {
        UserSession.count = count;
    }
}

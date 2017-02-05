package ru.mrchebik.session;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

/**
 * Created by mrchebik on 06.02.17.
 */
@Component
@Scope("session")
public class GuestSession {
    private static String code;
    private static String email;

    public static String getCode() {
        return code;
    }

    public static void setCode(String code) {
        GuestSession.code = code;
    }

    public static String getEmail() {
        return email;
    }

    public static void setEmail(String email) {
        GuestSession.email = email;
    }
}

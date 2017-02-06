package ru.mrchebik.session;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

/**
 * Created by mrchebik on 06.02.17.
 */
@Component
@Scope("session")
public class GuestSession {
    private String code;
    private String email;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}

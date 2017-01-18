package ru.mrchebik.service;

/**
 * Created by mrchebik on 15.01.17.
 */
public interface SecurityService {
    String findLoggedInUsername();
    void autologin(final String username, final String password);
}

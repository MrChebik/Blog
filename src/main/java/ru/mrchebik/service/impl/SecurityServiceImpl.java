package ru.mrchebik.service.impl;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import ru.mrchebik.service.SecurityService;

import javax.annotation.Resource;

/**
 * Created by mrchebik on 15.01.17.
 */
@Service
public class SecurityServiceImpl implements SecurityService {
    @Resource
    private AuthenticationManager authenticationManager;

    @Override
    public void autologin(final String username, final String password) {
        UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = new UsernamePasswordAuthenticationToken(username, password);
        Authentication authResult = authenticationManager.authenticate(usernamePasswordAuthenticationToken);

        if (authResult.isAuthenticated()) {
            SecurityContextHolder.getContext().setAuthentication(usernamePasswordAuthenticationToken);
        }
    }
}
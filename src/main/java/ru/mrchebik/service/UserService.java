package ru.mrchebik.service;

import org.springframework.security.access.prepost.PreAuthorize;
import ru.mrchebik.model.User;

/**
 * Created by mrchebik on 14.01.17.
 */
public interface UserService {
    User add(User user);

    @PreAuthorize("hasRole('ROLE_USER')")
    void changeUsername(String email, String username);

    void changePassword(String email, String password);

    @PreAuthorize("hasRole('ROLE_USER')")
    void changeEmail(String email, String newEmail);

    @PreAuthorize("hasRole('ROLE_USER')")
    User findOne(long userId);

    User findByEmail(String email);

    @PreAuthorize("hasRole('ROLE_USER')")
    User findByUsername(String username);

    @PreAuthorize("hasRole('ROLE_USER')")
    void remove(long id);
}

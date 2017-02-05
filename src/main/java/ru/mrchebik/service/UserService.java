package ru.mrchebik.service;

import ru.mrchebik.model.User;

import java.util.List;

/**
 * Created by mrchebik on 14.01.17.
 */
public interface UserService {
    User add(User user);
    void changeUsername(String email, String username);
    void changePassword(String email, String password);
    void changeEmail(String email, String newEmail);
    User findOne(long userId);
    User findByEmail(String email);
    User findByUsername(String username);
    List<User> findUsers();
    void remove(long id);
}

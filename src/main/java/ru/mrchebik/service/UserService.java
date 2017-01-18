package ru.mrchebik.service;

import ru.mrchebik.model.User;

import java.util.List;

/**
 * Created by mrchebik on 14.01.17.
 */
public interface UserService {
    User add(User user);
    void changePassword(String email, String password);
    User findByEmail(String email);
    User findUser(String username);
    List<User> findUsers();
    void remove(long id);
}

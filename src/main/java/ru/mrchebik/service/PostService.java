package ru.mrchebik.service;

import ru.mrchebik.model.Post;

import java.util.List;

/**
 * Created by mrchebik on 14.01.17.
 */
public interface PostService {
    Post add(Post post);
    List<Post> findPosts(long userId);
    void remove(long id);
}

package ru.mrchebik.service;

import ru.mrchebik.model.Post;

import java.util.List;

/**
 * Created by mrchebik on 14.01.17.
 */
public interface PostService {
    Post add(Post post);
    long findLastPostId(long userId);
    List<Post> findPosts(long userId);
    Post findPost(long postId);
    void remove(long id);
}

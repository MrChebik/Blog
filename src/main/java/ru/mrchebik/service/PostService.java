package ru.mrchebik.service;

import org.springframework.security.access.prepost.PreAuthorize;
import ru.mrchebik.model.Post;

import java.util.List;

/**
 * Created by mrchebik on 14.01.17.
 */
public interface PostService {
    @PreAuthorize("hasRole('ROLE_USER')")
    Post add(Post post);

    @PreAuthorize("hasRole('ROLE_USER')")
    long findLastPostId(long userId);

    @PreAuthorize("hasRole('ROLE_USER')")
    Post findPost(long postId);

    @PreAuthorize("hasRole('ROLE_USER')")
    List<Post> findPosts(long userId);

    @PreAuthorize("hasRole('ROLE_USER')")
    void remove(long id);
}

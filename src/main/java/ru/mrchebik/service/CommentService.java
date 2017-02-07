package ru.mrchebik.service;

import org.springframework.security.access.prepost.PreAuthorize;
import ru.mrchebik.model.Comment;

import java.util.List;

/**
 * Created by mrchebik on 14.01.17.
 */
public interface CommentService {
    @PreAuthorize("hasRole('ROLE_USER')")
    Comment addComment(Comment comment);

    @PreAuthorize("hasRole('ROLE_USER')")
    void editComment(Comment comment);

    @PreAuthorize("hasRole('ROLE_USER')")
    Comment findComment(long id);

    @PreAuthorize("hasRole('ROLE_USER')")
    List<Comment> findComments(long id);

    @PreAuthorize("hasRole('ROLE_USER')")
    void removeComment(long id);
}

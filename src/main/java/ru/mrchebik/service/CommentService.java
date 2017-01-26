package ru.mrchebik.service;

import ru.mrchebik.model.Comment;

import java.util.List;

/**
 * Created by mrchebik on 14.01.17.
 */
public interface CommentService {
    Comment addComment(Comment comment);
    void editComment(Comment comment);
    Comment findComment(long id);
    List<Comment> findComments(long id);
    void removeComment(long id);
}

package ru.mrchebik.service;

import ru.mrchebik.model.Comment;

import java.util.List;

/**
 * Created by mrchebik on 14.01.17.
 */
public interface CommentService {
    Comment addComment(Comment comment);
    List<Comment> findComments(long id);
}

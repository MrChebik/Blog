package ru.mrchebik.service.impl;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.mrchebik.model.Comment;
import ru.mrchebik.repository.CommentRepository;
import ru.mrchebik.service.CommentService;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by mrchebik on 26.01.17.
 */
@Service
@Repository
@Transactional
public class CommentServiceImpl implements CommentService {
    @Resource
    private CommentRepository commentRepository;

    @Override
    public Comment addComment(Comment comment) {
        return commentRepository.saveAndFlush(comment);
    }

    @Override
    public void editComment(Comment comment) {
        commentRepository.update(comment.getCommentId(), comment.getText());
    }

    @Override
    public Comment findComment(long id) {
        return commentRepository.findOne(id);
    }

    @Override
    public List<Comment> findComments(long postId) {
        return commentRepository.findByUser(postId);
    }

    @Override
    public void removeComment(long id) {
        commentRepository.delete(id);
    }
}

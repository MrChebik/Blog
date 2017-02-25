package ru.mrchebik.service.impl;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
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
@Transactional
public class CommentServiceImpl implements CommentService {
    @Resource
    private CommentRepository commentRepository;

    @Override
    @CacheEvict(value = "comments", allEntries = true)
    public Comment add(Comment comment) {
        return commentRepository.saveAndFlush(comment);
    }

    @Override
    public Comment findById(long id) {
        return commentRepository.findOne(id);
    }

    @Override
    @Cacheable("comments")
    public List<Comment> findComments(long postId) {
        return commentRepository.findByUser(postId);
    }

    @Override
    @CacheEvict(value = {"comments"}, allEntries = true)
    public void remove(long id) {
        commentRepository.delete(id);
    }
}

package ru.mrchebik.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.mrchebik.model.Comment;
import ru.mrchebik.repository.CommentRepository;
import ru.mrchebik.repository.UserRepository;
import ru.mrchebik.service.CommentService;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by mrchebik on 14.01.17.
 */
@Service
@Repository
@Transactional
public class CommentServiceImpl implements CommentService {
    @Autowired
    private CommentRepository commentRepository;
    @Autowired
    private UserRepository userRepository;

    @Override
    public Comment addComment(Comment comment) {
        return commentRepository.saveAndFlush(comment);
    }

    @Override
    public List<Comment> findComments(long postId) {
        List<Comment> comments = new ArrayList<>();
        for(Object[] object : commentRepository.findByUser(postId)) {
            long userId = Long.parseLong(String.valueOf(object[0]));
            long id = Long.parseLong(String.valueOf(object[1]));
            String text = String.valueOf(object[2]);
            Date date = (Date) object[3];

            comments.add(new Comment(userRepository.findOne(userId),id, text, date));
        }
        return comments;
    }
}

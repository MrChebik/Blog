package ru.mrchebik.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.mrchebik.model.Post;
import ru.mrchebik.repository.PostRepository;
import ru.mrchebik.service.PostService;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by mrchebik on 14.01.17.
 */
@Service
@Repository
@Transactional
public class PostServiceImpl implements PostService {
    @Autowired
    private PostRepository postRepository;

    @Override
    public Post add(Post post) {
        return postRepository.saveAndFlush(post);
    }

    @Override
    public List<Post> findPosts(long userId) {
        List<Post> posts = new ArrayList<>();
        for(Object[] object : postRepository.findByUser(userId)) {
            long id = Long.parseLong(String.valueOf(object[0]));
            String title = String.valueOf(object[1]);
            String text = String.valueOf(object[2]);
            Date date = (Date) object[3];

            posts.add(new Post(id, title, text, date));
        }
        return posts;
    }

    @Override
    public void remove(long id) {
        postRepository.delete(id);
    }
}

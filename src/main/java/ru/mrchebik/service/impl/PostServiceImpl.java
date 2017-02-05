package ru.mrchebik.service.impl;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.mrchebik.model.Post;
import ru.mrchebik.repository.PostRepository;
import ru.mrchebik.service.PostService;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by mrchebik on 14.01.17.
 */
@Service
@Repository
@Transactional
public class PostServiceImpl implements PostService {
    @Resource
    private PostRepository postRepository;

    @Override
    public Post add(Post post) {
        return postRepository.saveAndFlush(post);
    }

    @Override
    public long findLastPostId(long userId) {
        return postRepository.findLastPostId(userId);
    }

    @Override
    public List<Post> findPosts(long userId) {
        return postRepository.findByUser(userId);
    }

    @Override
    public Post findPost(long id) {
        return postRepository.findOne(id);
    }

    @Override
    public void remove(long id) {
        postRepository.delete(id);
    }
}

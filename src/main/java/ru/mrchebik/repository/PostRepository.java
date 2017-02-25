package ru.mrchebik.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import ru.mrchebik.model.Category;
import ru.mrchebik.model.Post;

import java.util.List;
import java.util.Set;

/**
 * Created by mrchebik on 14.01.17.
 */
@Repository
public interface PostRepository extends JpaRepository<Post, Long> {
    @Query("select post from ru.mrchebik.model.Post post where post.user.userId = :userId")
    List<Post> findByUser(@Param("userId") long id);

    @Query("select max(post.postId) from ru.mrchebik.model.Post post where post.user.userId = :userId")
    long findLastPostId(@Param("userId") long id);
}

package ru.mrchebik.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import ru.mrchebik.model.Comment;

import java.util.List;

/**
 * Created by mrchebik on 14.01.17.
 */
@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {
    @Query("select comment from ru.mrchebik.model.Comment comment where comment.post.postId = :postId")
    List<Comment> findByUser(@Param("postId") long id);
}

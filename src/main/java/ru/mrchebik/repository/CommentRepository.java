package ru.mrchebik.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import ru.mrchebik.model.Comment;

import java.util.List;

/**
 * Created by mrchebik on 14.01.17.
 */
public interface CommentRepository extends JpaRepository<Comment, Long> {
    @Query("select comment.user.userId, comment.commentId, comment.text, comment.date from ru.mrchebik.model.Comment comment where comment.post.postId = :postId")
    List<Object[]> findByUser(@Param("postId") long id);

    @Modifying
    @Query("update ru.mrchebik.model.Comment comment set comment.text = :text where comment.commentId = :commentId")
    void update(@Param("commentId") long id, @Param("text") String text);
}

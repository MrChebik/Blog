package ru.mrchebik.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.mrchebik.model.Comment;

/**
 * Created by mrchebik on 14.01.17.
 */
public interface CommentRepository extends JpaRepository<Comment, Long> {
}

package ru.mrchebik.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.mrchebik.model.Post;

/**
 * Created by mrchebik on 14.01.17.
 */
public interface PostRepository extends JpaRepository<Post, Long> {
}

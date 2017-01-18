package ru.mrchebik.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.mrchebik.model.Category;

/**
 * Created by mrchebik on 14.01.17.
 */
public interface CategoryRepository extends JpaRepository<Category, Long> {
}

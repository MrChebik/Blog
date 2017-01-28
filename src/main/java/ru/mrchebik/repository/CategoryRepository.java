package ru.mrchebik.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import ru.mrchebik.model.Category;

import java.util.List;

/**
 * Created by mrchebik on 14.01.17.
 */
public interface CategoryRepository extends JpaRepository<Category, Long> {
    @Query("select category.categoryId, category.name from ru.mrchebik.model.Category category where category.level = :level and category.parentId = :parentId and category.user.userId = :userId")
    List<Object[]> findByParentIdAndLevel(@Param("userId") long userId, @Param("parentId") long parentId, @Param("level") long level);

    @Query("select category.categoryId, category.name, category.level, category.parentId from ru.mrchebik.model.Category category where category.user.userId = :userId")
    List<Object[]> findAll(@Param("userId") long userId);
}

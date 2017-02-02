package ru.mrchebik.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import ru.mrchebik.model.Category;

import java.util.List;

/**
 * Created by mrchebik on 14.01.17.
 */
public interface CategoryRepository extends JpaRepository<Category, Long> {
    @Query("select category.categoryId, category.name, category.level, category.parentId from ru.mrchebik.model.Category category where category.user.userId = :userId")
    List<Object[]> findAll(@Param("userId") long userId);

    @Query("select max(category.level) from ru.mrchebik.model.Category category where category.user.userId = :userId")
    Object findMaxLevel(@Param("userId") long userId);

    @Query("select category.categoryId, category.name, category.level, category.parentId from ru.mrchebik.model.Category category where category.categoryId = :parentId and category.user.userId = :userId")
    List<Object[]> findByParentIdThroughCategoryId(@Param("parentId") long parentId, @Param("userId") long userId);

    @Query("select category.categoryId, category.name, category.level, category.parentId from ru.mrchebik.model.Category category where category.parentId = :parentId and category.user.userId = :userId")
    List<Object[]> findByParentId(@Param("parentId") long parentId, @Param("userId") long userId);
}

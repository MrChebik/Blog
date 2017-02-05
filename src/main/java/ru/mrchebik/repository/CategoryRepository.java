package ru.mrchebik.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import ru.mrchebik.model.Category;
import sun.plugin.cache.OldCacheEntry;

import java.util.List;

/**
 * Created by mrchebik on 14.01.17.
 */
public interface CategoryRepository extends JpaRepository<Category, Long> {
    @Query("select category from ru.mrchebik.model.Category category where category.user.userId = :userId")
    List<Category> findAll(@Param("userId") long userId);

    @Query("select max(category.level) from ru.mrchebik.model.Category category where category.user.userId = :userId")
    Object findMaxLevel(@Param("userId") long userId);

    @Query("select category from ru.mrchebik.model.Category category where category.categoryId = :parentId and category.user.userId = :userId")
    Category findByParentIdThroughCategoryId(@Param("parentId") long parentId, @Param("userId") long userId);

    @Query("select category from ru.mrchebik.model.Category category where category.parentId = :parentId and category.user.userId = :userId")
    List<Category> findByParentId(@Param("parentId") long parentId, @Param("userId") long userId);

    @Modifying
    @Query("update ru.mrchebik.model.Category category set category.name = :name where category.categoryId = :categoryId")
    void update(@Param("categoryId") long categoryId, @Param("name") String name);
}

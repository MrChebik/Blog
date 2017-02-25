package ru.mrchebik.service;

import org.springframework.security.access.prepost.PreAuthorize;
import ru.mrchebik.model.Category;

import java.util.List;

/**
 * Created by mrchebik on 14.01.17.
 */
public interface CategoryService {
    @PreAuthorize("hasRole('ROLE_USER')")
    Category add(Category category);

    @PreAuthorize("hasRole('ROLE_USER')")
    Category findById(long id);

    @PreAuthorize("hasRole('ROLE_USER')")
    Category findByParentIdThroughCategoryId(long parentId, long userId);

    @PreAuthorize("hasRole('ROLE_USER')")
    List<Category> findByParentId(long parentId, long userId);

    @PreAuthorize("hasRole('ROLE_USER')")
    List<Category> findAll(long userId);

    @PreAuthorize("hasRole('ROLE_USER')")
    void remove(long id);
}

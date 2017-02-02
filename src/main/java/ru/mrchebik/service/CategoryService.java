package ru.mrchebik.service;

import ru.mrchebik.model.Category;

import java.util.List;

/**
 * Created by mrchebik on 14.01.17.
 */
public interface CategoryService {
    void add(Category category);
    void edit(String name, long categoryId);
    Category findById(long id);
    Category findByParentIdThroughCategoryId(long parentId, long userId);
    List<Category> findByParentId(long parentId, long userId);
    List<Category> findAll(long userId);
    long findMaxLevel(long userId);
    void remove(long id);
}

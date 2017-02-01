package ru.mrchebik.service;

import ru.mrchebik.model.Category;

import java.util.List;

/**
 * Created by mrchebik on 14.01.17.
 */
public interface CategoryService {
    void add(Category category);
    Category findById(long id);
    Category findByParentId(long parentId, long userId);
    List<Category> findAll(long userId);
    long findMaxLevel(long userId);
    List<Category> findByParentIdAndLevel(long userId, long parentId, long level);
    void remove(long id);
}

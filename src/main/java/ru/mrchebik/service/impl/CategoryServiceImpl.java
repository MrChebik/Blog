package ru.mrchebik.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.mrchebik.model.Category;
import ru.mrchebik.repository.CategoryRepository;
import ru.mrchebik.service.CategoryService;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by mrchebik on 14.01.17.
 */
@Service
@Repository
@Transactional
public class CategoryServiceImpl implements CategoryService {
    @Autowired
    private CategoryRepository categoryRepository;

    @Override
    public void add(Category category) {
        categoryRepository.saveAndFlush(category);
    }

    @Override
    public Category findById(long id) {
        return categoryRepository.findOne(id);
    }

    @Override
    public Category findByParentId(long parntId, long userId) {
        Category category = null;
        for(Object[] object : categoryRepository.findByParentId(parntId, userId)) {
            long categoryId = Long.parseLong(String.valueOf(object[0]));
            String name = String.valueOf(object[1]);
            long level = Long.parseLong(String.valueOf(object[2]));
            long parentId = Long.parseLong(String.valueOf(object[3]));
            
            category = new Category(categoryId, level, name, parentId);
        }

        return category;
    }

    @Override
    public List<Category> findAll(long userId) {
        List<Category> categories = new ArrayList<>();
        for(Object[] object : categoryRepository.findAll(userId)) {
            long categoryId = Long.parseLong(String.valueOf(object[0]));
            String name = String.valueOf(object[1]);
            long level = Long.parseLong(String.valueOf(object[2]));
            long parentId = Long.parseLong(String.valueOf(object[3]));

            categories.add(new Category(categoryId, level, name, parentId));
        }
        return categories;
    }

    @Override
    public long findMaxLevel(long userId) {
        return (long) categoryRepository.findMaxLevel(userId);
    }

    @Override
    public List<Category> findByParentIdAndLevel(long userId, long parentId, long level) {
        List<Category> categories = new ArrayList<>();
        for(Object[] object : categoryRepository.findByParentIdAndLevel(userId, parentId, level)) {
            long categoryId = Long.parseLong(String.valueOf(object[0]));
            String name = String.valueOf(object[1]);

            categories.add(new Category(categoryId, level, name, parentId));
        }
        return categories;
    }

    @Override
    public void remove(long id) {
        categoryRepository.delete(id);
    }
}

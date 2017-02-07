package ru.mrchebik.service.impl;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.mrchebik.model.Category;
import ru.mrchebik.repository.CategoryRepository;
import ru.mrchebik.service.CategoryService;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by mrchebik on 14.01.17.
 */
@Service
@Repository
@Transactional
public class CategoryServiceImpl implements CategoryService {
    @Resource
    private CategoryRepository categoryRepository;

    @Override
    public void add(Category category) {
        categoryRepository.saveAndFlush(category);
    }

    @Override
    public void edit(String name, long categoryId) {
        categoryRepository.update(categoryId, name);
    }

    @Override
    public Category findById(long id) {
        return categoryRepository.findOne(id);
    }

    @Override
    public Category findByParentIdThroughCategoryId(long prntId, long userId) {
        return categoryRepository.findByParentIdThroughCategoryId(prntId, userId);
    }

    @Override
    public List<Category> findByParentId(long prntId, long userId) {
        return categoryRepository.findByParentId(prntId, userId);
    }

    @Override
    public List<Category> findAll(long userId) {
        return categoryRepository.findAll(userId);
    }

    @Override
    public void remove(long id) {
        categoryRepository.delete(id);
    }
}

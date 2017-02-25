package ru.mrchebik.service.impl;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
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
@Transactional
public class CategoryServiceImpl implements CategoryService {
    @Resource
    private CategoryRepository categoryRepository;

    @Override
    @CacheEvict(value = "categories", allEntries = true)
    public Category add(Category category) {
        return categoryRepository.saveAndFlush(category);
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
    @Cacheable("categories")
    public List<Category> findByParentId(long prntId, long userId) {
        return categoryRepository.findByParentId(prntId, userId);
    }

    @Override
    @Cacheable("categories")
    public List<Category> findAll(long userId) {
        return categoryRepository.findAll(userId);
    }

    @Override
    @CacheEvict(value = "categories", allEntries = true)
    public void remove(long id) {
        categoryRepository.delete(id);
    }


}

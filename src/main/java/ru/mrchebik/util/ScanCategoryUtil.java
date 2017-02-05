package ru.mrchebik.util;

import ru.mrchebik.model.Category;
import ru.mrchebik.model.Post;
import ru.mrchebik.service.CategoryService;

/**
 * Created by mrchebik on 05.02.17.
 */
public class ScanCategoryUtil {
    private static String path;

    public static String getPaths(CategoryService categoryService, Post post, long userId) {
        path = "";

        for (Category category : post.getCategory()) {
            String categoryPath = " > " + category.getName();
            long level = category.getLevel();
            long catParentId = category.getParentId();
            while (level != -1) {
                category = categoryService.findByParentIdThroughCategoryId(catParentId, userId);
                categoryPath = " > " + category.getName() + categoryPath;
                level = category.getLevel();
                catParentId = category.getCategoryId();
            }
            categoryPath = categoryPath.substring(3) + "<br>";
            path += categoryPath;
        }

        return path;
    }
}

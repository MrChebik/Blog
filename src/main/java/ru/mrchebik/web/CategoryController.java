package ru.mrchebik.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import ru.mrchebik.model.Category;
import ru.mrchebik.service.CategoryService;
import ru.mrchebik.session.UserSession;

import javax.annotation.Resource;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

/**
 * Created by mrchebik on 14.01.17.
 */
@Controller
@SessionAttributes("username")
@RequestMapping("/blog/categories")
public class CategoryController {
    @Resource
    private UserSession userSession;
    @Resource
    private CategoryService categoryService;

    @RequestMapping(value = "/{categoryId}", method = GET)
    public String getCategoriesPage(@PathVariable(required = false) String categoryId,
                                    @RequestParam(value = "hide", defaultValue = "1") int page,
                                    Model model) {
        String name = "/";
        long level = -1, parentId = -1;

        if (!categoryId.equals("-1")) {
            Category category = categoryService.findById(Long.parseLong(categoryId));
            level = category.getLevel() + 1;
            parentId = category.getCategoryId();

            int tempId = 0;
            int tempCatId = (int) Long.parseLong(categoryId);
            int temp = 0;
            String[] names = new String[(int) level + 2];
            while (tempId != -1) {
                category = categoryService.findById(tempCatId);
                names[temp] = category.getName();
                tempId = (int) category.getLevel();
                tempCatId = (int) category.getParentId();

                temp++;
            }
            for (int i = temp - 1; i >= 0; i--) {
                name += names[i] + "/";
            }
        }
        model.addAttribute("id", categoryId);
        List<Category> categories = new ArrayList<>(categoryService.findByParentId(parentId, userSession.getUser().getUserId()));

        userSession.setPages(categories, userSession.getCount());

        if (categories.size() > userSession.getCount()) {
            if (page * userSession.getCount() > categories.size()) {
                categories = categories.subList((page - 1) * userSession.getCount(), categories.size());
            } else {
                categories = categories.subList((page - 1) * userSession.getCount(), page * userSession.getCount());
            }
        }
        model.addAttribute("categories", categories);
        model.addAttribute("page", page);
        model.addAttribute("pages", userSession.getPages());
        model.addAttribute("name", name);
        model.addAttribute("level", level);
        model.addAttribute("parentId", parentId);

        return "Category";
    }

    @RequestMapping(value = "/add", method = POST)
    public String addCategory(@RequestParam(required = false) String id,
                                    @RequestParam(required = false) String level,
                                    @RequestParam String categoryName,
                                    @RequestParam(required = false) String parentId,
                                    Principal principal) {
        categoryService.add(new Category(userSession.getUser(), Long.parseLong(level), categoryName, Long.parseLong(parentId)));

        return "redirect:/blog/categories/" + id;
    }

    @RequestMapping(value = "/delete", method = GET)
    public String removeCategory(@RequestParam String id) {
        categoryService.remove(Long.parseLong(id));
        List<Category> categories = categoryService.findByParentId(Long.parseLong(id), userSession.getUser().getUserId());
        if (categories != null) {
            for (Category category : categories) {
                removeCategories(category, userSession.getUser().getUserId());
            }
        }

        return "redirect:/blog/categories/-1";
    }

    private void removeCategories(Category category, long userId) {
        categoryService.remove(category.getCategoryId());
        List<Category> categories = categoryService.findByParentId(category.getCategoryId(), userId);
        if (categories != null) {
            for (Category category0 : categories) {
                removeCategories(category0, userId);
            }
        }
    }

    @RequestMapping(value = "/edit", method = GET)
    public String removeCategory(@RequestParam String id,
                                 @RequestParam String name) {
        categoryService.edit(name, Long.parseLong(id));

        return "redirect:/blog/categories/-1";
    }
}

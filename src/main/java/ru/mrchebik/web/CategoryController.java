package ru.mrchebik.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

/**
 * Created by mrchebik on 14.01.17.
 */
@Controller
@RequestMapping("/blog/categories")
public class CategoryController {
    @RequestMapping(method = GET)
    public String getCategoriesPage(Model model) {
        return "Category";
    }
}

package ru.mrchebik.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

/**
 * Created by mrchebik on 14.01.17.
 */
@Controller
@RequestMapping("/blog")
public class BlogController {
    @RequestMapping(value = "/", method = GET)
    public String notes(Principal principal,
                        Model model) {
        model.addAttribute("username", principal.getName());
        return "Blog";
    }

}

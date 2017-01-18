package ru.mrchebik.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

/**
 * Created by mrchebik on 14.01.17.
 */
@Controller
@RequestMapping("/")
public class IndexController {
    @RequestMapping(method = GET)
    public String indexPage(@RequestParam(value = "error", required = false) String error,
                            @RequestParam(value = "logout", required = false) String logout,
                            Principal principal,
                            Model model) {
        if (principal != null) {
            model.addAttribute("principal", principal);
        }
        if (error != null) {
            model.addAttribute(error);
        }
        if (logout != null) {
            model.addAttribute(logout);
        }

        return "index";
    }
}

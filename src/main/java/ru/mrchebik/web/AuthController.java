package ru.mrchebik.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.mrchebik.model.User;
import ru.mrchebik.run.Run;
import ru.mrchebik.service.SecurityService;
import ru.mrchebik.service.UserService;
import ru.mrchebik.session.UserSession;

import javax.annotation.Resource;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

/**
 * Created by mrchebik on 14.01.17.
 */
@Controller
@RequestMapping("/auth")
public class AuthController {
    @Resource
    private UserService userService;
    @Resource
    private SecurityService securityService;

    @RequestMapping(value = "/register", method = GET)
    public String Get(Model model) {
        model.addAttribute("userForm", new User());
        return "SignUp";
    }

    @RequestMapping(value = "/register", method = POST)
    public String registration(@ModelAttribute("userForm") User userForm,
                               Model model) {
        try {
            userService.add(userForm);
        } catch (Exception e) {
            model.addAttribute("error", "SQLError");

            return "SignUp";
        }
        securityService.autologin(userForm.getUsername(), userForm.getPasswordConfirm());

        return "redirect:/blog/";
    }

    @RequestMapping(value = "/forgot", method = GET)
    public String GetPageForgot() {
        return "Forgot";
    }

    @RequestMapping(value = "/forgot", method = POST)
    public String sendDataToEmail(@RequestParam(value = "email") String email) {
        if (userService.findByEmail(email) != null) {
            new Thread(new Run(email)).start();
        }

        return "redirect:/auth/check";
    }

    @RequestMapping(value = "/check", method = GET)
    public String GetPageCheck() {
        return "CheckCode";
    }

    @RequestMapping(value = "/check", method = POST)
    public String checkCodeFromEmail(@RequestParam(value = "code") String code) {
        if (UserSession.getCode().equalsIgnoreCase(code)) {
            return "redirect:/auth/newPassword/" + UserSession.getCode();
        }

        return "redirect:/auth/forgot";
    }

    @RequestMapping(value = "/newPassword/{code}", method = GET)
    public String GetPagePassword() {
        return "NewPassword";
    }

    @RequestMapping(value = "/newPassword/{code}", method = POST)
    public String createANewPassword(@RequestParam(value = "password") String password,
                                     @PathVariable String code) {
        if (UserSession.getCode().equalsIgnoreCase(code)) {
            userService.changePassword(UserSession.getEmail(), password);
            User currentUser = userService.findByEmail(UserSession.getEmail());
            securityService.autologin(currentUser.getUsername(), currentUser.getPasswordConfirm());
        } else {
            return "redirect:/";
        }

        return "redirect:/blog/";
    }
}
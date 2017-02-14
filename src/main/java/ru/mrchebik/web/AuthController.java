package ru.mrchebik.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import ru.mrchebik.model.User;
import ru.mrchebik.run.Run;
import ru.mrchebik.service.UserService;
import ru.mrchebik.session.GuestSession;
import ru.mrchebik.util.RandomKeyUtil;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

/**
 * Created by mrchebik on 14.01.17.
 */
@Controller
@SessionAttributes("username")
@RequestMapping("/auth")
public class AuthController {
    @Resource
    private UserService userService;
    @Resource
    private GuestSession guestSession;

    @RequestMapping(value = "/register", method = POST)
    public String registration(@ModelAttribute("userForm") User userForm,
                               HttpServletRequest request,
                               Model model) throws ServletException {
        String password = userForm.getPassword();
        try {
            userService.add(userForm);
        } catch (Exception e) {
            return "redirect:/?error";
        }
        request.login(userForm.getUsername(), password);

        return "redirect:/blog/";
    }

    @RequestMapping(value = "/forgot", method = GET)
    public String GetPageForgot() {
        return "Forgot";
    }

    @RequestMapping(value = "/forgot", method = POST)
    public String sendDataToEmail(@RequestParam String email,
                                  Model model) {
        if (userService.findByEmail(email) != null) {
            guestSession.setEmail(email);
            guestSession.setCode(RandomKeyUtil.generateCode());

            new Thread(new Run(email, guestSession.getCode())).start();
        }
        model.addAttribute("code", "not-null");

        return "Forgot";
    }

    @RequestMapping(value = "/check", method = POST)
    public String checkCodeFromEmail(@RequestParam String code,
                                     Model model) {
        if (guestSession.getCode().equalsIgnoreCase(code)) {
            model.addAttribute("checkedCode", guestSession.getCode());
            model.addAttribute("password", "not-null");

            return "Forgot";
        }

        return "redirect:/";
    }

    @RequestMapping(value = "/newPassword/{code}", method = POST)
    public String createANewPassword(@RequestParam(value = "password") String password,
                                     @PathVariable String code,
                                     HttpServletRequest request) throws ServletException {
        if (guestSession.getCode().equalsIgnoreCase(code)) {
            userService.changePassword(guestSession.getEmail(), password);
            request.login(userService.findByEmail(guestSession.getEmail()).getUsername(), password);
        } else {
            return "redirect:/";
        }

        return "redirect:/blog/";
    }
}

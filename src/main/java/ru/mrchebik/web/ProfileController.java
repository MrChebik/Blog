package ru.mrchebik.web;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import ru.mrchebik.service.UserService;
import ru.mrchebik.session.UserSession;

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
@RequestMapping("/blog/setting")
public class ProfileController {
    @Resource
    private UserSession userSession;
    @Resource
    private UserService userService;
    @Resource
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @RequestMapping(value = "/", method = GET)
    public String getSettingPage() {
        return "Profile";
    }
    @RequestMapping(value = "/rename", method = POST)
    public String renameUser(@RequestParam String username,
                           Model model) throws ServletException {
        if (userService.findByUsername(username) == null) {
            userService.changeUsername(userSession.getUser().getEmail(), username);
            model.addAttribute("username", username);
            userSession.getUser().setUsername(username);
        }

        return "Profile";
    }

    @RequestMapping(value = "/password", method = POST)
    public String changePassword(@RequestParam String oldPassword,
                                 @RequestParam String newPassword) throws ServletException {
        if (bCryptPasswordEncoder.matches(oldPassword, userSession.getUser().getPassword())) {
            userService.changePassword(userSession.getUser().getEmail(), newPassword);
        }

        return "Profile";
    }

    @RequestMapping(value = "/email", method = POST)
    public String changeEmail(@RequestParam String newEmail) {
        userService.changeEmail(userSession.getUser().getEmail(), newEmail);

        return "Profile";
    }

    @RequestMapping(value = "/delete", method = GET)
    public String deleteUser(HttpServletRequest request) throws ServletException {
        userService.remove(userSession.getUser().getUserId());
        request.logout();

        return "redirect:/?logout";
    }
}

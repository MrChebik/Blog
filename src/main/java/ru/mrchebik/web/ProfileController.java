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
import java.security.Principal;

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
    public String getSettingPage(Principal principal,
                                 Model model) {
        model.addAttribute("username", principal.getName());

        return "Profile";
    }

    @RequestMapping(value = "/", method = POST)
    public String postSettingPage(@RequestParam(required = false) String username,
                                  @RequestParam(required = false) String oldPassword,
                                  @RequestParam(required = false) String oldPasswordUser,
                                  @RequestParam(required = false) String newPassword,
                                  @RequestParam(required = false) String email,
                                  @RequestParam String type,
                                  HttpServletRequest request,
                                  Model model) throws ServletException {
        if (type.equals("username")) {
            if (userService.findByUsername(username) == null) {
                userService.changeUsername(userSession.getUser().getEmail(), username);
                model.addAttribute("username", username);
                userSession.getUser().setUsername(username);
                request.login(username, oldPasswordUser);
            }
        } else if (type.equals("email")) {
            try {
                userService.changeEmail(userSession.getUser().getEmail(), email);
            } catch (Exception ignored) {
            }
        } else {
            if (bCryptPasswordEncoder.encode(oldPassword).equals(userSession.getUser().getPassword())) {
                userService.changePassword(userSession.getUser().getEmail(), newPassword);
            }
        }

        return "redirect:/blog/setting";
    }

    @RequestMapping(value = "/delete", method = GET)
    public String deleteUser(HttpServletRequest request) throws ServletException {
        userService.remove(userSession.getUser().getUserId());
        request.logout();

        return "redirect:/?logout";
    }
}

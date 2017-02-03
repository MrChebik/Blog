package ru.mrchebik.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.mrchebik.service.SecurityService;
import ru.mrchebik.service.UserService;

import javax.annotation.Resource;
import java.security.Principal;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

/**
 * Created by mrchebik on 14.01.17.
 */
@Controller
@RequestMapping("/blog")
public class ProfileController {
    @Resource
    private UserService userService;
    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;
    @Resource
    private SecurityService securityService;

    @RequestMapping(value = "/setting", method = GET)
    public String getSettingPage(Principal principal,
                                 Model model) {
        model.addAttribute("username", principal.getName());

        return "Profile";
    }

    @RequestMapping(value = "/setting", method = POST)
    public String postSettingPage(@RequestParam(required = false) String username,
                                  @RequestParam(required = false) String oldPassword,
                                  @RequestParam(required = false) String newPassword,
                                  @RequestParam(required = false) String email,
                                  @RequestParam String type,
                                  Principal principal,
                                  Model model) {
        if (type.equals("username")) {
            String password = userService.findUser(principal.getName()).getPassword();
            userService.changeUsername(userService.findUser(principal.getName()).getEmail(), username);
            securityService.autologin(username, password);
        } else if (type.equals("email")) {
            try {
                userService.changeEmail(userService.findUser(principal.getName()).getEmail(), email);
            } catch (Exception ignored) {
            }
        } else {
            if (bCryptPasswordEncoder.encode(oldPassword).equals(userService.findUser(principal.getName()).getPassword())) {
                userService.changePassword(userService.findUser(principal.getName()).getEmail(), newPassword);
            }
        }

        return "redirect:/blog/setting";
    }
}

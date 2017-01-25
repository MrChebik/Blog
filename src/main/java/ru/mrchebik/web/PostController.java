package ru.mrchebik.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.mrchebik.model.Post;
import ru.mrchebik.service.PostService;
import ru.mrchebik.service.UserService;

import javax.annotation.Resource;
import java.security.Principal;
import java.util.Date;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

/**
 * Created by mrchebik on 14.01.17.
 */
@Controller
@RequestMapping("/blog/post")
public class PostController {
    @Resource
    private PostService postService;
    @Resource
    private UserService userService;

    @RequestMapping(value = "/add", method = GET)
    public String addPage() {
        return "AddPost";
    }

    @RequestMapping(value = "/add", method = POST)
    public String addPost(@RequestParam String title,
                          @RequestParam String text,
                          Principal principal) {
        postService.add(new Post(userService.findUser(principal.getName()), title, text, new Date()));

        return "redirect:/blog/";
    }
}

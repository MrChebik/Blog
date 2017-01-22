package ru.mrchebik.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.mrchebik.model.Post;
import ru.mrchebik.service.PostService;
import ru.mrchebik.service.UserService;
import ru.mrchebik.session.UserSession;

import javax.annotation.Resource;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

/**
 * Created by mrchebik on 14.01.17.
 */
@Controller
@RequestMapping("/blog")
public class BlogController {
    @Resource
    private PostService postService;
    @Resource
    private UserService userService;

    @RequestMapping(value = "/", method = GET)
    public String notes(@RequestParam(value = "hide", defaultValue = "1") int page,
                        @RequestParam(value = "hideId", defaultValue = "0") long id,
                        Principal principal,
                        Model model) {
        List<Post> posts = new ArrayList<>(postService.findPosts(userService.findUser(principal.getName()).getUserId()));

        if (id != 0) {
            if (page != 1 &&
                    page == UserSession.getPages() &&
                    (UserSession.getPages() * UserSession.getCount()) - 9 == posts.size() &&
                    posts.get(posts.size() - 1).getPostId() == id) {
                page--;
                posts.remove(posts.size() - 1);
            }

            for (int i = 0; i < posts.size(); i++) {
                if (posts.get(i).getPostId() == id) {
                    posts.remove(i);
                    break;
                }
            }
            postService.remove(id);
        }

        UserSession.setPages(posts, UserSession.getCount());

        if (posts.size() > UserSession.getCount()) {
            if (page * UserSession.getCount() > posts.size()) {
                posts = posts.subList((page - 1) * UserSession.getCount(), posts.size());
            } else {
                posts = posts.subList((page - 1) * UserSession.getCount(), page * UserSession.getCount());
            }
        }
        model.addAttribute("username", principal.getName());
        model.addAttribute("posts", posts);
        model.addAttribute("page", page);
        model.addAttribute("pages", UserSession.getPages());

        return "Blog";
    }

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

    @RequestMapping(value = "/{username}/post/{id}", method = GET)
    public String postPage(@PathVariable long id,
                           @PathVariable String username,
                           Model model) {
        model.addAttribute("username", username);
        model.addAttribute("post", postService.findPost(id));

        return "Post";
    }
}

package ru.mrchebik.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.mrchebik.model.Post;
import ru.mrchebik.model.Reader;
import ru.mrchebik.service.PostService;
import ru.mrchebik.service.ReaderService;
import ru.mrchebik.service.UserService;
import ru.mrchebik.session.UserSession;

import javax.annotation.Resource;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

/**
 * Created by mrchebik on 14.01.17.
 */
@Controller
@RequestMapping("/")
public class IndexController {
    @Resource
    private PostService postService;
    @Resource
    private UserService userService;
    @Resource
    private ReaderService readerService;

    @RequestMapping(value = {"", "blog/news"}, method = GET)
    public String indexPage(@PathVariable(required = false) String username,
                            @RequestParam(value = "hide", defaultValue = "1") int page,
                            @RequestParam(value = "hideId", defaultValue = "0") long id,
                            @RequestParam(value = "error", required = false) String error,
                            @RequestParam(value = "logout", required = false) String logout,
                            Principal principal,
                            Model model) {
        if (principal != null) {
            model.addAttribute("principal", principal);

            List<Post> posts = new ArrayList<>();

            for (Reader reader : readerService.findAllFollower(userService.findUser(principal.getName()).getUserId())) {
                List<Post> tempPosts = new ArrayList<>();
                for (Post post : postService.findPosts(reader.getUser().getUserId())) {
                    tempPosts.add(post);
                }
                posts.addAll(tempPosts);
            }

            Collections.sort(posts);

            UserSession.setPages(posts, UserSession.getCount());

            if (posts.size() > UserSession.getCount()) {
                if (page * UserSession.getCount() > posts.size()) {
                    posts = posts.subList((page - 1) * UserSession.getCount(), posts.size());
                } else {
                    posts = posts.subList((page - 1) * UserSession.getCount(), page * UserSession.getCount());
                }
            }
            model.addAttribute("userBlog", username);

            model.addAttribute("username", principal.getName());
            for (Post post : posts) {
                if (post.getText().length() > 500) {
                    post.setText(post.getText().substring(0, 500) + "...");
                }
            }
            model.addAttribute("posts", posts);
            model.addAttribute("page", page);
            model.addAttribute("pages", UserSession.getPages());
        }
        if (error != null) {
            model.addAttribute(error);
        }
        if (logout != null) {
            model.addAttribute(logout);
        }

        return "News";
    }
}

package ru.mrchebik.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import ru.mrchebik.model.Post;
import ru.mrchebik.model.Reader;
import ru.mrchebik.model.User;
import ru.mrchebik.service.PostService;
import ru.mrchebik.service.ReaderService;
import ru.mrchebik.session.UserSession;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

/**
 * Created by mrchebik on 14.01.17.
 */
@Controller
@SessionAttributes("username")
@RequestMapping("/")
public class IndexController {
    @Resource
    private UserSession userSession;
    @Resource
    private PostService postService;
    @Resource
    private ReaderService readerService;

    @RequestMapping(value = {"", "blog/news"}, method = GET)
    public String indexPage(@PathVariable(required = false) String username,
                            @RequestParam(defaultValue = "1") int page,
                            @RequestParam(value = "error", required = false) String error,
                            @RequestParam(value = "errorReg", required = false) String errorReg,
                            @RequestParam(value = "logout", required = false) String logout,
                            Model model) {
        if (userSession.getUser() != null) {
            model.addAttribute("principal", "true");

            List<Post> posts = new ArrayList<>();

            for (Reader reader : readerService.findAllFollower(userSession.getUser().getUserId())) {
                List<Post> tempPosts = new ArrayList<>();
                for (Post post : postService.findPosts(reader.getUser().getUserId())) {
                    tempPosts.add(post);
                }
                posts.addAll(tempPosts);
            }

            Collections.sort(posts);

            userSession.setPages(posts, userSession.getCount());

            if (posts.size() > userSession.getCount()) {
                if (page * userSession.getCount() > posts.size()) {
                    posts = posts.subList((page - 1) * userSession.getCount(), posts.size());
                } else {
                    posts = posts.subList((page - 1) * userSession.getCount(), page * userSession.getCount());
                }
            }
            model.addAttribute("userBlog", username);

            for (Post post : posts) {
                if (post.getText().length() > 500) {
                    post.setText(post.getText().substring(0, 500) + "...");
                }
            }
            model.addAttribute("posts", posts);
            model.addAttribute("page", page);
            model.addAttribute("pages", userSession.getPages());
        }
        if (error != null) {
            model.addAttribute(error);
        }
        if (errorReg != null) {
            model.addAttribute(errorReg);
        }
        if (logout != null) {
            model.addAttribute(logout);
        }

        model.addAttribute("userForm", new User());

        return "News";
    }
}

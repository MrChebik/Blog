package ru.mrchebik.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import ru.mrchebik.model.Comment;
import ru.mrchebik.model.Post;
import ru.mrchebik.model.Reader;
import ru.mrchebik.service.*;
import ru.mrchebik.session.UserSession;
import ru.mrchebik.util.ScanCategoryUtil;

import javax.annotation.Resource;
import java.security.Principal;
import java.util.*;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

/**
 * Created by mrchebik on 14.01.17.
 */
@Controller
@SessionAttributes("username")
@RequestMapping("/blog")
public class BlogController {
    @Resource
    private UserSession userSession;
    @Resource
    private PostService postService;
    @Resource
    private UserService userService;
    @Resource
    private CommentService commentService;
    @Resource
    private CategoryService categoryService;
    @Resource
    private ReaderService readerService;

    @RequestMapping(value = { "", "/{username}" }, method = GET)
    public String notes(@PathVariable(required = false) String username,
                        @RequestParam(defaultValue = "1") int page,
                        Principal principal,
                        Model model) {
        if (userSession.getUser() == null) {
            userSession.setUser(userService.findByUsername(principal.getName()));
        }

        List<Post> posts = new ArrayList<>(postService.findPosts(username != null ? userService.findByUsername(username).getUserId() : userSession.getUser().getUserId()));
        userSession.setPages(posts, userSession.getCount());

        if (posts.size() > userSession.getCount()) {
            if (page * userSession.getCount() > posts.size()) {
                posts = posts.subList((page - 1) * userSession.getCount(), posts.size());
            } else {
                posts = posts.subList((page - 1) * userSession.getCount(), page * userSession.getCount());
            }
        }

        if (username != null) {
            Map<Long, String> categoriesPath = new HashMap<>();
            for (Post post : posts) {
                try {
                    categoriesPath.put(post.getPostId(), ScanCategoryUtil.getPaths(categoryService, post, userSession.getUser().getUserId()));
                } catch (NoSuchElementException ignored) {
                }
            }
            model.addAttribute("categoriesPath", categoriesPath);

            try {
                if (readerService.findOne(userService.findByUsername(username).getUserId(), userSession.getUser().getUserId()) == null) {
                    model.addAttribute("subscribe", "false");
                } else {
                    model.addAttribute("subscribe", "true");
                }
            } catch (NullPointerException ignored) {
            }
        }

        for (Post post : posts) {
            if (post.getText().length() > 500) {
                post.setText(post.getText().substring(0, 500) + "...");
            }
        }

        model.addAttribute("userBlog", username);
        model.addAttribute("username", userSession.getUser().getUsername());
        model.addAttribute("posts", posts);
        model.addAttribute("page", page);
        model.addAttribute("pages", userSession.getPages());

        if (username != null) {
            return "BlogGlobal";
        } else {
            return "Blog";
        }
    }

    @RequestMapping(value = "/{username}/post/{id}", method = GET)
    public String postPage(@PathVariable String id,
                           @PathVariable String username,
                           @RequestParam(defaultValue = "1") int page,
                           Model model) {
        int idFromString = Integer.parseInt(id);

        model.addAttribute("username0", username);
        model.addAttribute("user", userSession.getUser());

        Post post = postService.findPost(idFromString);
        model.addAttribute("post", post);

        try {
            model.addAttribute("categoryPath", ScanCategoryUtil.getPaths(categoryService, post, userSession.getUser().getUserId()));
        } catch (NoSuchElementException ignored) {
        }

        List<Comment> comments = new ArrayList<>(commentService.findComments(idFromString));

        userSession.setPages(comments, 20);

        if (comments.size() > 20) {
            if (page * 20 > comments.size()) {
                comments = comments.subList((page - 1) * 20, comments.size());
            } else {
                comments = comments.subList((page - 1) * 20, page * 20);
            }
        }

        model.addAttribute("comments", comments);
        model.addAttribute("category", postService.findPost(idFromString).getCategory());
        model.addAttribute("page", page);
        model.addAttribute("pages", userSession.getPages());

        return "Post";
    }

    @RequestMapping(value = "/{username}/post/{id}", method = POST)
    public String addComment(@PathVariable String id,
                             @PathVariable String username,
                             @RequestParam String text,
                             @RequestParam int page) {
        commentService.addComment(new Comment(userSession.getUser(), postService.findPost(Integer.parseInt(id)), text, new Date()));

        return "redirect:/blog/" + username + "/post/" + id + "?page=" + page;
    }

    @RequestMapping(value = "/{username}/subscribe", method = GET)
    public String subscribe(@PathVariable String username) {
        readerService.add(new Reader(userSession.getUser().getUserId(), userService.findByUsername(username)));

        return "redirect:/blog/" + username + "/";
    }

    @RequestMapping(value = "/{username}/unsubscribe", method = GET)
    public String unsubscribe(@PathVariable String username) {
        readerService.delete(readerService.findOne(userService.findByUsername(username).getUserId(), userSession.getUser().getUserId()).getId());

        return "redirect:/blog/" + username + "/";
    }
}

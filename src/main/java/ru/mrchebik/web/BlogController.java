package ru.mrchebik.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.mrchebik.model.Comment;
import ru.mrchebik.model.Post;
import ru.mrchebik.service.CommentService;
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
    @Resource
    private CommentService commentService;

    @RequestMapping(value = { "/", "/{username}" }, method = GET)
    public String notes(@PathVariable(required = false) String username,
                        @RequestParam(value = "hide", defaultValue = "1") int page,
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

        if (username != null) {
            return "BlogGlobal";
        } else {
            return "Blog";
        }
    }

    @RequestMapping(value = "/{username}/post/{id}", method = GET)
    public String postPage(@PathVariable String id,
                           @PathVariable String username,
                           @RequestParam(value = "hide", defaultValue = "1") int page,
                           @RequestParam(value = "hideId", defaultValue = "0") long commentId,
                           Principal principal,
                           Model model) {
        int idFromString = Integer.parseInt(id);

        model.addAttribute("username", username);
        try {
            model.addAttribute("user", userService.findUser(principal.getName()));
        } catch (Exception ignored) {
        }
        model.addAttribute("post", postService.findPost(idFromString));

        List<Comment> comments = new ArrayList<>(commentService.findComments(idFromString));

        if (commentId != 0) {
            if (page != 1 &&
                    page == UserSession.getPages() &&
                    (UserSession.getPages() * 20) - 19 == comments.size() &&
                    comments.get(comments.size() - 1).getCommentId() == commentId) {
                page--;
                comments.remove(comments.size() - 1);
            }

            for (int i = 0; i < comments.size(); i++) {
                if (comments.get(i).getCommentId() == commentId) {
                    comments.remove(i);
                    break;
                }
            }
            postService.remove(commentId);
        }

        UserSession.setPages(comments, 20);

        if (comments.size() > 20) {
            if (page * 20 > comments.size()) {
                comments = comments.subList((page - 1) * 20, comments.size());
            } else {
                comments = comments.subList((page - 1) * 20, page * 20);
            }
        }
        model.addAttribute("comments", comments);
        model.addAttribute("page", page);
        model.addAttribute("pages", UserSession.getPages());

        return "Post";
    }

    @RequestMapping(value = "/{username}/post/{id}", method = POST)
    public String addComment(@PathVariable String id,
                             @PathVariable String username,
                             @RequestParam String text,
                             @RequestParam(value = "hide") int page,
                             Principal principal) {
        commentService.addComment(new Comment(userService.findUser(principal.getName()), postService.findPost(Integer.parseInt(id)), text, new Date()));

        return "redirect:/blog/" + username + "/post/" + id + "?hide=" + page;
    }
}

package ru.mrchebik.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.mrchebik.model.Category;
import ru.mrchebik.model.Comment;
import ru.mrchebik.model.Post;
import ru.mrchebik.model.Reader;
import ru.mrchebik.run.Run;
import ru.mrchebik.service.*;
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
@RequestMapping("/blog/post")
public class PostController {
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

    @RequestMapping(value = "/add", method = GET)
    public String addPage(Principal principal,
                          Model model) {
        if (principal != null) {
            model.addAttribute("Username", principal.getName());

            List<Category> categories = new ArrayList<>(categoryService.findAll(userService.findUser(principal.getName()).getUserId()));
            model.addAttribute("categories", categories);

            try {
                model.addAttribute("maxLevel", categoryService.findMaxLevel(userService.findUser(principal.getName()).getUserId()));
            } catch (NullPointerException e) {
                model.addAttribute("maxLevel", -2);
            }
        }

        return "AddPost";
    }

    @RequestMapping(value = "/add", method = POST)
    public String addPost(@RequestParam String title,
                          @RequestParam String text,
                          @RequestParam String catId,
                          Principal principal) {
        if (catId.equals("")) {
            postService.add(new Post(userService.findUser(principal.getName()), title, text, new Date()));
        } else {
            postService.add(new Post(userService.findUser(principal.getName()), categoryService.findById(Long.parseLong(catId)), title, text, new Date()));
        }

        long postId = postService.findLastPostId(userService.findUser(principal.getName()).getUserId());
        for (Reader reader : readerService.findAllMain(userService.findUser(principal.getName()).getUserId())) {
            new Thread(new Run(userService.findOne(reader.getReaderId()).getEmail(), "/blog/" + UserSession.getUsername() + "/post/" + postId)).start();
        }

        return "redirect:/blog/";
    }

    @RequestMapping(value = "{id}/edit", method = GET)
    public String editPage(@PathVariable String id,
                           Model model) {
        model.addAttribute("post", postService.findPost(Integer.parseInt(id)));

        return "AddPost";
    }

    @RequestMapping(value = "{id}/edit", method = POST)
    public String saveEdit(@PathVariable String id,
                           @RequestParam String title,
                           @RequestParam String text) {
        postService.update(new Post(Integer.parseInt(id), title, text));

        return "redirect:/blog/";
    }

    @RequestMapping(value = "{id}/remove", method = GET)
    public String removePost(@PathVariable String id) {
        postService.remove(Integer.parseInt(id));

        return "redirect:/blog/";
    }

    @RequestMapping(value = "{id}/comment/{commentId}/edit", method = GET)
    public String editCommentPage(@PathVariable String id,
                                  @PathVariable String commentId,
                                  Model model) {
        model.addAttribute("post", postService.findPost(Integer.parseInt(id)));
        model.addAttribute("commentText", commentService.findComment(Integer.parseInt(commentId)).getText());

        return "Post";
    }

    @RequestMapping(value = "{id}/comment/{commentId}/edit", method = POST)
    public String saveEditComment(@PathVariable String commentId,
                                  @RequestParam String text) {
        commentService.editComment(new Comment(Integer.parseInt(commentId), text));

        return "redirect:/blog/";
    }

    @RequestMapping(value = "{id}/comment/{commentId}/remove", method = GET)
    public String removeComment(@PathVariable String commentId) {
        commentService.removeComment(Integer.parseInt(commentId));

        return "redirect:/blog/";
    }
}

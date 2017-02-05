package ru.mrchebik.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import ru.mrchebik.model.Category;
import ru.mrchebik.model.Comment;
import ru.mrchebik.model.Post;
import ru.mrchebik.model.Reader;
import ru.mrchebik.run.Run;
import ru.mrchebik.service.*;
import ru.mrchebik.session.UserSession;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

/**
 * Created by mrchebik on 14.01.17.
 */
@Controller
@SessionAttributes("username")
@RequestMapping("/blog/post")
public class PostController {
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

    @RequestMapping(value = "/add", method = GET)
    public String addPage(Model model) {
        model.addAttribute("categories", categoryService.findAll(userSession.getUser().getUserId()));

        return "AddPost";
    }

    @RequestMapping(value = "/add", method = POST)
    public String addPost(@RequestParam String categoriesId,
                          @RequestParam String title,
                          @RequestParam String text) {
        if (categoriesId.equals("")) {
            postService.add(new Post(userSession.getUser(), title, text, new Date()));
        } else {
            List<Category> categories = new ArrayList<>();
            for (String category : categoriesId.split(",")) {
                categories.add(categoryService.findById(Long.parseLong(category)));
            }
            postService.add(new Post(userSession.getUser(), categories, title, text, new Date()));
        }

        long postId = postService.findLastPostId(userSession.getUser().getUserId());
        for (Reader reader : readerService.findAllMain(userSession.getUser().getUserId())) {
            new Thread(new Run(userService.findOne(reader.getReaderId()).getEmail(), "/blog/" + userSession.getUser().getUsername() + "/post/" + postId)).start();
        }

        return "redirect:/blog/";
    }

    @RequestMapping(value = "{id}/edit", method = GET)
    public String editPage(@PathVariable String id,
                           Model model) {
        model.addAttribute("post", postService.findPost(Integer.parseInt(id)));
        model.addAttribute("categories", categoryService.findAll(userSession.getUser().getUserId()));

        return "AddPost";
    }

    @RequestMapping(value = "{id}/edit", method = POST)
    public String saveEdit(@PathVariable String id,
                           @RequestParam String categoriesId,
                           @RequestParam String title,
                           @RequestParam String text) {
        Post post = postService.findPost(Long.parseLong(id));
        post.getCategory().clear();
        post.setTitle(title);
        post.setText(text);
        if (!categoriesId.equals("")) {
            for (String category : categoriesId.split(",")) {
                post.getCategory().add(categoryService.findById(Long.parseLong(category)));
            }
        }
        postService.add(post);

        return "redirect:/blog/";
    }

    @RequestMapping(value = "{id}/remove", method = GET)
    public String removePost(@PathVariable String id) {
        postService.remove(Long.parseLong(id));

        return "redirect:/blog/";
    }

    @RequestMapping(value = "{postId}/comment/edit", method = GET)
    public String editCommentPage(@RequestParam String id,
                                  @PathVariable String postId,
                                  Model model) {
        model.addAttribute("post", postService.findPost(Long.parseLong(postId)));
        model.addAttribute("commentEdit", commentService.findComment(Long.parseLong(id)));

        return "Post";
    }

    @RequestMapping(value = "{postId}/comment/edit", method = POST)
    public String saveEditComment(@PathVariable String postId,
                                  @RequestParam String id,
                                  @RequestParam String text,
                                  @RequestParam String username) {
        commentService.editComment(new Comment(Long.parseLong(id), text));

        return "redirect:/blog/" + username + "/post/" + postId;
    }

    @RequestMapping(value = "{postId}/comment/remove", method = GET)
    public String removeComment(@RequestParam String username,
                                @RequestParam String id,
                                @PathVariable String postId) {
        commentService.removeComment(Long.parseLong(id));

        return "redirect:/blog/" + username + "/post/" + postId;
    }
}

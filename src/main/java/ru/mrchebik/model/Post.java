package ru.mrchebik.model;

import javax.persistence.*;
import java.util.Date;
import java.util.Set;

/**
 * Created by mrchebik on 14.01.17.
 */
@Entity
@Table(name = "posts")
public class Post {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(unique = true)
    private long postId;

    @Column(nullable = false, length = 25)
    private String title;

    @Column(nullable = false, length = 30000)
    private String text;

    @ManyToMany
    @JoinTable(name = "category_post", joinColumns = @JoinColumn(name = "categoryId"), inverseJoinColumns = @JoinColumn(name = "postId"))
    private Set<Category> categories;

    @Column(nullable = false)
    private Date date;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId", nullable = false)
    private User user;

    @OneToMany(fetch = FetchType.LAZY, orphanRemoval = true)
    private Set<Comment> comments;

    public Post() {
    }

    public Post(User user, String title, String text, Date date) {
        this.user = user;
        this.title = title;
        this.text = text;
        this.date = date;
    }

    public Post(long postId, String title, String text, Date date) {
        this.postId = postId;
        this.title = title;
        this.text = text;
        this.date = date;
    }

    public Post(long postId, String title, String text) {
        this.postId = postId;
        this.title = title;
        this.text = text;
    }

    public long getPostId() {
        return postId;
    }

    public void setPostId(long postId) {
        this.postId = postId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Set<Comment> getComments() {
        return comments;
    }

    public void setComments(Set<Comment> comments) {
        this.comments = comments;
    }

    public Set<Category> getCategory() {
        return categories;
    }

    public void setCategory(Set<Category> category) {
        this.categories = category;
    }
}

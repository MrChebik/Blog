package ru.mrchebik.model;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by mrchebik on 14.01.17.
 */
@Entity
@Table(name = "comments")
public class Comment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(unique = true)
    private long commentId;

    @Column(nullable = false)
    private String text;

    @Column(nullable = false)
    private Date date;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "postId", nullable = false)
    private Post post;

    public Comment() {
    }

    public Comment(User user, long commentId, String text, Date date) {
        this.user = user;
        this.commentId = commentId;
        this.text = text;
        this.date = date;
    }

    public Comment(User user, Post post, String text, Date date) {
        this.user = user;
        this.post = post;
        this.text = text;
        this.date = date;
    }

    public Comment(long id, String text) {
        this.commentId = id;
        this.text = text;
    }

    public long getCommentId() {
        return commentId;
    }

    public void setCommentId(long commentId) {
        this.commentId = commentId;
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

    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
    }
}

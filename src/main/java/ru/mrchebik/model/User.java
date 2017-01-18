package ru.mrchebik.model;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by mrchebik on 14.01.17.
 */
@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(unique = true, nullable = false)
    private long userId;

    @Column(unique = true, nullable = false, length = 60)
    private String username;

    @Column(nullable = false, length = 60)
    private String password;

    private String passwordConfirm;

    @Column(unique = true, nullable = false, length = 60)
    private String email;

    @OneToMany(fetch = FetchType.LAZY, orphanRemoval = true)
    private Set<Post> posts = new HashSet<Post>(0);

    @ManyToMany
    @JoinTable(name = "user_role", joinColumns = @JoinColumn(name = "userId"), inverseJoinColumns = @JoinColumn(name = "roleId"))
    private Set<Role> roles;

    @ManyToMany
    @JoinTable(name = "post_comment", joinColumns = @JoinColumn(name = "postId"), inverseJoinColumns = @JoinColumn(name = "commentId"))
    private Set<Comment> comments;

    @OneToMany(fetch = FetchType.LAZY, orphanRemoval = true)
    private Set<Reader> readers;

    public User() {
    }

    public User(String email, String username, String password) {
        this.email = email;
        this.username = username;
        this.password = password;
        this.passwordConfirm = password;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPasswordConfirm() {
        return passwordConfirm;
    }

    public void setPasswordConfirm(String passwordConfirm) {
        this.passwordConfirm = passwordConfirm;
    }

    public Set<Post> getPosts() {
        return posts;
    }

    public void setPosts(Set<Post> posts) {
        this.posts = posts;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }

    public Set<Comment> getComments() {
        return comments;
    }

    public void setComments(Set<Comment> comments) {
        this.comments = comments;
    }

    public Set<Reader> getReaders() {
        return readers;
    }

    public void setReaders(Set<Reader> readers) {
        this.readers = readers;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}

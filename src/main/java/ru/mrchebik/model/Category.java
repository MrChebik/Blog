package ru.mrchebik.model;

import javax.persistence.*;
import java.util.Set;

/**
 * Created by mrchebik on 14.01.17.
 */
@Entity
@Table(name = "categories")
public class Category {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(nullable = false)
    private long categoryId;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private long level;

    @Column(nullable = false)
    private long parentId;

    @ManyToMany(fetch = FetchType.EAGER, mappedBy = "categories")
    private Set<Post> posts;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId", nullable = false)
    private User user;

    public Category() {
    }

    public Category(String name) {
        this.name = name;
    }

    public Category(long categoryId, long level, String name, long parentId) {
        this.categoryId = categoryId;
        this.level = level;
        this.name = name;
        this.parentId = parentId;
    }

    public Category(User user, long level, String name, long parentId) {
        this.user = user;
        this.level = level;
        this.name = name;
        this.parentId = parentId;
    }

    public Category(long categoryId, String name) {
        this.categoryId = categoryId;
        this.name = name;
    }

    public long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(long categoryId) {
        this.categoryId = categoryId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Set<Post> getPosts() {
        return posts;
    }

    public void setPosts(Set<Post> posts) {
        this.posts = posts;
    }

    public long getLevel() {
        return level;
    }

    public void setLevel(long level) {
        this.level = level;
    }

    public long getParentId() {
        return parentId;
    }

    public void setParentId(long parentId) {
        this.parentId = parentId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}

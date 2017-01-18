package ru.mrchebik.model;

import javax.persistence.*;
import java.util.Set;

/**
 * Created by mrchebik on 14.01.17.
 */
@Entity
@Table(name = "role")
public class Role {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(nullable = false, unique = true)
    private long roleId;

    @Column(nullable = false, unique = true, length = 16)
    private String name;

    @ManyToMany(mappedBy = "roles")
    private Set<User> users;

    public long getRoleId() {
        return roleId;
    }

    public void setRoleId(long roleId) {
        this.roleId = roleId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Set<User> getUsers() {
        return users;
    }

    public void setUsers(Set<User> users) {
        this.users = users;
    }
}

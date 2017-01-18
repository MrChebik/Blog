package ru.mrchebik.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

/**
 * Created by mrchebik on 14.01.17.
 */
@Entity
@Table(name = "persistent_logins")
public class PersistentLogins {
    @Column(nullable = false, length = 60)
    private String username;

    @Id
    @Column(length = 60)
    private String series;

    @Column(nullable = false, length = 60)
    private String token;

    @Column(nullable = false)
    private Date last_used;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getSeries() {
        return series;
    }

    public void setSeries(String series) {
        this.series = series;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public Date getLast_used() {
        return last_used;
    }

    public void setLast_used(Date last_used) {
        this.last_used = last_used;
    }
}

package ru.mrchebik.run;

import ru.mrchebik.smtp.SMTPServer;

import java.io.IOException;

/**
 * Created by mrchebik on 17.01.17.
 */
public class Run implements Runnable {
    private SMTPServer smtpServer;
    private String email;
    private String url;

    public Run(String email) {
        this.email = email;
    }

    public Run(String email, String url) {
        this.email = email;
        this.url = url;
    }

    @Override
    public void run() {
        try {
            if (url == null) {
                smtpServer = new SMTPServer(email);
            } else {
                smtpServer = new SMTPServer(email, url);
            }
        } catch (IOException ignored) {
        }
    }
}

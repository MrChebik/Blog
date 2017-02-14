package ru.mrchebik.run;

import ru.mrchebik.smtp.SMTPServer;

import java.io.IOException;

/**
 * Created by mrchebik on 17.01.17.
 */
public class Run implements Runnable {
    private SMTPServer smtpServer;

    private String email;
    private String code;
    private String username;
    private String url;

    public Run(String email, String code) {
        this.email = email;
        this.code = code;
    }

    public Run(String email, String username, String url) {
        this.email = email;
        this.username = username;
        this.url = url;
    }

    @Override
    public void run() {
        try {
            smtpServer = new SMTPServer();
        } catch (IOException e) {
            e.printStackTrace();
        }

        if (url == null) {
            smtpServer.senderCode(email, code);
        } else {
            smtpServer.senderNews(email, username, url);
        }
    }
}

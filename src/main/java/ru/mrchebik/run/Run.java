package ru.mrchebik.run;

import ru.mrchebik.smtp.SMTPServer;

import java.io.IOException;

/**
 * Created by mrchebik on 17.01.17.
 */
public class Run implements Runnable {
    private SMTPServer smtpServer;
    private String email;

    public Run(String email) {
        this.email = email;
    }

    @Override
    public void run() {
        try {
            smtpServer = new SMTPServer(email);
        } catch (IOException ignored) {
        }
    }
}

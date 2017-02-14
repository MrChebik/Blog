package ru.mrchebik.smtp;

import ru.mrchebik.util.EmailUtil;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import java.io.IOException;
import java.util.Properties;

/**
 * Created by mrchebik on 17.01.17.
 */
public class SMTPServer {
    private Session session;
    private String fromEmail = "your-email";

    public SMTPServer() throws IOException {
        String password = "your-password";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.yandex.ru");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class",
                "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");

        Authenticator auth = new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        };

        session = Session.getDefaultInstance(props, auth);
    }

    public void senderCode(String toEmail, String code) {
        EmailUtil.sendEmail(session,
                fromEmail,
                toEmail,
                "NoReply - verify code",
                "You sent a request to reset password.\n" +
                        "Your code: " + code + "\n" +
                        "If you didn't do it, please ignore this message.");
    }

    public void senderNews(String toEmail, String username, String url) {
        EmailUtil.sendEmail(session,
                fromEmail,
                toEmail,
                "NoReply - new post from " + username,
                "Your writer '" + username + "' wrote a new post. Read more: " + url);
    }
}

package ru.mrchebik.smtp;

import ru.mrchebik.session.GuestSession;
import ru.mrchebik.session.UserSession;
import ru.mrchebik.util.EmailUtil;
import ru.mrchebik.util.RandomKeyUtil;

import javax.annotation.Resource;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import java.io.IOException;
import java.util.Properties;

/**
 * Created by mrchebik on 17.01.17.
 */
public class SMTPServer {
    @Resource
    private UserSession userSession;
    @Resource
    private GuestSession guestSession;

    public SMTPServer(String toEmail) throws IOException {
        final String fromEmail = "YourEmail";
        final String password = "password";

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

        Session session = Session.getDefaultInstance(props, auth);

        guestSession.setCode(RandomKeyUtil.generateCode());
        guestSession.setEmail(toEmail);

        EmailUtil.sendEmail(session,
                fromEmail,
                toEmail,
                "NoReply - verify code",
                "You sent a request to reset password.\n" +
                        "Your code: " + guestSession.getCode() + "\n" +
                        "If you didn't do it, please ignore this message.");
    }

    public SMTPServer(String toEmail, String url) throws IOException {
        final String fromEmail = "YourEmail";
        final String password = "password";

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

        Session session = Session.getDefaultInstance(props, auth);

        EmailUtil.sendEmail(session,
                fromEmail,
                toEmail,
                "NoReply - new post from " + userSession.getUser().getUsername(),
                "Your writer wrote a new post. Read more: " + url);
    }
}

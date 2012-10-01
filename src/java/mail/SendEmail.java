/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package mail;

import java.io.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
    
public class SendEmail {
  
    public static void send(String smtpHost, int smtpPort,
                            String from, String to,
                            String subject, String content)
                throws AddressException, MessagingException {

        // Create a mail session
        java.util.Properties props = new java.util.Properties();
        props.put("mail.smtp.host", smtpHost);
        props.put("mail.smtp.port", ""+smtpPort);
        Session session = Session.getDefaultInstance(props, null);
    
        // Construct the message
        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(from));
        msg.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
        msg.setSubject(subject);
        msg.setText(content);
    
        // Send the message
        Transport.send(msg);
    }
    
    public static void main(String[] args) throws Exception {
        // Send a test message
        send("smtp.gmail.com", 465, "fernd.ortiz@gmail.com", "fernd.ortiz@gmail.com",
             "Hello", "Hello, \n\n How are you ?");
    }
}

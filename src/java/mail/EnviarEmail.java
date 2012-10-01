/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package mail;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.apache.commons.mail.SimpleEmail;

/**
 *
 * @author InfZero Ti
 */
public class EnviarEmail 
{
    private String adminEmail;
    private String adminPw;
    
    public EnviarEmail( String adminEmail, String adminPw )
    {
        this.adminEmail = adminEmail;
        this.adminPw = adminPw;
    }

    public void sendHtmlEmail( String emailAdmin, String emailDestinatario, String asunto, String contenido ) throws Exception
    {
        // Create the email message
      HtmlEmail email = new HtmlEmail();
      email.setHostName("smtp.gmail.com");
      email.setSmtpPort( 587 );
      email.setAuthenticator(new DefaultAuthenticator( this.adminEmail, this.adminPw));
      email.addTo( emailDestinatario);
      email.addBcc( emailAdmin);
      email.setFrom( emailAdmin);
      email.setSubject( asunto );

      // embed the image and get the content id
      //URL url = new URL("http://www.apache.org/images/asf_logo_wide.gif");
      //String cid = email.embed(url, "Apache logo");

      // set the html message
      email.setHtmlMsg( contenido);

      // set the alternative message
      //email.setTextMsg("Your email client does not support HTML messages");

      email.setTLS( true );

      // send the email
      email.send();
    }   
}

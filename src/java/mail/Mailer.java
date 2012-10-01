/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package mail;

/**
 *
 * @author John
 */
import java.security.Security;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import sun.applet.resources.MsgAppletViewer;


public class Mailer 
{

    private final String SMTP_HOST_NAME = "smtp.gmail.com";
    private final String SMTP_PORT = "465";
    private static final String emailMsgTxt = "<html> 	<head> 		<title>Instrucciones de Cup&oacute;n de Pago</title> 	</head> 	<body> 		 		Señor Arrendatario: 		 		<br/><br/><br/> 		 		Este correo electrónico le abre el enlace con <a href=http://www.arvalbr.com/sgce-arval>Gestor de Cup&oacute;n de Pago</a> 		 		<br/> 		 		<h3>Para iniciar sesi&oacute;n siga estos pasos:</h3> 		 		<ol> 			<li>Ir a <a href=http://www.arvalbr.com/sgce-arval>Gestor de Cup&oacute;n de Pago</a></li> 			<li>Digitar nombre de usuario y contraseña (c&eacute;dula de ciudadan&iacute;a o NIT con el d&iacute;gito de verificaci&oacute;n).</li> 			<li>Haga clic en <b>Cup&oacute;n de Pago</b> en la barra superior.</li> 			<li>Ahora podr&aacute; <em>descargar</em> o <em>visualizar</em> su cup&oacute;n de pago para impresi&oacute;n.</li> 		</ol> 		 		Si usted paga servicios publicos junto con el canon de arrendamiento y la administracion (si la hubiera) este valor se vera reflejado en el concepto OTROS COBROS.<br/><br/>El banco AV VILLAS ha digitalizado la base de datos de ARVAL BIENES RAICES SAS, razon por la cual solo recibirá los pagos dentro de las fechas y valores descritos en los cupones de pago. 		 		<br/><br/> 		 		<font color=red><b>IMPORTANTE</b></font>: Recuerde imprimir su cup&oacute;n de pago en una impresora l&aacute;ser. Esto debido a la legibilidad exigida para lectura del c&oacute;digo de barras. 		 		<br/><br/><br/>Atentamente,<br/> 		 		<img src=http://www.arvalbr.com/web/images/logo.jpg width=100 height=120 alt=ArvalBR> 		 		<br/> 		 		NIT.900335987-7<br/> 		M.A. 20100075<br/> 		DG 53C 23-44 OF 203<br/> 		2492632 | 3108563682 | 3006091821<br/> 		<a href=mailto:info@arvalbr.com >info@arvalbr.com</a><br/> 		<a href=http://www.arvalbr.com/>www.arvalbr.com</a> 		 	</body> </html> ";
    private static final String emailSubjectTxt = "test";
    private static final String emailFromAddress = "fernd.ortiz@gmail.com";
    private final String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
    private static final String[] sendTo = {"kharlozm@gmail.com", "jf.ortiz45@uniandes.edu.co", "ifhernd@hotmail.com", "fernd.ortiz@gmail.com"};
    
    private String adminEmail;
    private String adminPw;

    public Mailer(String adminEmail, String adminPw) {
        this.adminEmail = adminEmail;
        this.adminPw = adminPw;
    }
    
    

    public static void main(String args[]) throws Exception 
    {
        Mailer mailer = new Mailer( "fernd.ortiz@gmail.com", "/*2015SysEngDeUA" );
        
        mailer.sendSSLMessage( sendTo, emailSubjectTxt, emailMsgTxt, emailFromAddress);
    }
    
    

    public void sendSSLMessage(String recipients[], String subject, String message, String from ) throws MessagingException 
    {
        
        Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
        
        boolean debug = true;
        Properties props = new Properties();
        props.put("mail.smtp.host", SMTP_HOST_NAME);
        props.put("mail.smtp.auth", "true");
        props.put("mail.debug", "true");
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.smtp.socketFactory.port", SMTP_PORT);
        props.put("mail.smtp.socketFactory.class", SSL_FACTORY);
        props.put("mail.smtp.socketFactory.fallback", "false");
        
        javax.mail.Authenticator aut = new Autenticador( adminEmail, adminPw);
       
        Session session = Session.getInstance(props, aut);
        
        
        
        session.setDebug(debug);
        Message msg = new MimeMessage(session);
        InternetAddress addressFrom = new InternetAddress(from);
        msg.setFrom(addressFrom);
        InternetAddress[] addressTo = new InternetAddress[recipients.length];
        
        
        
        
        
        for (int i = 0; i < recipients.length; i++ )
        {
            if( recipients[ i ].length() > 0 )
            {
                addressTo[ i ] = new InternetAddress( recipients[ i ] );
            }
        }
        
        //addressTo[ 0 ] = addressFrom;
//        for (int i = 0; i < recipients.length; i++) {
//            addressTo = new InternetAddress(recipients);
//        }
        msg.setRecipients(Message.RecipientType.BCC, addressTo);
        
        // Setting the Subject and Content Type 
        msg.setSubject(subject);
        msg.setContent(message, "text/HTML");
        Transport.send(msg);
    }
}
class Autenticador extends javax.mail.Authenticator
{
    private String adminEmail;
    private String adminPw;
    
    @Override
    protected PasswordAuthentication getPasswordAuthentication() 
    {
        return new PasswordAuthentication(  adminEmail, adminPw);
    }

    public Autenticador(String adminEmail, String adminPw) 
    {
        this.adminEmail = adminEmail;
        this.adminPw = adminPw;
    }
}
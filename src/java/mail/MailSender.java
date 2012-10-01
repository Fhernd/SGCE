/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package mail;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;

public class MailSender
{


        protected static boolean sendMail(String userName,String passWord,String host,String port,String starttls,String auth,boolean debug,String socketFactoryClass,String fallback,String[] to,String[] cc,String[] bcc,String subject,String text){
                Properties props = new Properties();
                //Properties props=System.getProperties();
        props.put("mail.smtp.user", userName);
        props.put("mail.smtp.host", host);
                if(!"".equals(port))
        props.put("mail.smtp.port", port);
                if(!"".equals(starttls))
        props.put("mail.smtp.starttls.enable",starttls);
        props.put("mail.smtp.auth", auth);
                if(debug){
                props.put("mail.smtp.debug", "true");
                }else{
                props.put("mail.smtp.debug", "false");         
                }
                if(!"".equals(port))
        props.put("mail.smtp.socketFactory.port", port);
                if(!"".equals(socketFactoryClass))
        props.put("mail.smtp.socketFactory.class",socketFactoryClass);
                if(!"".equals(fallback))
        props.put("mail.smtp.socketFactory.fallback", fallback);

        try
        {
                        Session session = Session.getDefaultInstance(props, null);
            session.setDebug(debug);
            MimeMessage msg = new MimeMessage(session);
            msg.setText(text);
            msg.setSubject(subject);
            msg.setFrom(new InternetAddress("p_sambasivarao@sutyam.com"));
                        for(int i=0;i<to.length;i++){
            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to[i]));
                        }
                        for(int i=0;i<cc.length;i++){
            msg.addRecipient(Message.RecipientType.CC, new InternetAddress(cc[i]));
                        }
                        for(int i=0;i<bcc.length;i++){
            msg.addRecipient(Message.RecipientType.BCC, new InternetAddress(bcc[i]));
                        }
            msg.saveChanges();
                        Transport transport = session.getTransport("smtp");
                        transport.connect(host, userName, passWord);
                        transport.sendMessage(msg, msg.getAllRecipients());
                        transport.close();
                        return true;
        }
        catch (Exception mex)
        {
            mex.printStackTrace();
                        return false;
        }
        }
        
        public void startSendMail( String usuarioMail, String asunto, String contenido, String mailUserAdmin, String mailPasswordAmin, String ccParam, String bccParam )
        {

            String[] to={ usuarioMail };
            String[] cc= { ccParam };
            String[] bcc= { bccParam };
            MailSender.sendMail( mailUserAdmin, mailPasswordAmin, "smtp.gmail.com", "465", "true", "true", true, "javax.net.ssl.SSLSocketFactory", "false", to, cc, bcc, asunto, contenido);             
        } // end method startSendMail
        
        public static void main( String[] args )
        {
            MailSender mail = new MailSender();
            
            mail.startSendMail( "fernd.ortiz@gmail.com", "prueba", "Señor Arrendatario:\n\nEste correo electrónico le abre el enlace con http://www.arvalbr.com/sgce-arval, dando INICIO SESIÓN  digitando en los recuadros NOMBRE DE USUARIO Y CONTRASEÑA su numero de documento (cédula de ciudadania o NIT con el digito de verificacion).<br/><br/>Haga clik en el link CUPON DE PAGO donde podra visualizar o descargar para impresion su cupon del mes. Si usted paga servicios publicos junto con el canon de arrendamiento y la administracion (si la hubiera) este valor se vera reflejado en el concepto OTROS COBROS.<br/><br/>El banco AV VILLAS ha digitalizado la base de datos de ARVAL BIENES RAICES SAS, razon por la cual solo recibirá los pagos dentro de las fechas y valores descritos en los cupones de pago.", "fernd.ortiz@gmail.com", "/*2015SysEngDeUA" , "fernd.ortiz@gmail.com", "fernd.ortiz@gmail.com");
        }
}
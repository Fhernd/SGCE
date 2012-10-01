<%@ page import="javax.mail.*,javax.mail.internet.*,javax.mail.internet.MimeMessage.RecipientType,java.io.*,java.util.Properties" %>

<%

Properties props = new Properties();
props.put("mail.smtp.host", "localhost");
Session mailsession = Session.getDefaultInstance(props, null);
Message msg = new MimeMessage(mailsession);
//set the from and to address
InternetAddress addressFrom;


try {
	addressFrom = new InternetAddress("fernd.ortiz@gmail.com");
	msg.setFrom(addressFrom);
	InternetAddress addressTo = new InternetAddress("fernd.ortiz@gmail.com");
	msg.setRecipient(RecipientType.TO,addressTo);
	msg.setContent("<b>HELLO</a>", "text/html");
        
	Transport.send(msg);
        
        
} catch (Exception e) {
	out.print( e.getMessage() );
}

%>
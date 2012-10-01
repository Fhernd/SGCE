<%@page import="java.sql.DriverManager"%>
<%@page import="mail.MailSender"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.jdbc.Connection"%>
<%@include file="../snippets/DbParams.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />
    <script type="text/javascript"
            src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
    <script src="../js/jquery.autocomplete.js"></script>
    <style>
        input {
            font-size: 120%;
        }
    </style>
    

    
    <link rel="stylesheet" type="text/css" href="../css/VisualComponents.css" />
    
</head>
<body>

    <form id="form1" action="EnviarEmailCertProcesar.jsp" onsubmit="return observacionNueva()">
          
        <br/>
        <br/>
        <input type="submit" value="Enviar Email" class="myButton">

    </form>
</body>
</html>
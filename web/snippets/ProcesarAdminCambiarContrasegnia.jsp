<%@page import="java.sql.DriverManager"%>
<%@page import="mail.MailSender"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.jdbc.Connection"%>

<%@include file="DbParams.jsp" %>
<html>
    
    <head>
        
        <script language="javascript">
            <!--
            function delayer()
            {
                window.parent.location = "../AdminOpcionesUsuario.jsp"
            }
            //-->
        </script>
        
        <link rel="stylesheet" rev="stylesheet" href="../css/custom/MessageBoxes.css"/>
    </head>
    <body onLoad="setTimeout('delayer()', 1500)">
<%
    Connection con = null;
    ResultSet rst = null;
    Statement stmt = null;
    
    try
    {
        String driver = "com.mysql.jdbc.Driver";
        Class.forName(driver).newInstance();
        
        con=(Connection) DriverManager.getConnection( UrL, UseR, PassworD );
        
        stmt=(Statement) con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );
        
        String query = "UPDATE usuario SET contrasegnia = '" + request.getParameter( "contrasegnia" ) + "' WHERE idcedulanit = " + Long.parseLong( request.getParameter( "contrasegnia" ) );
        
        stmt.executeUpdate( query );
        
        out.print( "<div class=\"success\">Los cambios fueron realizados satisfactoriamente.</div>" );
        
        con.close();
    } // end try
    catch(Exception e )
    {
        e.printStackTrace();
    } // end catch*/
%>
</body>
</html>
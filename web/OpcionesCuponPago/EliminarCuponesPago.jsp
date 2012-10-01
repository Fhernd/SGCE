<%@page import="java.sql.DriverManager"%>
<%@page import="mail.MailSender"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.jdbc.Connection"%>

<%@include file="../snippets/DbParams.jsp" %>
<html>
    
    <head>
        
        <script language="javascript">
            <!--
            function delayer()
            {
                // window.parent.location = "../AdminOpcionesUsuario.jsp"
            }
            //-->
        </script>
    </head>
    <body onLoad="setTimeout('delayer()', 1500)">
<%
    Connection con = null;
    Statement stmt = null;
    
    try
    {
        String driver = "com.mysql.jdbc.Driver";
        Class.forName(driver).newInstance();
        
        con=(Connection) DriverManager.getConnection( UrL, UseR, PassworD );
        
        stmt=(Statement) con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );
        
        String query = "DELETE FROM usuario_como_inquilino WHERE fechaadicioncuponpago = '" + request.getParameter( "cuponDate" ) + "'";
        
        stmt.executeUpdate( query );
        
        con.close();
        
        response.sendRedirect( "../SubirCuponPago.jsp" );
    } // end try
    catch(Exception e )
    {
        e.printStackTrace();
    } // end catch*/
%>
</body>
</html>
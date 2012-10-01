<%@page import="java.sql.DriverManager"%>
<%@page import="mail.MailSender"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.jdbc.Connection"%>

<%@include file="../snippets/DbParams.jsp" %>
<html>
    
    <head>
        
        <link rel="stylesheet" href="../css/custom/MessageBoxes.css" type="text/css" />
        
        <script language="javascript">
            <!--
            function delayer()
            {
                 window.parent.location = "../SubirCertificados.jsp"
            }
            //-->
        </script>
    </head>
    <body onLoad="setTimeout('delayer()', 2500)">
        <%
            Connection con = null;
            Statement stmt = null;

            try
            {
                String driver = "com.mysql.jdbc.Driver";
                Class.forName(driver).newInstance();

                con=(Connection) DriverManager.getConnection( UrL, UseR, PassworD );

                stmt=(Statement) con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );

                String query = "DELETE FROM certificados WHERE fechahoraagregado = '" + request.getParameter( "certDate" ) + "'";

                stmt.executeUpdate( query );

                con.close();

                out.print( "<div class=\"success\">Se han eliminado los certificados para la fecha especificada (" + request.getParameter("certDate" ) + ").</div>" );


            } // end try
            catch(Exception e )
            {
                e.printStackTrace();
            } // end catch*/
        %>
    </body>
</html>
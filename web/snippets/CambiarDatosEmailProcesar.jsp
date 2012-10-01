<%-- 
    Document   : CambiarDatosEmailProcesar
    Created on : Feb 13, 2012, 10:36:52 AM
    Author     : johnoo
--%>            
<%@page import="java.sql.DriverManager"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.jdbc.Connection"%>
<%@include file="DbParams.jsp" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../snippets/title.jsp" %>
        
        <script language="javascript">
            function delayer()
            {
                window.parent.location = "../AdminOpcionesUsuario.jsp"
            }
        </script>
        
        <link rel="stylesheet" rev="stylesheet" href="../css/custom/MessageBoxes.css"/>
    </head>
    <body onLoad="setTimeout('delayer()', 4001)">
        <%
        
            String driver = "com.mysql.jdbc.Driver";
            Class.forName(driver).newInstance();

            Connection con = null;
            Statement stmt = null;


            try
            {
                con= (Connection )DriverManager.getConnection( UrL, UseR, PassworD );
                stmt= (Statement ) con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );

                String sql = "UPDATE emailparams SET password = '" + request.getParameter( "oldPw1") + "'";
                
                stmt.executeUpdate( sql );
                    
               con.close();
               
               out.print( "<div class=\"success\">Cambio efectuado satisfactoriamente.</div>" );
               
            } // end try
            catch(Exception e )
            {
                out.println(e.getMessage());
            } // end catch
        %>
    </body>
    
</html>

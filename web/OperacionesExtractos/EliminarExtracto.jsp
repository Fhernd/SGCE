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
    ResultSet rst = null;
    Statement stmt = null;
    Statement stmtDel = null;
    
    try
    {
        String driver = "com.mysql.jdbc.Driver";
        Class.forName(driver).newInstance();
        
        con=(Connection) DriverManager.getConnection( UrL, UseR, PassworD );
        
        stmt=(Statement) con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );
        stmtDel =(Statement) con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );
        
        String query = "SELECT idreporte FROM extractos WHERE fechasubidaextracto = '" + request.getParameter( "extractDate" ) + "'";
        
        rst = stmt.executeQuery( query );
        
        // out.print( "<strong>Los cambios fueron realizados satisfactoriamente." );
        
        // out.println( "OK: " + request.getParameter( "extractDate" ) );
        
        while( rst.next() )
        {
            out.println( rst.getString( "idreporte" )  );
            
            String delQuery1 = "DELETE FROM registrotipo2 WHERE extractos_idreporte = " + rst.getString( "idreporte" );
            String delQuery2 = "DELETE FROM registrotipo3 WHERE extractos_idreporte = " + rst.getString( "idreporte" );
            String delQuery3 = "DELETE FROM registrotipo4 WHERE extractos_idreporte = " + rst.getString( "idreporte" );
            
            stmtDel.executeUpdate( delQuery1 );
            stmtDel.executeUpdate( delQuery2 );
            stmtDel.executeUpdate( delQuery3 );
            
            String delQuery4 = "DELETE FROM extractos WHERE idreporte = " + rst.getString( "idreporte" );
            
            stmtDel.executeUpdate( delQuery4 );
        }
        
        con.close();
        
        response.sendRedirect( "../SubirExtractos.jsp" );
    } // end try
    catch(Exception e )
    {
        e.printStackTrace();
    } // end catch*/
%>
</body>
</html>
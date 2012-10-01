 <%@ page language="java" import="java.sql.*" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.jdbc.Connection"%>
<%@include file="snippets/DbParams.jsp" %>
<html>
    
    <head>
        
        <%@include file="snippets/title.jsp" %>
        <script language="javascript">
            <!--
            function delayer()
            {
                window.parent.location = "SubirExtractos.jsp"
            }
            //-->
        </script>
    </head>
    <body onLoad="setTimeout('delayer()', 1501)">
<%
    Connection con = null;
    ResultSet rst = null;
    Statement stmt = null;
    Statement stmt2 = null;
    
    try
    {
        String driver = "com.mysql.jdbc.Driver";
        Class.forName(driver).newInstance();
        
        con=(Connection) DriverManager.getConnection( UrL, UseR, PassworD );
        
        stmt=(Statement) con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );
        stmt2=(Statement) con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );
        
        String mainQuery = "SELECT fechainicialmovimiento FROM extractos WHERE idreporte = " + request.getParameter( "extracts" ) + " LIMIT 1";
        
        rst = stmt.executeQuery( mainQuery );
        
        rst.first();
        
        String secondQuery = "SELECT idreporte FROM extractos WHERE fechainicialmovimiento = '" + rst.getString( "fechainicialmovimiento" ) + "'";

        rst = stmt.executeQuery( secondQuery );
        
        while( rst.next() )
        {
            String query = "UPDATE registrotipo4 SET observacion = '" + request.getParameter( "observacion" ) + "' WHERE extractos_idreporte = " + Long.parseLong( rst.getString( "idreporte" ) );
            
            stmt2.executeUpdate( query );
        }
        
        out.print( "<strong>Los cambios fueron realizados satisfactoriamente." );
        
        con.close();
    } // end try
    catch(Exception e )
    {
        e.printStackTrace();
    } // end catch*/
%>
</body>
</html>
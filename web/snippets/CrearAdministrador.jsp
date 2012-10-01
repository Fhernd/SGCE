<%@page import="java.sql.DriverManager"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.jdbc.Connection"%>
<%@include file="../snippets/DbParams.jsp" %>

<html>
    
    <head>
        
        <%@include file="../snippets/title.jsp" %>
        <script language="javascript">
            <!--
            function delayer()
            {
                window.parent.location = "../AdminOpcionesUsuario.jsp"
            }
            //-->
        </script>
        
    </head>
    <body onLoad="setTimeout('delayer()', 1501)">
<%
    Connection con = null;
    ResultSet rst = null;
    Statement stmt = null;
    
    try
    {
        String driver = "com.mysql.jdbc.Driver";
        Class.forName(driver).newInstance();

        con=(Connection) DriverManager.getConnection( UrL,UseR, PassworD );
        
        stmt=(Statement) con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );

        
        String query = "INSERT INTO usuario( idcedulanit, nombrepropietario, email, contrasegnia, nivelacceso) VALUES( " + request.getParameter( "newusername") + ", '" + request.getParameter("newname") + "', '" + request.getParameter("usermail" ) + "', '" + request.getParameter( "newpassword1" ) + "', 1 )";

        stmt.executeUpdate( query );
        
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
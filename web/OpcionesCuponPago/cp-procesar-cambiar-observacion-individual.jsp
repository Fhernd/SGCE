<%@page import="java.sql.DriverManager"%>
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
                window.parent.location = "../SubirCuponPago.jsp"
            }
            //-->
        </script>
        
        <link rel="stylesheet" rev="stylesheet" href="../css/custom/MessageBoxes.css"/>
        
    </head>
    
    
    <body onLoad="setTimeout('delayer()', 3577)">
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

        String query = "UPDATE usuario_como_inquilino SET detalleotroscobros = '" + request.getParameter( "message" ) + "' WHERE usuario_idcedulanit = " + request.getParameter( "iDoc" );

        stmt.executeUpdate( query );
        
        out.print( "<div class=\"success\">Se ha establecido la nueva observación de forma correcta.</div>" );
        
        con.close();
    } // end try
    catch(Exception e )
    {
        e.printStackTrace();
        out.print( "<div class=\"error\">Debe llenar todos los campos.</div>" );
        con.close();
    } // end catch*/
%>
</body>
</html>
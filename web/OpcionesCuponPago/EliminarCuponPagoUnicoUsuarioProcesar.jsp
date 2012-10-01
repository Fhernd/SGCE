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
                window.parent.location = "../SubirCuponPago.jsp"
            }
            
            //-->
        </script>
        
        <link rel="stylesheet" rev="stylesheet" href="../css/custom/MessageBoxes.css"/>
        
        
        
    </head>
    
    
    <body onLoad="setTimeout('delayer()', 13000)">
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
        
        if( request.getParameter( "cupones" ) != null )
        {
            
        
        
            String delQuery1 = "DELETE FROM usuario_como_inquilino WHERE codigoinquilino = " + request.getParameter( "cupones" );


            stmt.executeUpdate( delQuery1 );

            out.print( "<div class=\"success\">El cup&oacute;n de pago con código " + request.getParameter( "cupones" ) +" ha sido eliminado satisfactoriamente.</div>" );
        }
        else
        {
            out.print( "<div class=\"warning\">No hay Cupones de Pago por eliminar    .</div>" );
        }
        
        
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
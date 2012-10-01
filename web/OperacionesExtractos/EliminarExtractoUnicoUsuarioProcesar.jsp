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
                window.parent.location = "../SubirExtractos.jsp"
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
        
        if( request.getParameter( "extracts" ) != null )
                       {
            
        
        
        String delQuery1 = "DELETE FROM registrotipo2 WHERE extractos_idreporte = " + request.getParameter( "extracts" );
        String delQuery2 = "DELETE FROM registrotipo3 WHERE extractos_idreporte = " + request.getParameter( "extracts" );
        String delQuery3 = "DELETE FROM registrotipo4 WHERE extractos_idreporte = " + request.getParameter( "extracts" );
            
        stmt.executeUpdate( delQuery1 );
        stmt.executeUpdate( delQuery2 );
        stmt.executeUpdate( delQuery3 );
            
        String delQuery4 = "DELETE FROM extractos WHERE idreporte = " + request.getParameter( "extracts" );
        
        stmt.executeUpdate( delQuery4 );
        
        out.print( "<div class=\"success\">El extracto con código " + request.getParameter( "extracts" ) +" ha sido eliminado satisfactoriamente.</div>" );
        }
        else
        {
            out.print( "<div class=\"warning\">No hay extractos por eliminar    .</div>" );
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
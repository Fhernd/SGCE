<%@page import="java.sql.DriverManager"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.jdbc.Connection"%>
<%@include file="../snippets/DbParams.jsp" %>
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

        String query = "SELECT DATE_FORMAT( fechaadicioncuponpago, '%d %b %Y') AS fecha_formateada, fechaadicioncuponpago FROM usuario_como_inquilino WHERE codigoinquilino = " + Long.parseLong( request.getParameter( "cuenta" ) ) + " GROUP BY codigoinquilino LIMIT 3" ;
        
        rst = stmt.executeQuery( query );

        while( rst.next() )
        {
            out.print( "<option value=\"" + Long.parseLong( request.getParameter( "cuenta" ) )  + "\">" + rst.getString( "fecha_formateada" ) + "</option>" );
        }
        
        con.close();

    } // end try
    catch(Exception e )
    {
        e.printStackTrace();
    } // end catch
%>

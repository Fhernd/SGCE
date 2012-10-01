<%@page import="java.sql.DriverManager"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.jdbc.Connection"%>
<%@include file="DbParams.jsp" %>
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

        String query = "SELECT idreporte, DATE_FORMAT( fechainicialmovimiento, '%d %b %Y') AS fecha_formateada FROM extractos GROUP BY fechainicialmovimiento DESC LIMIT 10" ;
        
        rst = stmt.executeQuery( query );

        while( rst.next() )
        {
            out.print( "<option value=\"" + rst.getString( "idreporte" ) + "\">" + rst.getString( "fecha_formateada" ) + "</option>" );
        }
        
        con.close();

    } // end try
    catch(Exception e )
    {
        e.printStackTrace();
    } // end catch
%>

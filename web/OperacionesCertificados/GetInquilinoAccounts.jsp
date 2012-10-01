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

        String query = "SELECT cuenta_codigocuenta FROM certificados WHERE usuarioid = " + Long.parseLong( request.getParameter( "iDoc" ) );

        rst = stmt.executeQuery( query );

        
        while( rst.next() )
        {
            out.print( "<option value=\"" + rst.getString( "cuenta_codigocuenta" ) + "\">" + rst.getString( "cuenta_codigocuenta" ) + "</option>" );
        }
        
        con.close();

    } // end try
    catch(Exception e )
    {
        e.printStackTrace();
    } // end catch
%>

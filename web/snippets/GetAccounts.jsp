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

        String query = "SELECT extractos.cuenta_codigocuenta FROM extractos INNER JOIN usuario_has_cuenta ON usuario_has_cuenta.usuario_idcedulanit = " + Long.parseLong( request.getParameter( "iDoc" ) ) + " AND extractos.cuenta_codigocuenta = usuario_has_cuenta.cuenta_codigocuenta";

        rst = stmt.executeQuery( query );

        
        while( rst.next() )
        {
            out.print( "<option value=\"" + rst.getString( "extractos.cuenta_codigocuenta" ) + "\">" + rst.getString( "extractos.cuenta_codigocuenta" ) + "</option>" );
        }
        
        con.close();

    } // end try
    catch(Exception e )
    {
        e.printStackTrace();
    } // end catch
%>

<%@ page language="java" import="java.sql.*" %>
<%@include file="../snippets/DbParams.jsp" %>
<%

    String driver = "com.mysql.jdbc.Driver";
    Class.forName(driver).newInstance();

    Connection con = null;
    ResultSet rst = null;
    Statement stmt = null;
   
    try
    {
        con=DriverManager.getConnection( UrL, UseR, PassworD );
        stmt=con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );
        
        String user = request.getParameter( "username" );
        String pass= request.getParameter( "password" );
        
        String query = "SELECT idUsuario, contrasegnia FROM usuario WHERE idUsuario = " + user + " AND contrasegnia = " + pass;
        
        out.println ( query );
        
        rst = stmt.executeQuery( query );

        if( rst.next() )
        {
            out.print( "OK");
        }
        else
        {
            out.print( "ERROR" );
        }
        
    } // end try
    catch(Exception e )
    {
        System.out.println(e.getMessage());
    } // end catch

%>
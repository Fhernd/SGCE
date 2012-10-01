<%@ page language="java" import="java.sql.*" %>
<!-- Stablish the connect to the database -->
<%
    String driver = "com.mysql.jdbc.Driver";
    Class.forName(driver).newInstance();

    Connection con = null;
    ResultSet rst = null;
    Statement stmt = null;
    
    // user credentials
    String username = "root";
    String password = "";

    try
    {
        String url="jdbc:mysql://localhost/";
        con=DriverManager.getConnection( url, username, password );
        stmt=con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );
    } // end try
    catch(Exception e )
    {
        System.out.println(e.getMessage());
    } // end catch
%>
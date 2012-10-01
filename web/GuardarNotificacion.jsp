 <%@ page language="java" import="java.sql.*" %>
 <%@include file="snippets/DbParams.jsp" %>
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
        
        String myrichtext = request.getParameter( "myrichtext" );

        
        String query = "INSERT INTO noticias ( fecha, contenido) VALUES ( NOW(), '" + myrichtext.replaceAll( "\"", "\\") + "')";

        stmt.executeUpdate( query );

        response.sendRedirect( "dashboard.jsp" );
        
    } // end try
    catch(Exception e )
    {
        System.out.println(e.getMessage());
    } // end catch
%>
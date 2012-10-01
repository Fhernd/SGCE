
 <%@ page language="java" import="java.sql.*" %>
 <%@include file="DbParams.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        
<%


    
    String driver = "com.mysql.jdbc.Driver";
    Class.forName(driver).newInstance();

    Connection con = null;
    ResultSet res = null;
    Statement stmt = null;
    
    boolean error = false;

    try
    {
        con=DriverManager.getConnection( UrL, UseR, PassworD );
        stmt=con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );
        
       
            
            String user = request.getParameter( "username" );
            String pass= request.getParameter( "password" );
            
            String query = "SELECT * FROM emailparams WHERE emailtype = 2";

            res = stmt.executeQuery( query );

            if( res.next() )
            {
                String contenido = res.getString("contenido");
                
                mail.MailSender ms = new mail.MailSender();

                ms.startSendMail( "fernd.ortiz@gmail.com", "prueba", contenido, "fernd.ortiz@gmail.com", "/*2015SysEngDeUA" , "fernd.ortiz@gmail.com", "fernd.ortiz@gmail.com");
                    
                    
               out.print( contenido );     
                
            } // end if
            else
            {
                error = true;
            } // end if
    } // end try
    catch(Exception e )
    {
        out.println(e.getMessage());
    } // end catch
%>
        
    </body>
</html>

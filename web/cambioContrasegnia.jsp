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
        
            
            String user = (String) session.getAttribute( "username" );
            String oldpass= (String )session.getAttribute( "password" );

            
            String query = "SELECT idcedulanit, nombrepropietario, contrasegnia FROM usuario WHERE idcedulanit = " + Long.parseLong( user )+ " AND contrasegnia = '" + oldpass + "'";

            rst = stmt.executeQuery( query );
            
            if( rst.next() )
            {               
                session.setAttribute( "cambioContrCorrecto", true );
                
                String newContrasegnia = request.getParameter( "confirm_password" );
                
                query = "UPDATE usuario SET contrasegnia = '" + newContrasegnia + "' WHERE idcedulanit = " + Long.parseLong( user );
                
                stmt.executeUpdate( query );
                
                con.close();
                
                response.sendRedirect( "opcionesUsuario.jsp");
                
            }
            else
            {
                session.setAttribute( "cambioContrCorrecto", false );
                con.close();
                response.sendRedirect( "opcionesUsuario.jsp" );
            }            
        
    } // end try
    catch(Exception e )
    {
        System.out.println(e.getMessage());
    } // end catch
    
%>
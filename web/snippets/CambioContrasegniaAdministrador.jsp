 <%@ page language="java" import="java.sql.*" %>
 <%@include file="../snippets/DbParams.jsp" %>
 
 <html>
     
     <head>
         
<%@include  file="../snippets/title.jsp" %>
         <script language="javascript">
            <!--
            function delayer()
            {
                window.parent.location = "../AdminOpcionesUsuario.jsp"
            }
            //
        </script>
         
         
         <link rel="stylesheet" rev="stylesheet" href="../css/custom/MessageBoxes.css"/>
         
     </head>
     
     <body onLoad="setTimeout('delayer()', 4397)">
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
        
            
            String user = request.getParameter("adminuser");

            
            String query = "SELECT idcedulanit, nombrepropietario, contrasegnia FROM usuario WHERE idcedulanit = " + Long.parseLong( user );

            rst = stmt.executeQuery( query );
            
            if( rst.next() )
            {               
                String newContrasegnia = request.getParameter( "newpassword1" );
                
                query = "UPDATE usuario SET contrasegnia = '" + newContrasegnia + "' WHERE idcedulanit = " + Long.parseLong( user );
                
                stmt.executeUpdate( query );
                
                con.close();
                
                out.print( "<div class=\"success\">Cambio correcto.<a href=\"../AdminOpcionesUsuario.jsp\" target=\"_top\">Clic para volver</a></div>" );
                
            }
            else
            {
                con.close();
                out.print( "<div class=\"error\">El Usuario no existe. <a href=\"../AdminOpcionesUsuario.jsp\" target=\"_top\">Vuelva intentarlo.</a></div>" );
            }            
        
    } // end try
    catch(Exception e )
    {
        System.out.println(e.getMessage());
    } // end catch
    
%>

     </body>
</html
 <%@ page language="java" import="java.sql.*" %>
 <%@page language="java" import="mail.MailSender" %>
 <%@include file="snippets/DbParams.jsp" %>

 <html>
     
     
     <head>
         
         <%@include  file="snippets/title.jsp" %>
         <script language="javascript">
            <!--
            function delayer()
            {
                window.location = "opcionesUsuario.jsp"
            }
            //
        </script>
        
        <link rel="stylesheet" rev="stylesheet" href="css/custom/MessageBoxes.css"/>
         
     </head >
 
     <body onLoad="setTimeout('delayer()', 4997)">
     
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
            String oldpass= request.getParameter( "oldpassword" );
            
            String query = "SELECT idcedulanit, nombrepropietario, contrasegnia FROM usuario WHERE idcedulanit = " + Long.parseLong( user )+ " AND contrasegnia = '" + oldpass + "'";

            rst = stmt.executeQuery( query );
            
            if( rst.next() )
            {               
                session.setAttribute( "cambioEmailCorrecto", true );
                
                query = "UPDATE usuario SET email = '" + request.getParameter( "useremail" ) + "' WHERE idcedulanit = " + Long.parseLong( user );
                
                stmt.executeUpdate( query );
                
                MailSender mailSender = new MailSender();
                
                // recupera datos de la cuenta de email para envíos
                String selEmailParams = "SELECT * FROM emailparams WHERE emailtype = 2";

                ResultSet resultSet = stmt.executeQuery(selEmailParams );

                String emailAdmin = "";
                String emailPW = "";
                String emailUrl = "";
                String asunto = "";
                String contenido = "";

                if( resultSet.next() )
                {
                    emailAdmin = resultSet.getString( "email" );
                    emailPW = resultSet.getString( "password" );
                    emailUrl = resultSet.getString( "url" );
                    asunto = resultSet.getString( "asunto" );
                    contenido = resultSet.getString( "contenido" );
                }

                mail.EnviarEmail enviarEmail = null;

                if( !emailAdmin.equals( "" ) && !emailPW.equals( "" ) )
                {
                    enviarEmail = new mail.EnviarEmail( emailAdmin, emailPW );
                }
                
                if( enviarEmail != null )
                    enviarEmail.sendHtmlEmail(emailAdmin, request.getParameter( "useremail" ), "Cambio de email", "El usuario: " + user + " ha cambiado su email a " + request.getParameter( "useremail" ) );
                
                con.close();
                
                out.print( "<div class=\"success\">Cambios realizados satisfactoriamente.</div>" );
            }
            else
            {
                session.setAttribute( "cambioEmailCorrecto", false );
                
                out.print( "<div class=\"error\">No se pudo efectuar el cambio. Vuelva intentarlo.</div>" );
                
                con.close();
            }            
        
    } // end try
    catch(Exception e )
    {
        System.out.println(e.getMessage());
    } // end catch
%>

     </body>
     
 </html>
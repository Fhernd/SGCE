<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="mail.MailSender" %>
<%@page  import="java.sql.*" %>
<%@include file="../snippets/DbParams.jsp" %>

<html>
    <head>
        
        <%@include file="../snippets/title.jsp" %>
        <link rel="stylesheet" rev="stylesheet" href="../css/custom/MessageBoxes.css"/>
        
        <script language="javascript">
            <!--
            function delayer()
            {
                window.location = "../index.jsp"
            }
            //-->
        </script>
    </head>
    
    <body onLoad="setTimeout('delayer()', 10007)">
<%
    if( request.getParameter( "useremail" ) != null )
    {    
        String driver = "com.mysql.jdbc.Driver";
        Class.forName(driver).newInstance();

        Connection con = null;
        ResultSet rst = null;
        Statement stmt = null;
        
        try
        {
            con=DriverManager.getConnection( UrL, UseR, PassworD );
            stmt=con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );
            

            String query = "SELECT email,contrasegnia FROM usuario WHERE email = '" + request.getParameter( "useremail" ) + "'";

            rst = stmt.executeQuery( query );
            
            if( rst.next() )
            {               
                MailSender mailer = new MailSender();
                
                String currentPassword = rst.getString( "contrasegnia" );

                mailer.startSendMail(rst.getString( "email"), "Recuperar Contraseña", currentPassword, "info@arvalbr.com", "M3VEBtFP", "", "");
                
                out.print( "<div class=\"success\">Una copia de su contraseña ha sido enviada a su correo electrónico ( " + request.getParameter( "useremail" ) + ").</div>" );

                con.close();
                
            }
            else
            {
                out.print( "<div class=\"error\">El email ( " + request.getParameter( "useremail" ) + ") que ud. introdujo no existe. Intente de nuevo.</div>" );
                con.close();
            }            

        } // end try
        catch(Exception e )
        {
            System.out.println(e.getMessage());
        } // end catch
    }
    else
    {
        out.print( "<div class=\"error\">El email ( " + request.getParameter( "useremail" ) + ") que ud. introdujo no existe. Intente de nuevo.</div>" );
    }    
%>
    </body>
</html>
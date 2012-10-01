<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.jdbc.Connection"%>
<%@include file="../snippets/DbParams.jsp" %>

<html>
    
    <head>
        
        <%@include file="../snippets/title.jsp" %>
        <script language="javascript">
            <!--
            function delayer()
            {
                window.parent.location = "../SubirExtractos.jsp"
            }
            
            //-->
        </script>
        
        <link rel="stylesheet" rev="stylesheet" href="../css/custom/MessageBoxes.css"/>
        
        
        
    </head>
    
    
    <body onLoad="setTimeout('delayer()', 13000)">
<%
    Connection con = null;
    ResultSet rst = null;
    ResultSet tempRst = null;
    Statement stmt = null;
    Statement stmtSelIdNit = null;
    
    try
    {
        String driver = "com.mysql.jdbc.Driver";
        Class.forName(driver).newInstance();
        
        con=(Connection) DriverManager.getConnection( UrL, UseR, PassworD );
        
        stmt=(Statement) con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );
        stmtSelIdNit =(Statement) con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );
        
        if( request.getParameter( "extdates" ) != null )
        {
            String fechaExtracto = request.getParameter( "extdates" );


            String selFechas = "SELECT DISTINCT cuenta_codigocuenta FROM extractos WHERE fechainicialmovimiento = '" + fechaExtracto + "'";
            
            ArrayList<String> usuario_idCedulaNits = new ArrayList<String>();
            
            rst = stmt.executeQuery( selFechas );
            
            
            
            while( rst.next() )
            {
                String temp = "SELECT usuario_idcedulanit FROM usuario_has_cuenta WHERE cuenta_codigocuenta = " + rst.getString( "cuenta_codigocuenta" ) ;
           
                tempRst = stmtSelIdNit.executeQuery( temp );
                
                if( tempRst.next() )
                                       {
                    
                
                
                usuario_idCedulaNits.add( tempRst.getString( "usuario_idcedulanit"));
                               }
            }

            Iterator<String> it = usuario_idCedulaNits.iterator();
            
            out.println( usuario_idCedulaNits.get( 0 ) );
            
        // recupera datos de la cuenta de email para envíos
        String selEmailParams = "SELECT * FROM emailparams WHERE emailtype = 1";
        
        rst = stmt.executeQuery(selEmailParams );
        
        String emailAdmin = "";
        String emailPW = "";
        String emailUrl = "";
        String asunto = "";
        String contenido = "";
        
        if( rst.next() )               
        {
            emailAdmin = rst.getString( "email" );
            emailPW = rst.getString( "password" );
            emailUrl = rst.getString( "url" );
            asunto = rst.getString( "asunto" );
            contenido = rst.getString( "contenido" );
            
            
        }
            
            String temp = "";
            
            Pattern p = Pattern.compile(".+@.+\\.[a-z]+");
            
            while( it.hasNext() )
            {
                String tempId = it.next();
                
                
                
                temp = "SELECT * FROM usuario WHERE idcedulanit = " + tempId;
                
                tempRst = stmtSelIdNit.executeQuery(temp);
                
                if( tempRst.next() )
                {
                    
                    Matcher m = p.matcher(tempRst.getString("email"));
                    boolean matchFound = m.matches();

                    if( matchFound )
                    {
                        mail.MailSender ms = new mail.MailSender();
                        
                        ms.startSendMail( tempRst.getString("email"), asunto, contenido, emailAdmin, emailPW, emailAdmin, emailAdmin);
                    }else
                    {
                        
                
                    }
}
            }
            
           

            out.print( "<div class=\"success\">Env&iacute;o correcto de emails.</div>" );
        }
        else
        {
            out.print( "<div class=\"warning\">Problemas con el proveedor de email. Intente más tarde..</div>" );
        }
        
        
        
        con.close();
    } // end try
    catch(Exception e )
    {
        e.printStackTrace();
        out.print( "<div class=\"error\">Debe seleccionar una fecha para enviar emails.</div>" );
        con.close();
    } // end catch*/
%>
</body>
</html>
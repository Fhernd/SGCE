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
                window.parent.location = "../SubirCertificados.jsp"
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
        stmtSelIdNit=(Statement) con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );
        
        String selId = "SELECT usuarioid FROM certificados";
        
        rst = stmt.executeQuery( selId );
        
        ArrayList<String> usuario_idCedulaNits = new ArrayList<String>();
        
        while( rst.next() )
        {
            usuario_idCedulaNits.add( rst.getString( "usuarioid"));
        }
        
        
        // recupera datos de la cuenta de email para envíos
        String selEmailParams = "SELECT * FROM emailparams WHERE emailtype = 3";
        
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
        
        
        
        Iterator<String> it = usuario_idCedulaNits.iterator();
        Pattern p = Pattern.compile(".+@.+\\.[a-z]+");
        
                
        mail.EnviarEmail enviarEmail = null;
        
        if( !emailAdmin.equals( "" ) && !emailPW.equals( "" ) )
        {
            enviarEmail = new mail.EnviarEmail( emailAdmin, emailPW );
        }
        
        while( it.hasNext() )
        {
            String tempId = it.next();

            String sql = "SELECT * FROM usuario WHERE idcedulanit = " + tempId + " AND nivelacceso = 3";

            tempRst = stmtSelIdNit.executeQuery( sql );
            
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
        } // fin de while
       
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
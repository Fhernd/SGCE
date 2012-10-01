<%-- 
    Document   : CambiarDatosEmail
    Created on : Feb 13, 2012, 10:15:58 AM
    Author     : johnoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        <script type="text/javascript">
            function equals()
            {
                pwd1 = document.getElementById( 'oldPw1' ).value;
                pwd2 = document.getElementById( 'oldPw2' ).value;
                
                if( pwd1 == pwd2 )
                {
                    return true;
                }
                else
                {
                    alert( 'Los datos suministrados no coinciden. Intente de nuevo.');
                    return false;
                }
            }
        
        </script>
        
        <link rel="stylesheet" type="text/css" href="../css/VisualComponents.css" />

    </head>
    <body>
        <form method="POST" action="CambiarDatosEmailProcesar.jsp" onsubmit="return equals()">
            <label>Nueva contrase&ntilde;a:&nbsp;&nbsp;</label>
            <input type="password" name="oldPw1" id="oldPw1" ><br/>
            <label>Repetir contrase&ntilde;a:&nbsp;</label>
            <input type="password" name="oldPw2" id="oldPw2" ><br/>
            <br/>
            <input type="submit" value="Cambiar contrase&ntilde;a Email" class="myButton" />
            
            
        </form>
    </body>
</html>

<%@page import="java.sql.DriverManager"%>
<%@page import="mail.MailSender"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.jdbc.Connection"%>
<%@include file="../snippets/DbParams.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />
    <script type="text/javascript"
            src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
    <script src="../js/jquery.autocomplete.js"></script>
    <style>
        input {
            font-size: 120%;
        }
    </style>
    
    
    <script language="javascript">
    
        /*PETICIONES AJAX PARA COMBOS ANIDADOS*/
        var peticion = false;
        var  testPasado = false;
        try 
        {
            peticion = new XMLHttpRequest();
        }
        catch (trymicrosoft) 
        {
            try 
            {
                peticion = new ActiveXObject("Msxml2.XMLHTTP");
            }
            catch (othermicrosoft) 
            {
                try
                {
                    peticion = new ActiveXObject("Microsoft.XMLHTTP");
                }
                catch (failed) 
                {
                    peticion = false;
                }
            }
        }
        
        if (!peticion)
        alert("ERROR AL INICIALIZAR!");

        function cargarCombo() 
        {
            //Obtenemos el contenido del div
            //donde se cargaran los resultados
            var element =  document.getElementById( 'extdates' );
            
        
            
            //construimos la url definitiva
            //pasando como parametro el valor seleccionado
            var fragment_url = "EnviarEmailObtenerFechas.jsp";
            
            //abrimos la url
            peticion.open("GET", fragment_url);
            peticion.onreadystatechange = function() 
            {
                if (peticion.readyState == 4) 
                {
                    //escribimos la respuesta
                    element.innerHTML = peticion.responseText;
                    element.disabled = false;
                }
            }
            
            peticion.send(null);
        } // end function cargarCombo

        function bar(evt)
        {
            var k=evt.keyCode||evt.which;
            return k!=13;
        }
        
        function observacionNueva()
        {
            return document.getElementById( 'observacion' ).value != "" ? true : false;
        }

    </script>
    
    <link rel="stylesheet" type="text/css" href="../css/VisualComponents.css" />
    
</head>
<body>
    Seleccione Fecha de Extracto para Envío de Email:
    <form id="form1" action="EnviarEmailProcesar.jsp" onsubmit="return observacionNueva()">
        
        <br/>
        <br/>
       
        <select id="extdates" disabled="true" name="extdates">
            <option>Seleccione cuenta</option>
            
        </select>
         <input type="button" class="myButton" value="Mostrar Fechas" onclick="javascript:cargarCombo()">
        <br/>
        <br/>
        
      
        
        
        <input type="submit" value="Enviar Email" class="myButton">

    </form>
</body>
</html>
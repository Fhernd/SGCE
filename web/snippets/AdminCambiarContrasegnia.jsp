<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />
    <script type="text/javascript"
            src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
    <script src="js/jquery.autocomplete.js"></script>
    <script type="text/javascript" src="../js/custom/validations.js" ></script>
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
            var element =  document.getElementById( 'accounts' );
            
            //Obtenemos el valor seleccionado del combo anterior
            var valordepende = document.getElementById( 'iDoc' ).value
            var x = valordepende;
            
            //construimos la url definitiva
            //pasando como parametro el valor seleccionado
            var fragment_url = "snippets/GetAccounts.jsp"+'?iDoc=' + x;
            
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

        function MostrarExtractos()
        {
            //Obtenemos el contenido del div
            //donde se cargaran los resultados
            var element =  document.getElementById( 'extracts' );
            
            //Obtenemos el valor seleccionado del combo anterior
            var x = document.getElementById( 'accounts' ).value;
            
            //construimos la url definitiva
            //pasando como parametro el valor seleccionado
            var fragment_url = "snippets/GetExtracts.jsp"+'?cuenta=' + x;
            
            //abrimos la url
            peticion.open("GET", fragment_url);
            peticion.onreadystatechange = function() 
            {
                if (peticion.readyState == 4) 
                {
                    //escribimos la respuesta
                    element.innerHTML = peticion.responseText;
                    element.disabled = false;
                    document.getElementById( "observacion" ).disabled = false;
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
    
    <link rel="stylesheet" type="text/css" href="css/VisualComponents.css" />
    
</head>
<body>
    <form id="form1" action="CambioContrasegniaAdministrador.jsp" onsubmit="return equalPassword()">
        
        ID Cuenta: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id = "newusername" name="adminuser" o/><br/>
        
        Contrase&ntilde;a:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<input type="password" id="newpassword1" name="newpassword1" /><br/>
        Repetir Contrase&ntilde;a: <input type="password" id="newpassword2" name="newpassword2" /><br/>
        
        <input type="submit" value="Cambiar" class="myButton"/>
        
    </form>
</body>
</html>
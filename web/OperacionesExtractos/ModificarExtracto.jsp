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
            var element =  document.getElementById( 'accounts' );
            
            //Obtenemos el valor seleccionado del combo anterior
            var valordepende = document.getElementById( 'iDoc' ).value
            var x = valordepende;
            
            //construimos la url definitiva
            //pasando como parametro el valor seleccionado
            var fragment_url = "../snippets/GetAccounts.jsp"+'?iDoc=' + x;
            
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
            var fragment_url = "../snippets/GetExtracts.jsp" + '?cuenta=' + x;
            
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
    
    <link rel="stylesheet" type="text/css" href="../css/VisualComponents.css" />
    
</head>
<body>
    N&uacute;mero de Documento de Identidad:
    <form id="form1" action="EliminarExtracto0SelectRows.jsp" onsubmit="return observacionNueva()">
        
        <input type="text" id="iDoc" name="iDoc" onkeypress="return bar(event)"/>
        <input type="button" class="myButton" value="Mostrar Cuentas" onclick="javascript:cargarCombo()">
        
        <script>
            $("#iDoc").autocomplete( "../getdata.jsp" );
        </script>
        
        <br/>
        <br/>
        Cuentas con Extractos:
        <br/>
        <select id="accounts" disabled="true" name="accounts">
            
            <option>Seleccione cuenta</option>
            
        </select>
        <input type="button" value="Mostrar Extractos" class="myButton" onclick="javascript:MostrarExtractos()">
        
        <br/>
        <br/>
        Extractos Recientes:
        <br/>
        <select id="extracts" disabled="true" name="extracts">
            
            <option>Seleccione cuenta</option>
            
        </select>
        
        <br/>
        
        <input type="submit" value="Continuar" class="myButton">

    </form>
</body>
</html>
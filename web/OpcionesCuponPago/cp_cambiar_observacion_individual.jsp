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
    </script>
    
    <link rel="stylesheet" type="text/css" href="../css/VisualComponents.css" />
    
</head>
<body>
    N&uacute;mero de Documento de Identidad:
    <form id="form1" action="cp-procesar-cambiar-observacion-individual.jsp" onsubmit="return observacionNueva()">
        
        <input type="text" id="iDoc" name="iDoc" onkeypress="return bar(event)"/>
        
        <script>
            $("#iDoc").autocomplete("get-cp.jsp");
        </script>
        
        <br/>
        <br/>
        Nueva Observación:
        <br/>
        <textarea name="message" id="message"  rows="8" cols="52" ></textarea>
        
        <br/>
        <br/>
        
        <input type="submit" value="Cambiar" class="myButton">

    </form>
</body>
</html>
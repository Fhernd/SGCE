<%-- 
    Document   : uploadForm
    Created on : Dec 1, 2011, 1:38:47 PM
    Author     : johnoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
            <title>File Uploading Form</title>

        <script language="javascript">
            function checkFileExtension(elem) 
            {
                    var filePath = elem.value;

                    if(filePath.indexOf('.') == -1)
                        return false;

                    var validExtensions = new Array();
                    var ext = filePath.substring(filePath.lastIndexOf('.') + 1).toLowerCase();

                    validExtensions[0] = 'txt';/*
                    validExtensions[1] = 'jpeg';
                    validExtensions[2] = 'bmp';
                    validExtensions[3] = 'png';
                    validExtensions[4] = 'gif';  
                    validExtensions[5] = 'tif';  
                    validExtensions[6] = 'tiff';
                    validExtensions[7] = 'txt';
                    validExtensions[8] = 'doc';
                    validExtensions[9] = 'xls';
                    validExtensions[10] = 'pdf';*/

                    for(var i = 0; i < validExtensions.length; i++) {
                        if(ext == validExtensions[i])
                            {
                              document.getElementById('upload').disabled = false;
                            return true;
                            }
                    }

                    alert('Debe seleccionar un archivo en formato TXT (texto plano).');
                     document.getElementById('upload').disabled = true;
                    return false;
                }
        </script>
    </head>
	<body>
		<h3>File Upload:</h3>
		Select a file to upload: <br />
                <form action="UploadExtractos.jsp" method="post" enctype="multipart/form-data" >
                    <input type="file" name="file" size="50" onchange="checkFileExtension( this )"/>
                    <br />
                    <input type="submit" id="upload" value="Upload File" disabled="disabled"/>
		</form>
	</body>
</html>

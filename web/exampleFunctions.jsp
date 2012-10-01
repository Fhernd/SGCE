<%-- 
    Document   : exampleFunctions
    Created on : Nov 30, 2011, 12:36:57 PM
    Author     : johnoo
--%>
<%@ page import="java.util.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.*" %>
<%@ page import="java.io.*" %>

<%!
    public String getQuarter( int i )
    {
        String quarter;
        switch(i)
        {
            case 1: quarter = "Winter";
            break;

            case 2: quarter = "Spring";
            break;

            case 3: quarter = "Summer I";
            break;

            case 4: quarter = "Summer II";
            break;

            case 5: quarter = "Fall";
            break;

            default: quarter = "ERROR";
        }

        return quarter;
    }
%>




<%!
    public void uploadFile()
    {
        String destination = "/files";
        String destinationRealPath = application.getRealPath( destination );

        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setSizeThreshold( 1024 );

        factory.setRepository( new File( destinationRealPath ) );

        ServletFileUpload uploader = new ServletFileUpload( factory );

        try
        {
            List items = uploader.parseRequest( request );
            Iterator iterator = items.iterator();

            while( iterator.hasNext() )
            {
                FileItem item = (FileItem) iterator.next();
                File file = new File( destinationRealPath, item.getName() );
                item.write( file );
                out.write( "<p>" + file.getName() + " was uploaded successfully</p>" ) ;
            }
        }
        catch( FileUploadException e )
        {
            out.write( "<p>FileUploadException was thrown..." + e.getMessage() + "</p>" );
        }
   }
%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <br/>
        <br/>
        <%
            //out.print(getQuarter(4));
        %>
    </body>
</html>

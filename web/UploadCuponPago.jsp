<%@ page import="upload.ParseCupones" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.GregorianCalendar" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.*" %>
<%@ page import="java.io.File" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.io.BufferedReader" %>

<%	
    String destination = "/files";
    application.getRealPath( destination );

    String newPath = String.format( "%s", application.getRealPath( destination ) );
    
    DiskFileItemFactory factory = new DiskFileItemFactory();
    factory.setSizeThreshold( 1024 );

    factory.setRepository( new File( application.getRealPath( destination ) ) );

    ServletFileUpload uploader = new ServletFileUpload( factory );

    try
    {
        List items = uploader.parseRequest( request );
        Iterator iterator = items.iterator();
        
        int size = items.size();
        
        int count = 1;

        while( iterator.hasNext() && count < size )
        {
                 count++;
                 
                FileItem item = (FileItem) iterator.next();

                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
                Date newDate = new Date();
                String fileDate = dateFormat.format( newDate );

                Calendar calendar = new GregorianCalendar();

                int hour = calendar.get(Calendar.HOUR);
                int minute = calendar.get(Calendar.MINUTE);
                int second = calendar.get(Calendar.SECOND);
                
                String fileName = item.getName().substring( 0,  item.getName().length() - 4 ) + "_" + fileDate.toString() + "_" + String.format( "%s-%s-%s", hour, minute, second ) + ".txt";
                
                File file = new File( newPath, fileName );
                
                if( file.length() <= 2097152 )
                {
                    item.write( file );

                    // invoke openFile method
                    ParseCupones parserObj = new ParseCupones();

                    String filePathOnServer= application.getRealPath("files/" + fileName );

                    parserObj.startParse( filePathOnServer );

                    session.setAttribute("uploadSuccess", true);

                    response.sendRedirect( "SubirCuponPago.jsp" );
                }
                else
                {
                    session.setAttribute("uploadSuccess", false);
                }
                
        } // end while
    } // end try
    catch( FileUploadException e )
    {
        session.setAttribute("uploadSuccess", false);
        out.write( "<p>Problema al subir el archivo..." + e.getMessage() + "</p>" );        
    } // end catch
%>
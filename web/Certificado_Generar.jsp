<%@page contentType="application/PDF" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ page import="net.sf.jasperreports.engine.*" %> 
<%@ page import="java.util.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.sql.*" %>


<%@include file="snippets/DbParams.jsp" %>

<% 
    Connection conexion = null; 
    Class.forName("com.mysql.jdbc.Driver"); 
    
    conexion = DriverManager.getConnection(UrL,UseR, PassworD );  

    File reportFile = new File(application.getRealPath("reports//Certificado.jasper"));
    


    Map parameters = new HashMap(); 
    parameters.put("codigocuenta",  Long.parseLong( request.getParameter( "codigoCuenta" ) ) ); 
    parameters.put("idcedulanit", Long.parseLong( request.getParameter( "idCedulaNit" ) ) ); 
    parameters.put("fechacertificado", String.format( request.getParameter( "fechaemision" )) ); 

    byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, conexion); 

    response.setContentType("application/pdf"); 
    ServletOutputStream ouputStream = null;
    
    if( ! ( bytes.length > 1500 ) )
    {
        response.setContentLength(bytes.length); 
        ouputStream = response.getOutputStream(); 
        ouputStream.write(bytes, 0, bytes.length);  

        conexion.close();

        ouputStream.flush(); 
        ouputStream.close();
    }
    else
    {
        response.setContentType("text/html"); 
        out.println( "<strong>Este extracto a&uacute;n no tiene informaci&oacute;n asociada.<strong>" );
    }
%>

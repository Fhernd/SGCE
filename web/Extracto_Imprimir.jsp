<%-- 
    Document   : Reports
    Created on : Oct 27, 2011, 7:16:43 PM
    Author     : johnoo
--%>

<%@page import="net.sf.jasperreports.engine.util.JRLoader"%>
<%@page contentType="application/PDF" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ page import="net.sf.jasperreports.engine.*" %> 
<%@ page import="java.util.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.sql.*" %>
<%@include file="snippets/DbParams.jsp" %>

<% 
    /*Parametros para realizar la conexión*/ 
    Connection conexion = null; 
    Class.forName("com.mysql.jdbc.Driver"); 
    
    conexion = DriverManager.getConnection( UrL, UseR, PassworD);  

    /*Establecemos la ruta del reporte*/ 
    File reportFile = new File(application.getRealPath("reports//WebReport_2.jasper"));
    Map parameters = new HashMap(); 
    parameters.put("codigocuenta",  Long.parseLong( request.getParameter( "codigoCuenta" ) ) ); 
    parameters.put("idcedulanit", Long.parseLong( request.getParameter( "idCedulaNit" ) ) ); 
    parameters.put("fechaextracto", request.getParameter( "fechaExtracto" )); 
   
    JasperReport jasperReport = (JasperReport ) JRLoader.loadObject( reportFile );


    try
    {
      JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, conexion);
      JasperPrintManager.printPage(jasperPrint, 0, true);
    }
    catch (Exception e)
    {
      e.printStackTrace();
      System.exit(1);
    }
    
    /*Enviamos la ruta del reporte, los parámetros y la conexión(objeto Connection)*/ 
    byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, conexion); 

    /*Indicamos que la respuesta va a ser en formato PDF*/ 
    response.setContentType("application/PDF"); 
    response.setContentLength(bytes.length); 
    ServletOutputStream ouputStream = response.getOutputStream(); 
    ouputStream.write(bytes, 0, bytes.length); 
    
    conexion.close();
    
    /*Limpiamos y cerramos flujos de salida*/ 
    ouputStream.flush(); 
    ouputStream.close();
    

%>

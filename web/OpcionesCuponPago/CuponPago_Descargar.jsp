<%-- 
    Document   : Reports
    Created on : Oct 27, 2011, 7:16:43 PM
    Author     : johnoo
--%>

<%@page contentType="application/PDF" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ page import="net.sf.jasperreports.engine.*" %> 
<%@ page import="java.util.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.sql.*" %>
<%@include file="../snippets/DbParams.jsp" %>
<% 
    response.setHeader ("Content-Disposition", "attachment; filename=\"CuponPago.pdf\"");
    Connection conexion = null; 
    Class.forName("com.mysql.jdbc.Driver"); 
    
    conexion = DriverManager.getConnection(UrL,UseR,PassworD);  

    File reportFile = new File(application.getRealPath("reports//CuponPagoMain.jasper"));


    Map parameters = new HashMap(); 
    parameters.put("codigoinquilino",  Long.parseLong( request.getParameter( "codigoInquilino" ) ) ); 
    parameters.put("idcedulanit", Long.parseLong( request.getParameter( "idCedulaNit" ) ) );  

    byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, conexion); 

    response.setContentType("application/PDF"); 
    response.setContentLength(bytes.length); 
    ServletOutputStream ouputStream = response.getOutputStream(); 
    ouputStream.write(bytes, 0, bytes.length); 

    conexion.close();
    
    ouputStream.flush(); 
    ouputStream.close();
%>

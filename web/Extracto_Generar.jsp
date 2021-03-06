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
<%@include file="snippets/DbParams.jsp" %>
<% 
    Connection conexion = null; 
    Class.forName("com.mysql.jdbc.Driver"); 
    
    conexion = DriverManager.getConnection(UrL,UseR, PassworD );  

    File reportFile = new File(application.getRealPath("reports//WebReport_2.jasper"));


    Map parameters = new HashMap(); 
    parameters.put("codigocuenta",  Long.parseLong( request.getParameter( "codigoCuenta" ) ) ); 
    parameters.put("idcedulanit", Long.parseLong( request.getParameter( "idCedulaNit" ) ) ); 
    parameters.put("fechaextracto", request.getParameter( "fechaExtracto" )); 

    byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, conexion); 

    response.setContentType("application/PDF"); 
    response.setContentLength(bytes.length); 
    ServletOutputStream ouputStream = response.getOutputStream(); 
    ouputStream.write(bytes, 0, bytes.length); 

    conexion.close();
        
    ouputStream.flush(); 
    ouputStream.close();
%>

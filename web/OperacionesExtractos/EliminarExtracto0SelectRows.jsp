<%-- 
    Document   : EliminarExtracto0SelectRows
    Created on : 27/01/2012, 05:26:25 PM
    Author     : infzero
--%>
<%@page import="java.sql.DriverManager"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.jdbc.Connection"%>
<%@include file="../snippets/DbParams.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="../css/tables/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
        <script type="text/javascript" src="../js/tables/tablecloth.js" ></script>
    </head>
    <body>
        <h1>Paso 2: Seleccione los movimientos que desea eliminar:</h1>

        
        <form name="deleteExtracts" action="EliminarExtracto1ApplyChanges.jsp" >
        
            <table cellspacing="0" cellpadding="0">
                <tr>
                        <th>Orden</th>
                        <th>Fecha</th>
                        <th>No.</th>
                        <th>Transacci&oacute;n</th>
                        <th>Detalle</th>
                        <th>D&eacute;bito</th>
                        <th>Cr&eacute;dito</th>
                        <th>Saldo</th>
                        <th>¿Eliminar?</th>
                </tr>
                <%
                    Connection con = null;
                    ResultSet rst = null;
                    Statement stmt = null;

                    try
                    {
                        String driver = "com.mysql.jdbc.Driver";
                        Class.forName(driver).newInstance();

                        con=(Connection) DriverManager.getConnection( UrL, UseR, PassworD );

                        stmt=(Statement) con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );

                        String query = "SELECT fechadocumento, numero, detalletransaccion, detalle, CONCAT('$', FORMAT(valorcredito, 2)) AS ValorCredito, CONCAT('$', FORMAT(valordebito, 2)) AS ValorDebito, CONCAT('$', FORMAT(saldo, 2)) AS Saldo, contadormovimientos FROM registrotipo2 WHERE extractos_idreporte = " + Long.parseLong( request.getParameter( "extracts" ) ) + " ORDER BY contadormovimientos ASC";

                        rst = stmt.executeQuery( query );

                        while( rst.next() )
                        {
                            out.print( "<tr>" );

                            out.print( "<td>" + rst.getString( "contadormovimientos" ) + "</td>" );
                            out.print( "<td>" + rst.getString( "fechadocumento" ) + "</td>" );
                            out.print( "<td>" + rst.getString( "numero" ) + "</td>" );
                            out.print( "<td>" + rst.getString( "detalletransaccion" ) + "</td>" );
                            out.print( "<td>" + rst.getString( "detalle" ) + "</td>" );
                            out.print( "<td>" + rst.getString( "ValorDebito" ) + "</td>" );
                            out.print( "<td>" + rst.getString( "ValorCredito" ) + "</td>" );
                            out.print( "<td>" + rst.getString( "Saldo" ) + "</td>" );
                            out.print( "<td>" + "<input type=\"checkbox\" name=\"moves\" value=\"" + rst.getString( "contadormovimientos" ) + "\"/>" + "</td>" );

                            out.print( "</tr>" );
                        }

                        con.close();

                    } // end try
                    catch(Exception e )
                    {
                        e.printStackTrace();
                    } // end catch
                %>																			
            </table>
            
            <input type="hidden" name="idreporte" value="<%= request.getParameter( "extracts" ) %>"/>
            <input type="hidden" name="codigocuenta" value="<%= request.getParameter( "accounts" ) %>"/>
            <input type="hidden" name="idcedulanit" value="<%= request.getParameter( "iDoc" ) %>"/>
            
            <input type="submit" value="Finalizar"/>
        </form>
    </body>
</html>

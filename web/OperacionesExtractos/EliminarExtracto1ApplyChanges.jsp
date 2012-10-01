<%-- 
    Document   : EliminarExtracto1ApplyChanges
    Created on : 28/01/2012, 11:11:02 AM
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
        <%@include file="../snippets/title.jsp" %>
        <link rel="stylesheet" rev="stylesheet" href="../css/custom/MessageBoxes.css"/>
        
        <script language="javascript">
            
            function delayer()
            {
                window.parent.location = "../SubirExtractos.jsp"
            }
        </script>
        
    </head>
    <body onLoad="setTimeout('delayer()', 8001)">
        <% 
        

        
            String driver = "com.mysql.jdbc.Driver";
            Class.forName(driver).newInstance();

            Connection con = null;
            ResultSet rst = null;
            ResultSet rstSaldoAnterior = null;
            ResultSet rstRegTipo3 = null;
            ResultSet rstCambios = null;
            
            
            Statement stmt = null;
            Statement stmtModificacion = null;
            Statement stmtRegTipo3 = null;
            Statement stmtCambios = null;
            
            try
            {
                con= (Connection)DriverManager.getConnection( UrL, UseR, PassworD );
                
                stmt=(Statement)con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );
                

                String[] moves;
                moves = request.getParameterValues("moves");
                
                
                
                if (moves != null) 
                {
                    // elimina los movimientos seleccionados
                    for (int i = 0; i < moves.length; i++) 
                    {
                        
                        
                        String eliminarMovimiento = "DELETE FROM registrotipo2 WHERE contadormovimientos = " + moves[i] + " AND extractos_idreporte = " + request.getParameter("idreporte" );
                        
                        stmt.executeUpdate( eliminarMovimiento );
                        
                    }
                    
                    
                    String movimientosDisponibles = "SELECT * FROM registrotipo2 WHERE extractos_idreporte = " + request.getParameter("idreporte" );
                    
                    rst = stmt.executeQuery( movimientosDisponibles );
                    
                    if( rst.first() )
                    {
                        rst.beforeFirst();
                        
                        stmtModificacion = (Statement)con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );
                        
                        // recupera los datos disponibles
                        String consultaExtracto = "SELECT saldoanterior FROM extractos WHERE idreporte = " + request.getParameter("idreporte" ) + " AND cuenta_codigocuenta = " + request.getParameter( "codigocuenta");
                        rstSaldoAnterior = stmtModificacion.executeQuery( consultaExtracto );
                        
                        while( rstSaldoAnterior.next() )
                        {
                            
                            
                            double saldoAnterior = Double.parseDouble( rstSaldoAnterior.getString( "saldoanterior") );
                            
                            stmtRegTipo3 = (Statement)con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );
                            
                            String consultaRT3 = "SELECT * FROM registrotipo3 WHERE extractos_idreporte = " + request.getParameter("idreporte" );
                            
                            rstRegTipo3 = stmtRegTipo3.executeQuery( consultaRT3 );
                            double saldo = 0.0;
                            
                            while( rstRegTipo3.next() )
                            {
                                
                                double totalDebitos = 0.0;
                                double totalCreditos = 0.0;
                                
                                
                                
                                int contador = 1;
                                
                                
                                stmtCambios = (Statement)con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );
                                

                                while( rst.next() )
                                {
                                                                        
                                    double valorDebito = Double.parseDouble( rst.getString( "valordebito" ) );
                                    double valorCredito = Double.parseDouble( rst.getString( "valorcredito" ) );
                                    
                                    
                                    
                                    if( contador == 1 )
                                    {
                                        if( valorDebito  != 0.0 )
                                        {
                                            
                                            saldo = saldoAnterior - valorDebito;
                                            

                                        }
                                        else
                                        {
                                            saldo = saldoAnterior + valorCredito; 
                                            
 
                                        }
                                        ++contador;
                                    }
                                    else
                                    {
                                        if( valorDebito != 0.0 )
                                        {
                                            
                                            saldo = saldo - valorDebito; 
                                        }
                                        else
                                        {
                                            saldo = saldo + valorCredito; 
                                            
                                        }
                                    }
                                    
                                    totalDebitos += valorDebito;
                                    totalCreditos += valorCredito;
                                    
                                    String cambiosDefinitivos = "UPDATE registrotipo2 SET saldo = " + saldo + " WHERE idregistrotipo2 = " + rst.getString( "idregistrotipo2" );
                                    stmtCambios.executeUpdate( cambiosDefinitivos );
                                    
                                } // end while registrotipo2
                                
                                
                                String actualizarRegTipo3 = "UPDATE registrotipo3 SET totaldebitos = " + totalDebitos + ", totalcreditos = " + totalCreditos + ", totalsaldoactual = " + saldo + " WHERE idregistrotipo3 = " + rstRegTipo3.getString( "idregistrotipo3" );
                                
                                stmtCambios.executeUpdate( actualizarRegTipo3 );
                                
                                
                                out.print("<br/>" );
                                out.print("<br/>" );
                                out.print("<br/>" );
                                out.print("<br/>" );
                                out.print("<br/>" );
                                out.print("<br/>" );
                                out.print("<br/>" );
                                out.print("<br/>" );
                                out.print( "<div class=\"success\">Todos los cambios fueron efectuados satisfactoriamente.</div>" );
                                
                            } // end while registrotipo3
                            
                            rstRegTipo3.close();
                            stmtCambios.close();
                            
                        } // end while extractos
                        rstSaldoAnterior.close();
                    }
                    else
                    {
                        
                        String deleteEverything = "DELETE FROM registrotipo4 WHERE extractos_idreporte = " + request.getParameter("idreporte" );
                        stmt.executeUpdate( deleteEverything);
                        deleteEverything = "DELETE FROM registrotipo3 WHERE extractos_idreporte = " + request.getParameter("idreporte" );
                        stmt.executeUpdate( deleteEverything);
                        deleteEverything = "DELETE FROM registrotipo2 WHERE extractos_idreporte = " + request.getParameter("idreporte" );
                        stmt.executeUpdate( deleteEverything);
                        deleteEverything = "DELETE FROM extractos WHERE idreporte = " + request.getParameter("idreporte" );
                        stmt.executeUpdate( deleteEverything);
                        
                        stmt.close();
                        
                        out.print("<br/>" );
                        out.print("<br/>" );
                        out.print("<br/>" );
                        out.print("<br/>" );
                        out.print("<br/>" );
                        out.print("<br/>" );
                        out.print("<br/>" );
                        out.print("<br/>" );
                        out.print( "<div class=\"warning\">Todos los registros han sido eliminados; por lo tanto el extracto tambi&eacute;n.</div>" );
                    }
                }
                else 
                {
                    out.print("<br/>" );
                    out.print("<br/>" );
                    out.print("<br/>" );
                    out.print("<br/>" );
                    out.print("<br/>" );
                    out.print("<br/>" );
                    out.print("<br/>" );
                    out.print("<br/>" );
                    
                    out.print( "<div class=\"info\">No ha hecho ninguna selecci&oacute;n. El extracto no ha sido modificado.</div>" );
                    
                }
                
                con.close();
                
            } // end try
            catch(Exception e )
            {
                out.println(e.getMessage());
            } // end catch

        %>
    </body>
</html>
            
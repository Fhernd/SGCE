/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package upload;

import com.mysql.jdbc.Connection;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author infzero
 */
public class Test
{
    public static void main( String[] args )
    {
        
            //        String raw = "00000000100000000-";
            //        
            //        String saldoAnterior = removeFrontZeros( raw );
            //        
            //        if( raw.charAt( raw.length() - 1 ) == '-')
            //        {
            //                        if( !saldoAnterior.equals( "0" ) )
            //                        {
            //                            saldoAnterior = "-" + saldoAnterior;
            //                                    
            //                        }
            //                        System.out.println( Double.parseDouble( saldoAnterior ) );
            //        }
                    
            //        String fechaExtraco = "";
            //        
            //        Date now = new Date();
            //        fechaExtraco = DateFormat.getInstance().format( now );
            //        
            //        System.out.println( fechaExtraco );
                    
            //        String fechaDocumento = "20131401";
            //        
            //        String ahnio = fechaDocumento.substring(0, 4);
            //        String mes = fechaDocumento.substring(4, 6);
            //        String dia = fechaDocumento.substring(6, 8);
            //        
            //        
            //        System.out.println( ahnio );
            //        System.out.println( mes );
            //        System.out.println( dia );
                    
                    
            //  Calendar currentDate = Calendar.getInstance();
            //  SimpleDateFormat formatter=   new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            //  String dateNow = formatter.format(currentDate.getTime());
            //  System.out.println("Now the date is :=>  " + dateNow);
                    
            //        Properties configProp = new Properties();
            //        try {
            //            configProp.load( Class.class.getResourceAsStream( "/upload/config.properties" ));
            //        } catch (IOException ex) {
            //            System.out.println( "Error: " + ex );
            //        }
            //
            //        System.out.println( configProp.getProperty("hello.world") );
                    
                    
//                      mail.MailSender ms = new mail.MailSender();
//                    
//                    
//
//                    ms.startSendMail( "edithgarcia3009@gmail.com", "Arval Bienes Raices - Cupon de Pago Online", "Para ver su cupon de pago dirigase al siguiente enlace: http://www.arvalbr.com/sgce-arval e inice sesion con sus credenciales.", "info@arvalbr.com", "M3VEBtFP", "info@arvalbr.com", "info@arvalbr.com");
        
        Test t = new Test();
        try {
            t.sendMail();
        } catch (SQLException ex) {
            Logger.getLogger(Test.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
    
    public static  String removeFrontZeros(String valor )
    {
        String nuevoValorDebito = "";
        
        if( valor.endsWith( "+" ) || valor.endsWith( "-" ) )
        {
            valor = valor.substring(0 , valor.length() - 1 );
        } //
        
        for (int i = 0; i < valor.length(); ++i )
        {
            if( valor.charAt( i ) == '0' )
            {
                continue;
            }
            else
            {
                nuevoValorDebito = valor.substring(i, valor.length() );
                
                break;
            } // end else
        } // end for
        
        return "".equals(nuevoValorDebito) ? "0" : nuevoValorDebito;
    } // end method removeFrontZeros
    
    public void sendMail( ) throws SQLException
    {
        Connection con = null;
    ResultSet rst = null;
    ResultSet tempRst = null;
    Statement stmt = null;
    Statement stmtSelIdNit = null;
    
    try
    {

        String driver = "com.mysql.jdbc.Driver";
        Class.forName(driver).newInstance();
        
        con=(Connection) DriverManager.getConnection( "jdbc:mysql://localhost/certextrdb", "root", "" );
        
        stmt=(Statement) con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );
        stmtSelIdNit=(Statement) con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );
        
        String selId = "SELECT usuario_idcedulanit FROM usuario_como_inquilino";
        
        rst = stmt.executeQuery( selId );
        
        ArrayList<String> usuario_idCedulaNits = new ArrayList<String>();
        
        while( rst.next() )
        {
            usuario_idCedulaNits.add( rst.getString( "usuario_idcedulanit"));
        }
        
        Iterator<String> it = usuario_idCedulaNits.iterator(); 
       
        Pattern p = Pattern.compile(".+@.+\\.[a-z]+");
        
        int contadorEnviosEmail = 0;
        
        
        
        
        // recupera datos de la cuenta de email para envíos
        String selEmailParams = "SELECT * FROM emailparams WHERE emailtype = 3";
        
        rst = stmt.executeQuery(selEmailParams );
        
        String emailAdmin = "";
        String emailPW = "";
        String emailUrl = "";
        String asunto = "";
        String contenido = "";
        
        if( rst.next() )
        {
            emailAdmin = rst.getString( "email" );
            emailPW = rst.getString( "password" );
            emailUrl = rst.getString( "url" );
            asunto = rst.getString( "asunto" );
            contenido = rst.getString( "contenido" );
            
            
        }
        
        while( it.hasNext() )
        {
            String tempId = it.next();


            tempRst = stmtSelIdNit.executeQuery("SELECT * FROM usuario WHERE idcedulanit = " + tempId + " AND nivelacceso = 2");

            if( tempRst.next() )
            {

                Matcher m = p.matcher(tempRst.getString("email"));
                
                boolean matchFound = m.matches();

                if( matchFound )
                {
                    mail.MailSender ms = new mail.MailSender();
                    
                    ++contadorEnviosEmail;

                    ms.startSendMail( "fernd.ortiz@gmail.com", "Arval BR - Cupon de Pago Online" , "Para ver su Cupon de Pago dirigase al siguiente enlace: http://www.arvalbr.com/sgce-arval e inice sesion ingresando en usuario y contranseña su numero de cedula o nit. Luego de click en Cupon de Pago y click en visualizar o descargar.", "fernd.ortiz@gmail.com", "/*2013SysEngDeUA", "fernd.ortiz@gmail.com", "fernd.ortiz@gmail.com");
                }else
                {


                }
            }
        }
        
        if( contadorEnviosEmail != 0 )
                       {
            System.out.print( "<div class=\"success\">Env&iacute;o correcto de emails.</div>" );
        }
        else
                       {
            System.out.print( "<div class=\"warning\">Las cuentas de Inquilinos no poseen direcci&oacute;n de email.</div>" );
        }
       
    } // end try
    catch(Exception e )
    {
        e.printStackTrace();
        System.out.print( "<div class=\"error\">Debe seleccionar una fecha para enviar emails.</div>" );
        con.close();
    } // end catch*/
    }
}

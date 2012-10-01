/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package upload;

/**
 *
 * @author John Ortiz
 * 
 */
import com.mysql.jdbc.Connection;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ParseCupones
{
    public void startParse( String fileName ) throws SQLException, ClassNotFoundException
    {
        File file = new File( fileName ); // sourceFile
        
        BufferedReader reader = null;
        
        ArrayList< String > elements  = new ArrayList< String >();

        try 
        {
            reader = new BufferedReader(new FileReader(file));
            String text = null;

            // repeat until all lines is read
            while ( (text = reader.readLine() ) != null ) 
            {
                String[] campos = text.split( ";" );

                for (int i = 0; i < campos.length; ++i )
                {
                   elements.add( campos[ i ].trim().replaceAll( " +", " " ) );
                } // end for
            } // end while
        } // end try
        catch (FileNotFoundException e) 
        {
            //e.printStackTrace();
        } // end catch: FileNotFoundException
        catch (IOException e) 
        {
            //e.printStackTrace();
        } // end catch: IOException
        finally 
        {
            try 
            {
                if (reader != null) 
                {
                    reader.close();
                } // end if
            }
            catch (IOException e) 
            {
                //e.printStackTrace();
            } // end catch: IOException
        } // end finally        

        saveOnDB( elements );

    } // end method startParse

    
     private void saveOnDB( ArrayList< String > elements ) throws SQLException, ClassNotFoundException
     {
                 // carga las propiedades de la base de datos
        Properties dbconfig = new Properties();
        try 
        {
            dbconfig.load( this.getClass().getResourceAsStream( "/upload/dbconfig.properties"));
        }
        catch (IOException ex)
        {
            System.err.println( "Error: " + ex.toString() );
        }
        
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = (Connection) DriverManager.getConnection (dbconfig.getProperty("dburl") + "/" + dbconfig.getProperty("dbname"), dbconfig.getProperty("dbuser"), dbconfig.getProperty("dbpw"));
        int count = 0;
         
         //  aux variables
         String idCedulaNit = "";
         String codigoInquilino = "";
        Calendar currentDate = Calendar.getInstance();
        SimpleDateFormat formatter=   new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        String fechaCuponPago = formatter.format(currentDate.getTime());
         
         while( count < elements.size() )
         {
            String referenciaPago = "";
            String mesAgnioCanon = "";
            String direccionInmueble = "";
            String direccionCorrespondencia = "";
            String ciudadCorrespondencia = "";
            String canonArrendamiento = "";
            String administracionPh = "";
            String servicios = "";
            String ivaCanon = "";
            String retencionIvaCanon = "";
            String retencionFuente = "";
            String retencionIca = "";
            String otrosCobros = "";
            String totalPagar = "";
            String fechaPagosSinVencimiento = "";
            String valorPagosSinVencimiento = "";
            String fechaPagoPrimerVencimiento = "";
            String valorPagoPrimerVencimiento = "";
            String fechaPagoSegundoVencimiento = "";
            String valorPagoSegundoVencimiento = "";
            String detalleOtrosCobros = "";


            /* Busca por la cédula o NIT. Si el usuario no existe, se encarga de crearlo.
            * Siendo así, también se deberá crear los inmuebles asociados con ese usuario.
            */
            
            if( !userIDExists( removeFrontZeros( elements.get( count )  ) ,con ) )
            {
                idCedulaNit = removeFrontZeros( elements.get( count + 2 ));
                String nombrePropietario = elements.get( count + 3 );

                createUser( idCedulaNit, firstLetterCapital( nombrePropietario ), elements.get( count + 25 ).toLowerCase(), removeFrontZeros( idCedulaNit ), 2, con  ); //  include fields from 1 to 11

                //  información general de cupón de pago 
                codigoInquilino = elements.get( count ) + elements.get( count + 1 );
                referenciaPago = removeFrontZeros( elements.get( count + 4 ) );
                mesAgnioCanon = elements.get( count + 5 );
                direccionInmueble = firstLetterCapital( elements.get( count + 6 ) ).replace( '\'', '_').replace( '\\', '_');
                direccionCorrespondencia = firstLetterCapital( elements.get( count + 7 )).replace( '\'', '_').replace( '\\', '_');
                ciudadCorrespondencia = firstLetterCapital( elements.get( count + 8 ) ).replace( '\'', '_').replace( '\\', '_');

                canonArrendamiento = removeFrontZeros( elements.get( count + 9 ) );
                administracionPh = removeFrontZeros( elements.get( count + 10 ) );

                servicios = removeFrontZeros( elements.get( count + 11 ) );
                ivaCanon = removeFrontZeros( elements.get( count + 12 ) );
                retencionIvaCanon = removeFrontZeros( elements.get( count + 13 ) );
                retencionFuente = removeFrontZeros( elements.get( count + 14 ) );
                retencionIca = removeFrontZeros( elements.get( count + 15 ) );

                otrosCobros = removeFrontZeros( elements.get( count + 16 ) );
                totalPagar = removeFrontZeros( elements.get( count + 17 ) );
                fechaPagosSinVencimiento = formatDate( elements.get( count + 18 ) ); 
                valorPagosSinVencimiento = removeFrontZeros( elements.get( count + 19 ) );
                fechaPagoPrimerVencimiento = formatDate( elements.get( count + 20 ) );

                valorPagoPrimerVencimiento = removeFrontZeros( elements.get( count + 21 ) );

                fechaPagoSegundoVencimiento = formatDate( elements.get( count + 22 ) );
                valorPagoSegundoVencimiento = elements.get( count + 23 );
                detalleOtrosCobros = elements.get( count + 24 );
                
                //  graba sobre la base de datos los datos de la cuenta actual
                if( !inquilinoExists( codigoInquilino, con ) )
                {
                    createInquilinoAccount( Long.parseLong( codigoInquilino ), Long.parseLong( idCedulaNit ), referenciaPago,mesAgnioCanon, direccionInmueble, direccionCorrespondencia, ciudadCorrespondencia, Double.parseDouble( canonArrendamiento ), Double.parseDouble( administracionPh ), 
                                    Double.parseDouble( servicios ), Double.parseDouble( ivaCanon ), Double.parseDouble( retencionIvaCanon ), Double.parseDouble( retencionFuente ), Double.parseDouble( retencionIca ), Double.parseDouble( otrosCobros ), Double.parseDouble( totalPagar ), fechaPagosSinVencimiento, 
                                    Double.parseDouble( valorPagosSinVencimiento ), fechaPagoPrimerVencimiento, Double.parseDouble( valorPagoPrimerVencimiento ), fechaPagoSegundoVencimiento, Double.parseDouble( valorPagoSegundoVencimiento ), detalleOtrosCobros, fechaCuponPago, con);

                }
            }  // end if: test if a user exists.
            else
            {
                idCedulaNit = removeFrontZeros( elements.get( count + 2 ) );

                //  información general de cupón de pago 
                codigoInquilino = elements.get( count ) + elements.get( count + 1 );
                referenciaPago = removeFrontZeros( elements.get( count + 4 ) );
                mesAgnioCanon = elements.get( count + 5 );
                direccionInmueble = firstLetterCapital( elements.get( count + 6 ) ).replace( '\'', '_').replace( '\\', '_');
                direccionCorrespondencia = firstLetterCapital( elements.get( count + 7 )).replace( '\'', '_').replace( '\\', '_');
                ciudadCorrespondencia = firstLetterCapital( elements.get( count + 8 ) ).replace( '\'', '_').replace( '\\', '_');

                canonArrendamiento = removeFrontZeros( elements.get( count + 9 ) );
                administracionPh = removeFrontZeros( elements.get( count + 10 ) );

                servicios = removeFrontZeros( elements.get( count + 11 ) );
                ivaCanon = removeFrontZeros( elements.get( count + 12 ) );
                retencionIvaCanon = removeFrontZeros( elements.get( count + 13 ) );
                retencionFuente = removeFrontZeros( elements.get( count + 14 ) );
                retencionIca = removeFrontZeros( elements.get( count + 15 ) );

                otrosCobros = removeFrontZeros( elements.get( count + 16 ) );
                totalPagar = removeFrontZeros( elements.get( count + 17 ) );
                fechaPagosSinVencimiento = formatDate( elements.get( count + 18 ) ); 
                valorPagosSinVencimiento = removeFrontZeros( elements.get( count + 19 ) );
                fechaPagoPrimerVencimiento = formatDate( elements.get( count + 20 ) );

                valorPagoPrimerVencimiento = removeFrontZeros( elements.get( count + 21 ) );

                fechaPagoSegundoVencimiento = formatDate( elements.get( count + 22 ) );
                valorPagoSegundoVencimiento = elements.get( count + 23 );
                detalleOtrosCobros = elements.get( count + 24 );
                
                //  prueba si la cuenta del inquilino ya existe
                if( !inquilinoExists( codigoInquilino, con ) )
                {
                    createInquilinoAccount( Long.parseLong( codigoInquilino ), Long.parseLong( idCedulaNit ), referenciaPago,mesAgnioCanon, direccionInmueble, direccionCorrespondencia, ciudadCorrespondencia, Double.parseDouble( canonArrendamiento ), Double.parseDouble( administracionPh ), 
                                            Double.parseDouble( servicios ), Double.parseDouble( ivaCanon ), Double.parseDouble( retencionIvaCanon ), Double.parseDouble( retencionFuente ), Double.parseDouble( retencionIca ), Double.parseDouble( otrosCobros ), Double.parseDouble( totalPagar ), fechaPagosSinVencimiento, 
                                            Double.parseDouble( valorPagosSinVencimiento ), fechaPagoPrimerVencimiento, Double.parseDouble( valorPagoPrimerVencimiento ), fechaPagoSegundoVencimiento, Double.parseDouble( valorPagoSegundoVencimiento ), detalleOtrosCobros, fechaCuponPago, con);
                }
                else //  update property details
                {
                    updateInquilinoAccount( Long.parseLong( codigoInquilino ), Long.parseLong( idCedulaNit ), referenciaPago,mesAgnioCanon, direccionInmueble, direccionCorrespondencia, ciudadCorrespondencia, Double.parseDouble( canonArrendamiento ), Double.parseDouble( administracionPh ), 
                                            Double.parseDouble( servicios ), Double.parseDouble( ivaCanon ), Double.parseDouble( retencionIvaCanon ), Double.parseDouble( retencionFuente ), Double.parseDouble( retencionIca ), Double.parseDouble( otrosCobros ), Double.parseDouble( totalPagar ), fechaPagosSinVencimiento, 
                                            Double.parseDouble( valorPagosSinVencimiento ), fechaPagoPrimerVencimiento, Double.parseDouble( valorPagoPrimerVencimiento ), fechaPagoSegundoVencimiento, Double.parseDouble( valorPagoSegundoVencimiento ), detalleOtrosCobros, fechaCuponPago, con );
                } //  end else
            } //  end else
             
            // adds up to 25 units
            count += 26;
            
         }  // end while
         
         con.close();
     } // end method saveOnDB
     
    /**
     * Comprueba si el usuario existe en la base de datos.
     * 
     * @param idCedulaNit Documento de identidad del cliente o la empresa
     * @return Si el documento de identidad existe devuelve <em>true</em>, en caso contrario <em>false</em>.
     */
    private boolean userIDExists( String idCedulaNit, Connection con ) 
    {
        ClassConnection cc = new ClassConnection();
        
        //System.out.println( idCedulaNit );
       //System.out.print( idCedulaNit );
       Boolean presente = (Boolean) cc.execute( "SELECT idcedulanit FROM usuario WHERE idcedulanit = " + Long.parseLong( idCedulaNit ) , 2, con);
       
       return presente;
    } // end method userIDExists

    /**
     * Crea un nuevo usuario
     * 
     * @param idCedulaNit Documento de identidad del cliente o la empresa
     * @param nombrePropietario Nombre del propieatario del inmueble
     * @param contrasegnia Contraseña asignada a la cuenta de este cliente o empresa
     * @param email Email
     */
    private void createUser( String idCedulaNit, String nombrePropietario, String email, String contrasegnia, int nivelAcceso, Connection con ) 
    {
        ClassConnection cc = new ClassConnection();
        
        cc.execute( "INSERT INTO usuario VALUES (" + Long.parseLong( idCedulaNit ) + ", '" + nombrePropietario + "', '" + email + "', '" +  contrasegnia +"', " + nivelAcceso + ")", 1, con);
    } // end method createUser

    /**
     * 
     * @param valor Cadena que representa el valor a ser transformado
     * @return Retorna el valor convertido en un formato predeterminado.
     */
    private   String removeFrontZeros(String valor )
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

    /**
     * Crea un nuevo inmueble y lo asocia con el cliente o empresa pasado como argumento (idCedulaNit).
     * 
     * @param codigoInquilino Una de las cuentas asociadas al cliente
     * @param pais País de localización del inmueble
     * @param ciudad Ciudad donde está localizado el inmueble
     * @param saldoAnterior Saldo de la cuenta asociado al inmueble
     * @param idCedulaNit Documento de identidad del cliente o empresa
     * 
     * @return [Nota: Este es un método mutador.]
     */
    private   void createInquilinoAccount( long codigoInquilino, long idCedulaNit, String referenciaPago, String mesAgnioCanon, String direccionInmueble, String direccionCorrespondencia, String ciudadCorrespondencia, double canonArrendamiento, double administracionPh, 
                                              double servicios, double ivaCanon, double retencionIvaCanon, double retencionFuente, double retencionIca, double otrosCobros, double totalPagar, String fechaPagosSinVencimiento, double valorPagosSinVencimiento, 
                                              String fechaPagoPrimerVencimiento, double valorPagoPrimerVencimiento, String fechaPagoSegundoVencimiento, double valorPagoSegundoVencimiento, String detalleOtrosCobros, String fechaCuponPago, Connection con ) 
    {
        
        ClassConnection cc = new ClassConnection();
        
        cc.execute( "INSERT INTO usuario_como_inquilino (  codigoinquilino  , usuario_idcedulanit  , referenciapago  , mesagniocanon  , direccioninmueble  , direccioncorrespondencia  , ciudadcorrespondencia, canonarrendamiento  , administracionph  , servicios  , ivacanon  , retencionivacanon  , retencionfuente  , retencionica  , otroscobros  , totalpagar  , fechapagosinvencimiento  , valorpagosinvencimiento  , fechapagoprimervencimiento  , valorpagoprimervencimiento  , fechapagosegundovencimiento  , valorpagosegundovencimiento  , detalleotroscobros, fechaadicioncuponpago ) VALUES (" + codigoInquilino + ", " + idCedulaNit + ", '" + referenciaPago + "', '" + mesAgnioCanon + "', '" + direccionInmueble+ "', '" + direccionCorrespondencia + "', '" + ciudadCorrespondencia + "', " + canonArrendamiento + ", " + administracionPh + ", " + servicios + ", " + ivaCanon + ", " + retencionIvaCanon + ", " + retencionFuente + ", " + retencionIca + ", " + otrosCobros + ", " + totalPagar + ", '" + fechaPagosSinVencimiento + "', " + valorPagosSinVencimiento + ", '" + fechaPagoPrimerVencimiento + "', " + valorPagoPrimerVencimiento + ", '" + fechaPagoSegundoVencimiento + "', " + valorPagoSegundoVencimiento + ", '" + detalleOtrosCobros + "', '" + fechaCuponPago + "')", 1, con);
    } // end method create property

    /**
     * 
     * @param codigoinquilino
     * @return 
     */
    private   boolean inquilinoExists(String codigoinquilino, Connection con )
    {
       ClassConnection cc = new ClassConnection();
       boolean presente = (Boolean)cc.execute( "SELECT codigoinquilino FROM usuario_como_inquilino WHERE codigoinquilino = " + Long.parseLong( codigoinquilino ), 2, con);
       
       return presente;
    } // end method propertyExists

    
    /**
     * Actualiza el saldo anterior de un inmueble que coincida con el código de la cuenta y el documento de identidad del propietario.
     * 
     * @param codigoInquilino Código de la cuenta asociada con el inmueble
     * @param idCedulaNit Documento de identidad del cliente o empresa
     * @param saldoAnterior Saldo anterior asociado el inmueble (Este debe actualizarse en la base de datos.
     */
    private   void updateInquilinoAccount( long codigoInquilino, long idCedulaNit, String referenciaPago, String mesAgnioCanon, String direccionInmueble, String direccionCorrespondencia, String ciudadCorrespondencia, double canonArrendamiento, double administracionPh, 
                                              double servicios, double ivaCanon, double retencionIvaCanon, double retencionFuente, double retencionIca, double otrosCobros, double totalPagar, String fechaPagosSinVencimiento, double valorPagosSinVencimiento, 
                                              String fechaPagoPrimerVencimiento, double valorPagoPrimerVencimiento, String fechaPagoSegundoVencimiento, double valorPagoSegundoVencimiento, String detalleOtrosCobros, String fechaCuponPago, Connection con ) 
    {
        ClassConnection cc = new ClassConnection();
        
        cc.execute( "UPDATE usuario_como_inquilino SET referenciapago = '" + referenciaPago + "', mesagniocanon = '" + mesAgnioCanon + "', direccioninmueble = '" + direccionInmueble + "', direccioncorrespondencia = '" + direccionCorrespondencia +  "', ciudadcorrespondencia = '" + ciudadCorrespondencia + "', canonarrendamiento = " + canonArrendamiento + ", administracionph = " + administracionPh + ", servicios = " + servicios + ", ivacanon = " + ivaCanon + ", retencionivacanon = " + retencionIvaCanon + ", retencionfuente = " + retencionFuente + ", retencionica = " + retencionIca + ", otroscobros = " + otrosCobros + ", totalpagar = " + totalPagar + ", fechapagosinvencimiento = '" + fechaPagosSinVencimiento + "', valorpagosinvencimiento = " + valorPagosSinVencimiento + ", fechapagoprimervencimiento = '" + fechaPagoPrimerVencimiento + "', valorpagoprimervencimiento = " + valorPagoPrimerVencimiento + ", fechapagosegundovencimiento = '" + fechaPagoSegundoVencimiento + "', valorpagosegundovencimiento = " + valorPagoSegundoVencimiento + ", detalleotroscobros = '" + detalleOtrosCobros + "', fechaadicioncuponpago = '" + fechaCuponPago + "' WHERE codigoinquilino = " + codigoInquilino + " AND usuario_idcedulanit = " + idCedulaNit, 1, con );
    } // end method updateProperty
    
    /**
     * Formatea el nombre de un propietario: primera letra en mayúscula
     * @param name Nombre del propietario
     * @return Nombre del propieatario formateado
     */
    private   String firstLetterCapital( String name )
    {
      StringBuffer stringbf = new StringBuffer();
      Matcher m = Pattern.compile("([a-z])([a-z]*)",
      Pattern.CASE_INSENSITIVE).matcher(name);
      while (m.find())
      {
         m.appendReplacement(stringbf, 
         m.group(1).toUpperCase() + m.group(2).toLowerCase());
      } // end while
      
      return m.appendTail(stringbf).toString();
    } // end method firstLetterCapital
    
    private   String formatDate( String date )
    {
        
        String day = date.substring(8, 10);
        String month = date.substring( 5, 7 );
        String year = date.substring(0, 4 );
            
        return String.format( "%s-%s-%s", year, month, day );
    } // end method formatDate
    
    public static void main( String[] args ) throws SQLException, ClassNotFoundException
    {
        ParseCupones pe = new ParseCupones();
        
        pe.startParse( "C:\\CARTERA.TXT" );
    } // end main

    private String convertToMdy(String fechaDocumento)
    {
        String ahnio = fechaDocumento.substring(0, 4);
        String mes = fechaDocumento.substring(4, 6);
        String dia = fechaDocumento.substring(6, 8);
        
        return String.format( "%s-%s-%s", ahnio, mes, dia );
    }
} // end class ParseCupones
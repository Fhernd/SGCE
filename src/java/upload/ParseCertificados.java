package upload;

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
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ParseCertificados
{
    private int sizeAL = 0;
    
    public void startParse( String fileName) throws SQLException, ClassNotFoundException 
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

                for (int i = 0; i < ( campos.length - 1 ); ++i )
                {
                   elements.add( campos[ i ].trim().replaceAll( " +", " " ) );
                } // end for
            } // end while
        } // end try
        catch (FileNotFoundException e) 
        {
            System.out.println( e.getMessage()  );
        } // end catch: FileNotFoundException
        catch (IOException e) 
        {
            System.out.println( e.getMessage()  );
        } // end catch: IOException
        finally 
        {
            try 
            {
                if (reader != null) 
                {
                    reader.close();
                } // end if
            } // end try
            catch (IOException e) 
            {
                System.out.println( e.getMessage()  );
            } // end catch: IOException
        } // end finally

        sizeAL = elements.size();
        saveOnDB( elements );
    } // end main
    
    
    private void saveOnDB( ArrayList< String > elements ) throws SQLException, ClassNotFoundException
    {
        int count = 0;
        
        // aux variables
        String idCedulaNit = "";
        String codigoCuenta = "";
        long idCertificado = 0;
        
        Calendar currentDate = Calendar.getInstance();
        SimpleDateFormat formatter=   new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        String fechaCertificado = formatter.format(currentDate.getTime());
        
        // carga las propiedades de la base de datos
        Properties dbconfig = new Properties();
        try {
            dbconfig.load( this.getClass().getResourceAsStream( "/upload/dbconfig.properties"));
        }
        catch (IOException ex)
        {
            System.err.println( "Error: " + ex.toString() );
        }
        
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = (Connection) DriverManager.getConnection (dbconfig.getProperty("dburl") + "/" + dbconfig.getProperty("dbname"), dbconfig.getProperty("dbuser"), dbconfig.getProperty("dbpw"));
        
        
        while( count < elements.size() )
        {
            // test registry type
            switch( Integer.parseInt( elements.get( count ) ) )
            {
                
                // Registry no. 1
                case 1:
                    
                    /* Busca por la cédula o NIT. Si el usuario no existe, se encarga de crearlo.
                    * Siendo así, también se deberá crear los inmuebles asociados con ese usuario.
                    */
                    if( !userIDExists( removeFrontZeros( elements.get( count + 6 )  ), con ) )
                    {
                        
                        idCedulaNit = removeFrontZeros( elements.get( count + 6 ));
                        String nombrePropietario = elements.get( count + 5 );
                        
                        createUser( idCedulaNit, firstLetterCapital( nombrePropietario ), "", removeFrontZeros( idCedulaNit ), 3, con   ); // include fields from 1 to 11
                        
                        // crear inmuebles
                        codigoCuenta = elements.get( count + 3 ) + elements.get( count + 4 );
                        String pais = "";
                        String ciudad = "";
                        String direccion = "";
                        
                        // graba sobre la base de datos
                        if( !accountExists(codigoCuenta, con))
                        {   
                            createAccount( codigoCuenta, pais, ciudad, direccion, con );
                        }
                        
                        createUserAccount( idCedulaNit, codigoCuenta, con );
                        
                    } // end if: test if a user exists.
                    else
                    {
                        codigoCuenta = elements.get( count + 3 ) + elements.get( count + 4 );
                        idCedulaNit = removeFrontZeros( elements.get( count + 6 ) );
                        
                        //System.out.println( "Código cuenta: " + codigoCuenta );
                        
                        // test if the property exists
                        if( !accountExists( codigoCuenta, con ) )
                        {
                            createAccount( codigoCuenta, "", "", "", con );
                        } // end if
                        
                        
                        createUserAccount( idCedulaNit, codigoCuenta, con );
                    } // end else
                    
                    String agnioGravable = elements.get( count + 1 );
                    String fechaEmision = formatDate( elements.get( count + 2 ) );
                    
                    String saldoDicAnterior = "";
                    
                    if( elements.get( count + 8 ).equals( "DB" ) )
                    {
                        saldoDicAnterior = "-" + removeFrontZeros( elements.get( count + 7 ) );
                    }
                    else
                    {
                        saldoDicAnterior = removeFrontZeros( elements.get( count + 7 ) );   
                    }

                    String saldoDicGravable = "";
                    
                    if( elements.get( count + 10 ).equals( "DB" ) )
                    {
                        saldoDicGravable = "-" + removeFrontZeros( elements.get( count + 9 ) );
                    }
                    else
                    {
                        saldoDicGravable = removeFrontZeros( elements.get( count + 9 ) );
                    }
                    
                    String porcentajeParticipacion = elements.get( count + 11 ).equals( "" ) ? "0" : elements.get( count + 11 ).replace( ",", "." );
                    
                    // create a new extract and obtains the extract's idReporte
                    idCertificado = createCertificate( agnioGravable, fechaEmision, removeFrontZeros( saldoDicAnterior ), removeFrontZeros( saldoDicGravable ), 
                                                    removeFrontZeros( porcentajeParticipacion ), codigoCuenta, fechaCertificado, Long.parseLong( idCedulaNit ), con );
                                        
                    count += 13;
                    
                    System.out.println( idCedulaNit );
                    
                    break;
                    
                // Registry no. 2    
                case 2: // registry type 2
                    
                    String direccionInmueble = "";
                    
                    ++count; // first registry of reg. type 2

                    direccionInmueble = elements.get( count );

                    // escribe sobre la base de datos
                    insertIntoRegistry2(direccionInmueble, fechaCertificado, Long.parseLong( codigoCuenta ), con );

                    ++count; // next detail (or next registry type 3, if any)
                    
                    break;
                    
                // Registry no. 3
                case 3: // registry type 3
                    
                    while( count < elements.size() && isNumeric( elements.get( count ) ) && Long.parseLong( elements.get( count ) ) == 3  )
                    {
                        ++count; // first element of reg. type 3
                        String descripcionTransaccion = "";
                        String signo = "";
                        String valorTransaccion = "";

                        if( count < elements.size() )
                            descripcionTransaccion = firstLetterCapital( elements.get( count ) );
                        
                        ++count;
                        if( count < elements.size() )
                            valorTransaccion = removeFrontZeros( elements.get( count ) );
                        
                        ++count;
                        if( count < elements.size() )
                            signo = elements.get( count );
                        
                        boolean debito = false;
                        
                        if( count < elements.size() )
                            if( signo.equals( "DB" ) )
                            {
                                debito = true;
                            }
                        if( count < elements.size() )
                            insertIntoRegistry3( descripcionTransaccion, valorTransaccion.toString().equals( "" ) ? "0" : valorTransaccion, "", fechaCertificado, debito, Long.parseLong( codigoCuenta ), con );

                        ++count;
                    } // end while
                    
                    break;
            } // end switch
        } // end while
        
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
        ClassConnectionCert ccc = new ClassConnectionCert();
        
       Boolean presente = (Boolean) ccc.execute( "SELECT idcedulanit FROM usuario WHERE idcedulanit = " + Long.parseLong( idCedulaNit ) , 2, con );
       
       return presente;
    } // end method userIDExists
    
    /**
     * Determina si una cadena pasada como argumento coniene sólo números.
     * 
     * @param numeroCadena Cadena de caracteres
     * @return Returna <em>true</em> si el valor pasado corresponde a un número, en caso contrario <em>false</em>.
     */
    private boolean isNumeric(String numeroCadena ) 
    {
        return java.util.regex.Pattern.matches("\\d+", numeroCadena);
    } // end method isNumeric

    /**
     * Inserte un nuevo registro de tipo 3, con el ID del extracto.
     * 
     * @param fechaDocumento Fecha en la se realiza la privateación o gestión del documento.
     * @param documento Tipo del documento.
     * @param numero Número del documento.
     * @param transaccion Tipo de transacción.
     * @param detalleTransaccion Detalle de la transacción.
     * @param detalle Detalle
     * @param valorDebito Valor débido de la transacción.
     * @param valorCredito Valor crédito de la transacción.
     * @param saldo Saldo del reporte.
     * @param idExtracto ID con el que se asociará esta entrada
     */
    private void insertIntoRegistry2( String direccion, String fCert, long codigoCuenta, Connection con )
    {
        ClassConnectionCert ccc = new ClassConnectionCert();
        
        ccc.execute( "INSERT INTO certregtipo2 ( direccioninmueble, fechahoraagregado, codigocuenta ) VALUES ('" + direccion + "', '" + fCert + "', " + codigoCuenta + ")", 1, con );
    } // end method insertIntoRegistry3

    /**
     * Crea un nuevo registro de tipo 3
     * 
     * @param descripcionTransaccion Total débitos
     * @param valorTransaccion Total crédito
     * @param espacios Total saldo actual
     * @param totalArrendamientos Total arrendimientos
     * @param totalComisiones Total comisiones
     * @param totalSeguro Total seguro
     * @param totalGastos Total gastos
     * @param totalReparaciones Total reparaciones
     * @param totalOtros Total otros
     * @param espacios Espacios
     * @param idExtracto ID con el que se asociará esta entrada
     */
    private void insertIntoRegistry3(String descripcionTransaccion, String valorTransaccion, String espacios, String cCert, boolean debito, long codigoCuenta, Connection con ) 
    {
        ClassConnectionCert ccc = new ClassConnectionCert();
        
        double vT = 0.0;
        
        if( debito )
        {
            vT = Double.parseDouble( valorTransaccion ) * -1;
        }
        else
        {
            vT = Double.parseDouble( valorTransaccion );
        }
        
        ccc.execute( "INSERT INTO certregtipo3 ( descripciontransaccion, valortransaccion, espacios, fechahoraagregado, codigocuenta )VALUES ( '" + 
                         descripcionTransaccion + "', " + vT + ", '" + espacios + "', '" + cCert + "', " + codigoCuenta + ")", 1, con );
    } // end method insertIntoRegistry3


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
        ClassConnectionCert ccc = new ClassConnectionCert();
        
        ccc.execute( "INSERT INTO usuario VALUES (" + Long.parseLong( idCedulaNit ) + ", '" + nombrePropietario+ "', '" + email + "', '" +  contrasegnia +"', " + nivelAcceso + ")", 1, con );
    } // end method createUser

    /**
     * 
     * @param valor Cadena que representa el valor a ser transformado
     * @return Retorna el valor convertido en un formato predeterminado.
     */
    private String removeFrontZeros(String valor )
    {
        String nuevoValor = "";
        
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
                nuevoValor = valor.substring(i, valor.length() );
                
                break;
            } // end else
        } // end for
        
        return "".equals( nuevoValor ) ? "0" : nuevoValor;
    } // end method removeFrontZeros

    /**
     * Crea un nuevo inmueble y lo asocia con el cliente o empresa pasado como argumento (idCedulaNit).
     * 
     * @param codigoCuenta Una de las cuentas asociadas al cliente
     * @param pais País de localización del inmueble
     * @param ciudad Ciudad donde está localizado el inmueble
     * @param idCedulaNit Documento de identidad del cliente o empresa
     * 
     * @return [Nota: Este es un método mutador.]
     */
    private void createAccount(String codigoCuenta, String pais, String ciudad, String direccion, Connection con  ) 
    {
        ClassConnectionCert ccc = new ClassConnectionCert();
        
        ccc.execute( "INSERT INTO cuenta VALUES (" + Long.parseLong( codigoCuenta) + ", '" + pais + "', '" + ciudad + "', '" + direccion + "')", 1, con );
    } // end method create property

    /**
     * 
     * @param codigoCuenta
     * @return 
     */
    private boolean accountExists(String codigoCuenta, Connection con )
    {
        ClassConnectionCert ccc = new ClassConnectionCert();
        
        
       boolean presente = (Boolean) ccc.execute( "SELECT codigocuenta FROM cuenta WHERE codigocuenta = " + Long.parseLong( codigoCuenta ), 2, con );
       
       return presente;
    } // end method propertyExists

    
    /**
     * Actualiza el saldo anterior de un inmueble que coincida con el código de la cuenta y el documento de identidad del propietario.
     * 
     * @param codigoCuenta Código de la cuenta asociada con el inmueble
     * @param idCedulaNit Documento de identidad del cliente o empresa
     * @param saldoAnterior Saldo anterior asociado el inmueble (Este debe actualizarse en la base de datos.
     */
    private void updateAccount(String codigoCuenta, String idCedulaNit, String saldoAnterior, Connection con  ) 
    {
        ClassConnectionCert ccc = new ClassConnectionCert();
        
        ccc.execute( "UPDATE cuenta SET saldoanterior = " + Double.parseDouble( saldoAnterior ) + " WHERE codigocuenta = " + Long.parseLong( codigoCuenta ) + " AND usuario_idcedula = " + Long.parseLong( idCedulaNit)  , 1, con );
    } // end method updateProperty

    
    private long createCertificate( String agnioGravable, String fechaEmision, String saldoDicAnterior, String saldoDicGravable , String porcentajeParticipacion, String codigoCuenta, String fCert, long idCert, Connection con )
    {
        ClassConnectionCert ccc = new ClassConnectionCert();   
        
        long lastIdCertificados = ( Long ) ccc.execute( "INSERT INTO certificados( agniogravable, fechaemision, saldodicanterior, saldodicgravable, porcentajeparticipacion, cuenta_codigocuenta, fechahoraagregado, usuarioid ) VALUES ( '" + 
                                                      agnioGravable + "', '" + fechaEmision + "', " + Double.parseDouble( saldoDicAnterior ) + ", " + Double.parseDouble( saldoDicGravable) + "," + 
                                                      Double.parseDouble( porcentajeParticipacion ) + ", "+ Long.parseLong( codigoCuenta ) + ",'" + fCert +  "', " + idCert + ")", 3, con );
        
        return lastIdCertificados;
    } // end method createExtract
    
    private String formatDate( String date )
    {
        // 14/MAR/2011
        
        String day = date.substring(0, 2);
        String month = date.substring( 3, 6 );
        String year = date.substring(7, 11 );
        
        if( month.equals( "ENE") )
        {
            month = "1";
        } // end if
        else if( month.equals( "FEB" ) )
        {
            month = "2";
        } // end if
        else if( month.equals( "MAR" ) )
        {
            month = "3";
        } // end if
        else if( month.equals( "ABR" ) )
        {
            month = "4";
        } // end if
        else if( month.equals( "MAY" ) )
        {
            month = "5";
        } // end if
        else if( month.equals( "JUN" ) )
        {
            month = "6";
        } // end if
        else if( month.equals( "JUL" ) )
        {
            month = "7";
        } // end if
        else if( month.equals( "AGO" ) )
        {
            month = "8";
        } // end if
        else if( month.equals( "SEP" ) )
        {
            month = "9";
        } // end if
        else if( month.equals( "OCT" ) )
        {
            month = "10";
        } // end if
        else if( month.equals( "NOV" ) )
        {
            month = "11";
        } // end if
        else
        {
            month = "12";
        } // end if
            
        return String.format( "%s-%s-%s", year, month, day );
    } // end method formatDate
    
    /**
     * Formatea el nombre de un propietario: primera letra en mayúscula
     * @param name Nombre del propietario
     * @return Nombre del propieatario formateado
     */
    private String firstLetterCapital( String name )
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
    
    /**
     * 
     * @return Retorna un objeto tipo Connection para realizar la conexión.
     * @throws SQLException
     * @throws ClassNotFoundException 
     */
    public static void main( String[] args ) throws SQLException, ClassNotFoundException
    {
        ParseCertificados pc = new ParseCertificados();
        
        pc.startParse( "C:/CERTPRO.TXT" );
    }

    private void createUserAccount(String idCedulaNit, String codigoCuenta, Connection con ) 
    {
        ClassConnectionCert ccc = new ClassConnectionCert();
        
        ccc.execute( "INSERT INTO usuario_has_cuenta( usuario_idcedulanit, cuenta_codigocuenta) VALUES( " + Long.parseLong( idCedulaNit ) + ", " + Long.parseLong( codigoCuenta) + ")", 1, con);
    }
} // end class ReadTextFile

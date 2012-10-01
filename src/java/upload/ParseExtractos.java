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
import com.mysql.jdbc.Statement;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import mail.MailSender;

public class ParseExtractos
{
    private String urlParam = "";
    private String emailParam = "";
    private String passwordParam = "";
    
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
                String[] campos;
                
                switch( text.charAt(0) )
                {
                    case '1':
                        
                        campos = text.split( ";" );
                        
                        for (int i = 0; i < ( campos.length - 1 ); ++i )
                        {
                            elements.add( campos[ i ].trim().replaceAll( " +", " " ) );
                        } // end for
                        
                        break;
                        
                    case '2':
                        
                        campos = text.split( ";" );
                        
                        for (int i = 0; i < ( campos.length - 1 ); ++i )
                        {
                        elements.add( campos[ i ].trim().replaceAll( " +", " " ) );
                        } // end for
                        
                        break;
                        
                    case '3':
                        
                        campos = text.split( ";" );
                        
                        for (int i = 0; i < ( campos.length - 1 ); ++i )
                        {
                        elements.add( campos[ i ].trim().replaceAll( " +", " " ) );
                        } // end for
                        
                        break;
                        
                    case '4':
                        
                        campos = text.split( ";" );
                        
                        int iteraciones = contarPuntoComas(text) == 6 ? 5 : 5;
                        
                        for (int i = 0; i < iteraciones; ++i )
                        {
                            elements.add( campos[ i ].trim().replaceAll( " +", " " ) );
                        } // end for
                        
                        break;
                        
                        
                }

                
            } // end while
        } // end try
        catch (FileNotFoundException e) 
        {
            //e.printStackTrace();
            System.out.println( e.getMessage()  );
        } // end catch: FileNotFoundException
        catch (IOException e) 
        {
            //e.printStackTrace();
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
                //e.printStackTrace();
            } // end catch: IOException
        } // end finally
        

        saveOnDB( elements );
        

    } // end main
    
    
    private void saveOnDB( ArrayList< String > elements ) throws SQLException, ClassNotFoundException
    {               
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
        
        
        
        int count = 0;
        
        // aux variables
        String idCedulaNit = "";
        String codigoCuenta = "";
        long idExtracto = 0;
        
        Calendar currentDate = Calendar.getInstance();
        SimpleDateFormat formatter=   new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        String fechaExtraco = formatter.format(currentDate.getTime());
        
        while( count < elements.size() )
        {

            
            // test registry typem
            switch( Integer.parseInt( elements.get( count ) ) )
            {
                
                // Registry no. 1
                case 1:
                    
                    /* Busca por la cédula o NIT. Si el usuario no existe, se encarga de crearlo.
                    * Siendo así, también se deberá crear los inmuebles asociados con ese usuario.
                    */
                    if( !userIDExists( removeFrontZeros( elements.get( count + 8 )  ) ,con ) )
                    {
                        idCedulaNit = removeFrontZeros( elements.get( count + 8 ));
                        String nombrePropietario = elements.get( count + 4 );
                        
                        createUser( idCedulaNit, firstLetterCapital( nombrePropietario ), "", removeFrontZeros( idCedulaNit ), 3, con  ); // include fields from 1 to 11
                        
                        // crear inmuebles
                        codigoCuenta = elements.get( count + 1 ) + elements.get( count + 2 ) + elements.get( count + 3 );
                        String pais = elements.get( count +  7 );
                        String ciudad = firstLetterCapital( elements.get( count + 6 ) );
                        String direccion = firstLetterCapital( elements.get( count + 5 ) );
                        
                        // graba sobre la base de datos los datos de la cuenta actual
                        if( !accountExists( codigoCuenta, con ) )
                        {
                            createAccount( codigoCuenta, pais, ciudad, direccion.replace( "'", "-"), con );
                            
                        }
                        
                        createUserAccount( idCedulaNit, codigoCuenta, con );
                    } // end if: test if a user exists.
                    else
                    {
                        
                        codigoCuenta = elements.get( count + 1 ).concat( elements.get( count + 2 ) ).concat( elements.get( count + 3 ) );
                        idCedulaNit = removeFrontZeros( elements.get( count + 8 ) );
                        
                        
                        
                        // test if the property exists
                        if( !accountExists( codigoCuenta, con ) )
                        {
                            createAccount( codigoCuenta, firstLetterCapital( elements.get( count +  7 ) ), firstLetterCapital( elements.get( count +  6 ) ), 
                                            firstLetterCapital( elements.get( count +  5 ) ).replace( "'", "-"),  con );
                            
                            createUserAccount( idCedulaNit, codigoCuenta, con );
                        }
                        else // update property details
                        {
                            
                            updateAccount( codigoCuenta, firstLetterCapital( elements.get( count +  7 ) ), firstLetterCapital( elements.get( count +  6 ) ), 
                                            firstLetterCapital( elements.get( count +  5 ) ).replace( '\'', '_').replace( '\\', '_'), con );
                        } // end else
                    } // end else
                    
                    String saldoAnterior = elements.get( count +  9 ).length() == 0 ? "0" : removeFrontZeros( elements.get( count +  9 ) );
                    
                    if( saldoAnterior.length() > 1 )
                    {
                        saldoAnterior = saldoAnterior.substring( 0, saldoAnterior.length() - 2 );
                    } // end if
                    
                    
                    if( elements.get( count +  9 ).charAt( elements.get( count +  9 ).length() - 1 ) == '-' )
                    {
                        if( !saldoAnterior.equals( "0" ) )
                        {
                            saldoAnterior = "-" + saldoAnterior;
                        }
                    }
                    
                    // test code
                    
                    System.out.println();
                    System.out.printf( "Código cuenta: " + codigoCuenta );
                    System.out.println();
                    
                    idExtracto = createExtract( formatDate( elements.get( count +  10 ) ), formatDate( elements.get( count +  11 ) ), saldoAnterior.length() == 0 ? "0" : saldoAnterior.equals("-") || saldoAnterior.equals("") ? "0" : saldoAnterior, codigoCuenta, fechaExtraco, con );

                    
                    count += 13;
                    
                    break;
                    
                // Registry no. 2    
                case 2: // registry type 2
                    
                    //System.out.println( elements.get( count ) );
                    
                    int contadorMovimientos = 1;
                    
                    String fechaDocumento = "";
                    String documento = "";
                    String numero = "";
                    String transaccion = "";
                    String detalleTransaccion = "";
                    String detalle = "";
                    String valorDebito = "";
                    String valorCredito = "";
                    String saldo = "";
                    
                    // mientras que hayan más elementos de tipo 2
                    while( isNumeric( elements.get( count ) ) && Long.parseLong( elements.get( count ) ) == 2  )
                    {
                        
                        ++count; // first registry of reg. type 2
                        
                        fechaDocumento = convertToMdy( elements.get( count ) );
                        
                        ++count;
                        documento = firstLetterCapital( elements.get( count ) );
                        ++count;
                        numero = elements.get( count );
                        ++count;
                        transaccion = firstLetterCapital( elements.get( count ) );
                        ++count;
                        detalleTransaccion = firstLetterCapital( elements.get( count ) );
                        ++count;
                        detalle = firstLetterCapital( elements.get( count ) );
                        ++count;
                        valorDebito = removeFrontZeros( elements.get( count ) );
                        
                        if( valorDebito.length() > 1 )
                        {
                            valorDebito = valorDebito.substring( 0, valorDebito.length() - 2 );
                        } // end
                        
                        ++count;
                        valorCredito = removeFrontZeros( elements.get( count ) );
                        
                        if( valorCredito.length() > 1 )
                        {
                            valorCredito = valorCredito.substring( 0, valorCredito.length() - 2 );
                        }
                        
                        ++count;
                        
                        saldo = removeFrontZeros( elements.get( count ) );
                        
                        if( saldo.length() > 1 )
                        {
                            saldo = saldo.substring( 0, saldo.length() - 2 );
                        } // end if
                        
                        if( elements.get( count  ).charAt( elements.get( count ).length() - 1 ) == '-')
                        {
                            if( !saldo.equals( "0" ) )
                            {
                                saldo = "-" + saldo;
                            }
                        }
                            
                        // escribe sobre la base de datos
                        insertIntoRegistry2(fechaDocumento, documento, numero, transaccion, detalleTransaccion, detalle, valorDebito.equals("-") || valorDebito.equals("") ? "0": valorDebito, valorCredito.equals("-") || valorCredito.equals("") ? "0": valorCredito ,saldo.equals("-") || saldo.equals("") ? "0": saldo, idExtracto, contadorMovimientos, con );
                        
                        ++count; // next detail (or next registry type 3, if any)
                        
                        ++contadorMovimientos;
                    } // end while
                    
                    break;
                    
                // Registry no. 3
                case 3: // registry type 3
                    
                    //System.out.println( elements.get( count ) );
                    
                    ++count; // first element of reg. type 3
                    
                    String totalDebitos = removeFrontZeros( elements.get( count ) );
                    
                    if( totalDebitos.length() > 1 )
                    {
                        totalDebitos = totalDebitos.substring( 0, totalDebitos.length() - 2 );
                    }
                    
                    ++count;
                    String totalCreditos = removeFrontZeros( elements.get( count ) );
                    
                    if( totalCreditos.length() > 1 )
                    {
                        totalCreditos = totalCreditos.substring( 0, totalCreditos.length() - 2 );
                    }
                    
                    
                    ++count;
                    String totalSaldoActual = elements.get( count );
                    
                    if( totalSaldoActual.length() > 1 )
                    {
                        totalSaldoActual = totalSaldoActual.substring( 0, totalSaldoActual.length() - 3 );
                    }
                    
                    if( elements.get( count  ).charAt( elements.get( count ).length() - 1 ) == '-')
                    {
                        if( !totalSaldoActual.equals( "0" ) )
                        {
                            totalSaldoActual = "-" + totalSaldoActual;
                        }
                    } 
                    
                    ++count;
                    String totalArrendamientos = elements.get( count );
                    
                    if( elements.get( count  ).charAt( elements.get( count ).length() - 1 ) == '-')
                    {
                        if( !totalArrendamientos.equals( "0" ) )
                        {
                            totalArrendamientos = "-" + totalArrendamientos;
                        }
                    } 
                    
                    ++count;
                    String totalComisiones = elements.get( count );
                    
                    if( elements.get( count ).charAt( elements.get( count ).length() - 1 ) == '-')
                    {
                        if( !totalComisiones.equals( "0" ) )
                        {
                            totalComisiones = "-" + totalComisiones;
                        }
                    } 
                    
                    ++count;
                    String totalSeguro = elements.get( count );
                    
                    if( elements.get( count  ).charAt( elements.get( count ).length() - 1 ) == '-')
                    {
                        if( !totalSeguro.equals( "0" ) )
                        {
                            totalSeguro = "-" + totalSeguro;
                        }
                    } 
                    
                    ++count;
                    String totalGastos = elements.get( count );
                    
                    if( elements.get( count  ).charAt( elements.get( count ).length() - 1 ) == '-')
                    {
                        if( !totalGastos.equals( "0" ) )
                        {
                            totalGastos = "-" + totalGastos;
                        }
                    } 
                    
                    ++count;
                    String totalReparaciones = elements.get( count );
                    
                    if( elements.get( count  ).charAt( elements.get( count ).length() - 1 ) == '-')
                    {
                        if( !totalReparaciones.equals( "0" ) )
                        {
                            totalReparaciones = "-" + totalReparaciones;
                        }
                    } 
                    
                    ++count;
                    String totalOtros = elements.get( count );
                    
                    if( elements.get( count  ).charAt( elements.get( count ).length() - 1 ) == '-')
                    {
                        if( !totalOtros.equals( "0" ) )
                        {
                            totalOtros = "-" + totalOtros;
                        }
                    } 
                    
                    ++count;
                    String espacios = elements.get( count );
                    
                    
                    
                    insertIntoRegistry3( totalDebitos, totalCreditos, totalSaldoActual, removeFrontZeros( totalArrendamientos ), 
                                         removeFrontZeros( totalComisiones ), removeFrontZeros( totalSeguro ), removeFrontZeros( totalGastos ), removeFrontZeros( totalReparaciones ),
                                         removeFrontZeros( totalOtros ), espacios, idExtracto, con );
                    
                    ++count;
                    
                    break;
                    
                // Registry no. 4
                case 4: // registry type 4
                    
                    
                    ++count; // first element of reg. type 4
                    
                    String observacion = elements.get( count );
                    ++count;
                    String espaciosR4= elements.get( count );
                    ++count;
                    String email = elements.get( count );
                    
                    insertIntoRegistry4( String.format( "%s %s", observacion, espaciosR4 ), email, idExtracto, idCedulaNit, con );
                    
                    count+=2; // next user
                    
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
        ClassConnection cc = new ClassConnection();
        
        //System.out.println( idCedulaNit );
       //System.out.print( idCedulaNit );
       Boolean presente = (Boolean) cc.execute( "SELECT idcedulanit FROM usuario WHERE idcedulanit = " + Long.parseLong( idCedulaNit ) , 2, con);
       
       return presente;
    } // end method userIDExists
    
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
    private   void insertIntoRegistry2(String fechaDocumento, String documento, String numero, String transaccion, String detalleTransaccion, String detalle, 
                                            String valorDebito, String valorCredito, String saldo, long idExtracto, int contadorMovimientos, Connection con )
    {
        ClassConnection cc = new ClassConnection();
        
        cc.execute( "INSERT INTO registrotipo2 ( fechadocumento, documento, numero, transaccion, detalletransaccion, detalle, valordebito, valorcredito, saldo, contadormovimientos, extractos_idreporte ) VALUES ('" + fechaDocumento + "', '" + documento + "', '" + numero + "', '" + transaccion + "', '" + detalleTransaccion + "', '" + detalle.replace( '\'', '_').replace( '\\', '_' ) + "', " + Double.parseDouble(valorDebito) + ", " + Double.parseDouble( valorCredito ) + "," + Double.parseDouble( saldo ) + ", " + contadorMovimientos + ", " + idExtracto + ")", 1, con);
    } // end method insertIntoRegistry3

    /**
     * Crea un nuevo registro de tipo 3
     * 
     * @param totalDebitos Total débitos
     * @param totalCreditos Total crédito
     * @param totalSaldoActual Total saldo actual
     * @param totalArrendamientos Total arrendimientos
     * @param totalComisiones Total comisiones
     * @param totalSeguro Total seguro
     * @param totalGastos Total gastos
     * @param totalReparaciones Total reparaciones
     * @param totalOtros Total otros
     * @param espacios Espacios
     * @param idExtracto ID con el que se asociará esta entrada
     */
    private   void insertIntoRegistry3(String totalDebitos, String totalCreditos, String totalSaldoActual, String totalArrendamientos, String totalComisiones, 
                                            String totalSeguro, String totalGastos, String totalReparaciones, String totalOtros, String espacios, long idExtracto, Connection con ) 
    {
        ClassConnection cc = new ClassConnection();
        
        cc.execute( "INSERT INTO registrotipo3 ( totalDebitos, totalcreditos, totalsaldoactual, totalarrendamiento, totalcomisiones, totalseguro, totalgastos, totalreparaciones, totalotros, espacios, extractos_idreporte )VALUES (" + 
                                                                Double.parseDouble( totalDebitos) + ", " + Double.parseDouble( totalCreditos ) + ", " + Double.parseDouble( totalSaldoActual ) + ", " + 
                                                                Double.parseDouble( totalArrendamientos ) + ", " + Double.parseDouble( totalComisiones ) + ", " + Double.parseDouble( totalSeguro ) + ", " +
                                                                Double.parseDouble( totalGastos ) + ", " + Double.parseDouble( totalReparaciones ) + ", " + Double.parseDouble( totalOtros ) + ", '" + 
                                                                espacios + "', " + idExtracto + ")", 1, con);
        
    } // end method insertIntoRegistry3

    /**
     * 
     * @param observacion Observación a este extracto
     * @param email Email para este cliente
     * @param espacios Espacios
     * @param idExtracto ID con el que se asociará esta entrada
     * @ 
     */
    private void insertIntoRegistry4(String observacion, String email, long idExtracto, String idCedulaNit, Connection con  ) 
    {
        ClassConnection cc = new ClassConnection();
        
        cc.execute( "INSERT INTO registrotipo4 ( observacion, email, extractos_idreporte) VALUES ('" + observacion + "', '" + email + "', " + idExtracto +")", 1, con);
        
        if( !email.equals( "" ) )
        {
            cc.execute( "UPDATE usuario SET email = '" + email + "' WHERE idcedulanit = " + Long.parseLong( idCedulaNit ), 1, con );
        } // end if
    } // next method insertIntoRegistry4

    /**
     * Crea un nuevo usuario
     * 
     * @param idCedulaNit Documento de identidad del cliente o la empresa
     * @param nombrePropietario Nombre del propietario del inmueble
     * @param contrasegnia Contraseña asignada a la cuenta de este cliente o empresa
     * @param email Email
     */
    private   void createUser( String idCedulaNit, String nombrePropietario, String email, String contrasegnia, int nivelAcceso, Connection con ) 
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
     * @param codigoCuenta Una de las cuentas asociadas al cliente
     * @param pais País de localización del inmueble
     * @param ciudad Ciudad donde está localizado el inmueble
     * @param saldoAnterior Saldo de la cuenta asociado al inmueble
     * @param idCedulaNit Documento de identidad del cliente o empresa
     * 
     * @return [Nota: Este es un método mutador.]
     */
    private   void createAccount(String codigoCuenta, String pais, String ciudad, String direccion, Connection con ) 
    {
        /*System.out.println( codigoCuenta );
        System.out.println( pais );
        System.out.println( ciudad );
        System.out.println( direccion );
        System.out.println( idCedulaNit );*/
        
        ClassConnection cc = new ClassConnection();
        
        cc.execute( "INSERT INTO cuenta VALUES (" + Long.parseLong( codigoCuenta) + ", '" + pais + "', '" + ciudad + "', '" + direccion + "')", 1, con);
    } // end method create property

    /**
     * 
     * @param codigoCuenta
     * @return 
     */
    private   boolean accountExists(String codigoCuenta, Connection con )
    {
       ClassConnection cc = new ClassConnection();
       boolean presente = (Boolean)cc.execute( "SELECT codigocuenta FROM cuenta WHERE codigocuenta = " + Long.parseLong( codigoCuenta ), 2, con);
       
       return presente;
    } // end method propertyExists

    
    /**
     * Actualiza el saldo anterior de un inmueble que coincida con el código de la cuenta y el documento de identidad del propietario.
     * 
     * @param codigoCuenta Código de la cuenta asociada con el inmueble
     * @param idCedulaNit Documento de identidad del cliente o empresa
     * @param saldoAnterior Saldo anterior asociado el inmueble (Este debe actualizarse en la base de datos.
     */
    private   void updateAccount(String codigoCuenta, String pais, String ciudad, String direccion, Connection con ) 
    {
        ClassConnection cc = new ClassConnection();
        
        cc.execute( "UPDATE cuenta SET pais = '" + pais + "', ciudad = '" + ciudad + "', direccion = '" + direccion + "' WHERE codigocuenta = " + Long.parseLong( codigoCuenta ) , 1, con );
    } // end method updateProperty

    
    private long createExtract(String fechaInicialMovimiento, String fechaFinalMovimiento, String saldoAnterior, String codigoCuenta, String fechaExtracto, Connection con )
    {
        ClassConnection cc = new ClassConnection();
        
        long lastInserted = ( Long ) cc.execute( "INSERT INTO extractos( fechaInicialmovimiento, fechafinalmovimiento, saldoanterior, cuenta_codigocuenta, fechasubidaextracto ) VALUES ( '" + fechaInicialMovimiento + "', '" + 
                                                      fechaFinalMovimiento + "', " + Double.parseDouble( saldoAnterior ) + ", " + Long.parseLong( codigoCuenta ) + ", '" + fechaExtracto  + "')", 3, con);
        return lastInserted;
    } // end method createExtract
    
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
        
        String day = date.substring(0, 2);
        String month = date.substring( 3, 5 );
        String year = date.substring(6, 10 );
            
        return String.format( "%s-%s-%s", year, month, day );
    } // end method formatDate
    
    /**
     * Determina si una cadena pasada como argumento coniene sólo números.
     * 
     * @param numeroCadena Cadena de caracteres
     * @return Returna <em>true</em> si el valor pasado corresponde a un número, en caso contrario <em>false</em>.
     */
    private   boolean isNumeric( String numeroCadena ) 
    {
        return java.util.regex.Pattern.matches( "\\d+", numeroCadena );
    } // end method isNumeric


    private void createUserAccount(String idCedulaNit, String codigoCuenta, Connection con)
    {
        ClassConnectionCert ccc = new ClassConnectionCert();   
        
        ccc.execute( "INSERT INTO usuario_has_cuenta( usuario_idcedulanit, cuenta_codigocuenta) VALUES( " + Long.parseLong( idCedulaNit ) + ", " + Long.parseLong( codigoCuenta) + ")", 1, con);
    } // end of method createUserAccount

    private String convertToMdy(String fechaDocumento)
    {
        String ahnio = fechaDocumento.substring(0, 4);
        String mes = fechaDocumento.substring(4, 6);
        String dia = fechaDocumento.substring(6, 8);
        
        return String.format( "%s-%s-%s", ahnio, mes, dia );
    }
    
    /**
     * 
     */
    public int contarPuntoComas( String registro )
    {
        int i,ln,puntoComa =0 ;
        char ch;
        
        ln= registro.length();
        
        for(i=0;i<ln;i++)
        {
            ch = registro.charAt(i);
            if (registro.charAt(i)==';')
            puntoComa++;
        }
        
        return puntoComa;
    }
    
    
    public static void main( String[] args ) throws SQLException, ClassNotFoundException
    {
        ParseExtractos pe = new ParseExtractos();
        
        pe.startParse( "C:/EXTRA.TXT" );
    } // end main
} // end class ReadTextFile


package autocomplete;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.StringTokenizer;
 
public class DummyDB 
{
    private int totalCountries;
    
    
    private String data = "";
    private List<String> countries;
    
    public DummyDB() throws ClassNotFoundException, InstantiationException 
    {
        
            
        

        Connection con = null;
        ResultSet rst = null;
        Statement stmt = null;

        try
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
        con = (Connection) DriverManager.getConnection (dbconfig.getProperty("dburl") + "/" + dbconfig.getProperty("dbname"), dbconfig.getProperty("dbuser"), dbconfig.getProperty("dbpw"));
            stmt=(Statement) con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );

            String query = "SELECT idcedulanit FROM usuario";

            rst = stmt.executeQuery( query );

            while( rst.next() )
            {
                data = data + ", " + rst.getString( "idcedulanit" );
            }

        } // end try
        catch(Exception e )
        {
            System.out.println(e.getMessage());
        } // end catch
        
        countries = new ArrayList<String>();
        StringTokenizer st = new StringTokenizer(data, ",");
 
        while(st.hasMoreTokens()) 
        {
            countries.add(st.nextToken().trim());
        }
        totalCountries = countries.size();
    }
 
    public List<String> getData(String query) 
    {
        String country = null;
        query = query.toLowerCase();
        List<String> matched = new ArrayList<String>();
        for(int i=0; i<totalCountries; i++) {
            country = countries.get(i).toLowerCase();
            if(country.startsWith(query)) {
                matched.add(countries.get(i));
            }
        }
        return matched;
    }
}
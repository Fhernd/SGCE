package upload;

import java.sql.*;

/**
 *
 * @author johnoo
 */
public class ClassConnectionCert
{
    public Object execute(  String sql, int sqlType, Connection con )
    {
        

        try {
            Statement statement = con.createStatement();
            ResultSet resultSet = null;

            switch( sqlType )
            {
                case 1: // INSERT / DELETE / UPDATE
                    statement.executeUpdate( sql );
                    
                    break;
                    
                case 2: // SELECT
                    resultSet = statement.executeQuery( sql );
                    
                    if( resultSet.next() )
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                    
                case 3: // INSERT 
                    
                    statement.executeUpdate( sql, Statement.RETURN_GENERATED_KEYS );
                    
                    /*
                    
                    Statement st = con.createStatement();
                    
                    resultSet = st.executeQuery( "SELECT idcertificado FROM certificados ORDER BY idcertificado" );*/
                    
                    ResultSet keys = statement.getGeneratedKeys();
                    
                    long lastKey = 1;
                    while (keys.next())
                    {
                        lastKey = keys.getInt(1);
                    }
                    
                    
                    return lastKey;
            } // end switch

            
        } //end try
        catch(SQLException e) 
        {
            e.printStackTrace();
        }
        return null;
    }  //end main    
   
}

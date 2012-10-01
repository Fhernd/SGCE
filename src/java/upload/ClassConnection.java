package upload;

import java.sql.*;

/**
 *
 * @author johnoo
 */
public class ClassConnection 
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
                    
                    //con.close();
                    
                    break;
                    
                case 2: // SELECT
                    resultSet = statement.executeQuery( sql );
                    
                    if( resultSet.next() )
                    {
                        //con.close();
                        return true;
                    }
                    else
                    {
                        //con.close();
                        return false;
                    }
                    
                case 3: // INSERT 
                    
                    statement.executeUpdate( sql );
                    
                    resultSet = statement.executeQuery( "SELECT idreporte FROM extractos ORDER BY idreporte" );
                    
                    resultSet.last();
                    
                    Object idReporte = resultSet.getObject( "idreporte" );
                    
                    //con.close();
                    
                    return idReporte;
            } // end switch

            
        } //end try

        catch(SQLException e) {
        e.printStackTrace();
        }
        return null;
    }  //end main    
}

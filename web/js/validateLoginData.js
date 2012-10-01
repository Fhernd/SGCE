
function validateData()
{
    if( document.getElementById( "email" ).value.length != 0 )
    {
        if( document.getElementById( "password" ).value.length != 0 )
        {
            return true;
        } // end if
        else
        {
            alert( "El campo 'Contraseña' es obligatorio." );
            document.getElementById( "password" ).focus();
            return false;
        }
    } // end if
    else
    {
        alert( "El campo 'Nombre de usuario' es obligatorio." );
        document.getElementById( "email" ).focus();
        return false;
    } // end else
}

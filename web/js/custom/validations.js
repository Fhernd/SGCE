/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


function validateEmail() 
{ 
    email = document.getElementById( 'useremail' ).value;
    
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    if( re.test(email) )
        {
            return true;
        }
        else
            {
                alert( 'Escriba una direcci\xf3n de email v\xe1lida' );
                return false;
            }
        
}

function validateCreateUser()
{
    if( validarEntero( document.getElementById( 'newusername' ).value ) )
    {
        alert( 'ok' );
        return false;
    }
    
}

function validarEntero(valor){ 
      //intento convertir a entero. 
     //si era un entero no le afecta, si no lo era lo intenta convertir 
     valor = parseInt(valor) 

      //Compruebo si es un valor numérico 
      if (isNaN(valor)) { 
            //entonces (no es numero) devuelvo el valor cadena vacia 
            return false;
      }else{ 
            //En caso contrario (Si era un número) devuelvo el valor 
            return true;
      } 
} 


function equalPassword()
{
    
    if( document.getElementById('newpassword1').value == document.getElementById('newpassword2').value)
        {
            if( document.getElementById('newpassword1').value.length >= 6 )
                {
                    return true;
                }
                else
                    {
                        alert( "Las contrasena debe tener por lo menos 6 caracteres.")
                        return false;
                    }
            
        }
        else
{
    alert( "Las contrasenas no coinciden. Intente de nuevo")
    return false;
}
    
    
    
}
<%
    if( session.getAttribute( "nivelacceso" ).equals( "2" )  )
    {
        out.print( "<li>" );
        out.print( "<a href=\"cuponpago.jsp\" class=\"sf-with-ul\">Cup&oacute;n de Pago</a>" );

        out.print( "</li>" );
   }
    if( session.getAttribute( "nivelacceso" ).equals( "3" )  )
    {
        out.print( "<li>" );
        out.print( "<a href=\"extractos.jsp\" class=\"sf-with-ul\">Extractos</a>" );

        out.print( "</li>" );
   }

    if( session.getAttribute( "nivelacceso" ).equals( "3" )  )
    {
        out.print( "<li>" );
        out.print( "<a  href =\"certificados.jsp\" >Certificados</a>");
        out.print( "</li>" );
   }

    if( session.getAttribute( "nivelacceso" ).equals( "3" ) || session.getAttribute( "nivelacceso" ).equals( "2" ) )
    {
        out.print( "<li>" );
        out.print( "<a href=\"opcionesUsuario.jsp\" class=\"sf-with-ul\">Opciones</a>" );

        out.print( "</li>" );
   }

    if( session.getAttribute( "nivelacceso" ).equals( "3" ) || session.getAttribute( "nivelacceso" ).equals( "2" ) || session.getAttribute( "nivelacceso" ).equals( "1" ) )
    {
        out.print( "<li>" );
        
        out.print( "<a href=\"soporte.jsp\" class=\"sf-with-ul\">Soporte</a>" );

        out.print( "</li>" );
    }

    if( session.getAttribute( "nivelacceso" ).equals( "1" ) )
    {
        out.print( "<li>" );
        out.print( "<a href=\"SubirExtractos.jsp\" class=\"sf-with-ul\">Gestionar Extractos</a>" );

        out.print( "</li>" );
    }
    
    if( session.getAttribute( "nivelacceso" ).equals( "1" ) )
    {
        out.print( "<li>" );
        out.print( "<a href=\"SubirCuponPago.jsp\" class=\"sf-with-ul\">Gestionar Cupones de Pago</a>" );

        out.print( "</li>" );
    }

    if( session.getAttribute( "nivelacceso" ).equals( "1" ) )
    {
        out.print( "<li>" );
        out.print( "<a href=\"SubirCertificados.jsp\" class=\"sf-with-ul\">Gestionar Certificados</a>" );

        out.print( "</li>" );
    }

    if( session.getAttribute( "nivelacceso" ).equals( "1" ) )
    {
        out.print( "<li>" );
        out.print( "<a href=\"EditorNoticias.jsp\" class=\"sf-with-ul\">Editor Noticias</a>" );

        out.print( "</li>" );
    }
    
    // AdminOpcionesUsuario
    if( session.getAttribute( "nivelacceso" ).equals( "1" ) )
    {
        out.print( "<li>" );
        out.print( "<a href=\"AdminOpcionesUsuario.jsp\" class=\"sf-with-ul\">Administraci&oacute;n Usuarios</a>" );
        out.print( "</li>" );
    }
%>
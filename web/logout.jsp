<%
    session.setAttribute( "username", null);
    session.setAttribute( "password", null );
    session.setAttribute( "name", null );

    session.setAttribute( "logged", false );
    session.setAttribute( "cambioContrCorrecto", null );
    session.setAttribute("uploadSuccess", null);
    
    response.sendRedirect( "index.jsp");
%>
<%@ page language="java" import="java.sql.*" %>
<%@include file="snippets/DbParams.jsp" %>

<%
    if( !( Boolean.parseBoolean( String.valueOf( session.getAttribute( "logged" ) ) ) ) )
    {
        response.sendRedirect( "index.jsp" );
    }
    else
    {
        
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<%@include file="snippets/title.jsp" %>
	<script type="text/javascript" src="js/jquery-1.3.2.js"></script>
	<script type="text/javascript" src="js/ui/ui.core.js"></script>
	<script type="text/javascript" src="js/superfish.js"></script>
	<script type="text/javascript" src="js/live_search.js"></script>
	<script type="text/javascript" src="js/tooltip.js"></script>
	<script type="text/javascript" src="js/cookie.js"></script>
	<script type="text/javascript" src="js/ui/ui.sortable.js"></script>
	<script type="text/javascript" src="js/ui/ui.draggable.js"></script>
	<script type="text/javascript" src="js/ui/ui.resizable.js"></script>
	<script type="text/javascript" src="js/ui/ui.dialog.js"></script>
        <script type="text/javascript" src="js/custom/reporting.js"></script>
	
	<link href="css/ui/ui.base.css" rel="stylesheet" media="all" />

	<link href="css/themes/gray_lightness/ui.css" rel="stylesheet" media="all" />

	<link href="css/themes/gray_lightness/ui.css" rel="stylesheet" title="style" media="all" />

	<!--[if IE 6]>
	<link href="css/ie6.css" rel="stylesheet" media="all" />
	
	<script src="js/pngfix.js"></script>
	<script>
	  /* Fix IE6 Transparent PNG */
	  DD_belatedPNG.fix('.logo, ul#dashboard-buttons li a, .response-msg, #search-bar input');

	</script>
	<![endif]-->
</head>
<body>
	<div id="page_wrapper">
		<div id="page-header">
			<div id="page-header-wrapper">
				<div id="top">
					<a href="dashboard.jsp" class="logo" title="SGCE Plataforma de Gesti&oacute;n de Extractos y Certificados">SGCE</a>
					<div class="welcome">
						<span class="note">Bienvenid@, <a href="#" title="Bienvenido"><% out.print( session.getAttribute( "name" ) ); %></a></span>
						<a class="btn ui-state-default ui-corner-all" href="#">
							<span class="ui-icon ui-icon-wrench"></span>
							Opciones
						</a>
						<a class="btn ui-state-default ui-corner-all" href="#">
							<span class="ui-icon ui-icon-person"></span>
							<% out.print( session.getAttribute( "username" ) ); %>
						</a>
						<a class="btn ui-state-default ui-corner-all" href="logout.jsp">
							<span class="ui-icon ui-icon-power"></span>
                                                        Cerrar Sesi&oacute;n
						</a>						
					</div>
				</div>
				<ul id="navigation">
					<li>
						<a href="#" class="sf-with-ul">Principal</a>
						
					</li>
                                    
                                    
                                    
                                    
                                        <%@include file="snippets/ACLMenu.jsp" %>
                                        
                                        
                                        
                                        
                                    </ul>
				<div id="search-bar">
                                    <form method="post" action="http://www.google.com/search?q=<%=request.getParameter("q")%>" target="_blank">
                                        <input type="text" name="q" value="" />
                                    </form>
				</div>
			</div>
		</div><script type="text/javascript" src="js/ui/ui.tabs.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	// Tabs
	$('#tabs, #tabs2, #tabs5').tabs();
});
</script>
		<div id="sub-nav"><div class="page-title">
			<h1>Principal</h1>
		</div>
		<div id="top-buttons">
			<a id="dialog_link" class="btn ui-state-default ui-corner-all" href="#">
				<span class="ui-icon ui-icon-newwin"></span>
				Dialog Window
			</a>
			<a class="btn ui-state-default ui-corner-all" id="drop" href="#drop_down">
				<span class="ui-icon ui-icon-carat-2-n-s"></span>
				DropDown Menu
			</a>
			<div id="drop_down" class="hidden">
				<ul>
					<li><a href="#">Google</a></li>
					<li><a href="#">Yahoo</a></li>
					<li><a href="#">MSN</a></li>
					<li><a href="#">Ask</a></li>
					<li><a href="#">AOL</a></li>
				</ul>
			</div>
			<a id="modal_confirmation_link" class="btn ui-state-default ui-corner-all" href="#">
				<span class="ui-icon ui-icon-grip-dotted-horizontal"></span>
				Modal Confirmation
			</a>
		</div>
			<div id="dialog" title="Dialog Title">
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
			</div>
			<div id="modal_confirmation" title="An example modal title ?">
				<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
			</div>
</div>
		<div id="page-layout"><div id="page-content">
			<div id="page-content-wrapper">
				<div class="inner-page-title">
                                    <br/>
				</div>
                            
                            
                                <div id="dashboard-buttons">
					<ul>
						<li>
							<a href="#" class="Mail_open tooltip" title="Mail open">
								
							</a>
						</li>
					</ul>
					<div class="clear"></div>
				</div>
                            
                            
                                <div class="inner-page-title">
					<h2>Últimas noticias</h2>
                                        
					<span>Aquí puede encontrar los recientes cambios efectuados sobre su cuenta y el sistema en general.</span>
				</div>
				<div class="clear"></div>
                                
                                <%

                                    String driver = "com.mysql.jdbc.Driver";
                                    Class.forName(driver).newInstance();

                                    Connection con = null;
                                    ResultSet rst = null;
                                    Statement stmt = null;
                                    String notificaciones[] = new String[ 4 ];
                                    
                                    notificaciones[ 0 ] = "";
                                    notificaciones[ 1 ] = "";
                                    notificaciones[ 2 ] = "";
                                    notificaciones[ 3 ] = "";
                                    
                                    try
                                    {
                                        con=DriverManager.getConnection( UrL, UseR, PassworD );
                                        stmt=con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );

                                        String query = "SELECT fecha, contenido FROM noticias GROUP BY fecha DESC LIMIT 4";

                                        rst = stmt.executeQuery( query );

                                        String notificacion = "";
                                        
                                        
                                        int contador = 0;
                                        
                                        while( rst.next() )
                                        {               
                                            notificacion = rst.getString( "fecha" ) + "<br/>" + "<br/>" + rst.getString( "contenido" );
                                            
                                            notificaciones[ contador++ ] = notificacion;
                                        } // end while
                                        
                                        con.close();
                                        

                                    } // end try
                                    catch(Exception e )
                                    {
                                        System.out.println(e.getMessage());
                                    } // end catch
                                %>
                                
                                    <div class="two-column">
					<div class="column">
						<div class="portlet ui-widget ui-widget-content ui-helper-clearfix ui-corner-all">
                                                    <div class="portlet-header ui-widget-header">Notificaci&oacute;n 1<span class="ui-icon ui-icon-circle-arrow-s"></span></div>
							<div class="portlet-content">
                                                            <%
                                                                out.print( "<b>" );
                                                                out.println( notificaciones[ 0 ] );
                                                                out.print( "</b>" );
                                                            %>
							</div>
						</div>
						<div class="portlet ui-widget ui-widget-content ui-helper-clearfix ui-corner-all">
							<div class="portlet-header ui-widget-header">Notificaci&oacute;n 2<span class="ui-icon ui-icon-circle-arrow-s"></span></div>
							<div class="portlet-content">
                                                            <%
                                                                out.println( notificaciones[ 1 ] );
                                                            %>
							</div>
						</div>
					</div>
					
					<div class="column column-right">
					
						<div class="portlet ui-widget ui-widget-content ui-helper-clearfix ui-corner-all">
							<div class="portlet-header ui-widget-header">Notificaci&oacute;n 3<span class="ui-icon ui-icon-circle-arrow-s"></span></div>
							<div class="portlet-content">
                                                            <%
                                                                out.println( notificaciones[ 2 ] );
                                                            %>
							</div>
						</div>
						
						<div class="portlet ui-widget ui-widget-content ui-helper-clearfix ui-corner-all">
                                                    <div class="portlet-header ui-widget-header">Notificaci&oacute;n 4<span class="ui-icon ui-icon-circle-arrow-s"></span></div>
							<div class="portlet-content">
                                                            <%
                                                                out.println( notificaciones[ 3 ] );
                                                            %>
							</div>
						</div>
					</div>
				</div>
                                
			

                    <div id="sidebar">
			<div class="sidebar-content">
				<a id="close_sidebar" class="btn ui-state-default full-link ui-corner-all" href="#drill">
					<span class="ui-icon ui-icon-circle-arrow-e"></span>
					Ocultar Barra Opciones
				</a>
				<a id="open_sidebar" class="btn tooltip ui-state-default full-link icon-only ui-corner-all" title="Open Sidebar" href="#"><span class="ui-icon ui-icon-circle-arrow-w"></span></a>
				<div class="hide_sidebar">
                                        <div class="other-box yellow-box ui-corner-all ui-corner-all">
                                            <div class="cont tooltip ui-corner-all" title="Segerencia">
                                                    <h3>Notificaciones:</h3>
                                                    <p><%

                                                        String tempUser = ( String ) session.getAttribute( "username" );
                                                        String tempPass = ( String ) session.getAttribute( "password" );
                                                        
                                                        if( tempPass.equals( tempUser ) )
                                                        {
                                                            out.println( "Por razones de seguridad y privacidad, recuerde cambiar su contrase&ntilde;a desde el panel de Opciones" );
                                                        }
                                                        else
                                                        {
                                                            out.println( "Recuerde cambiar su contrase&ntilde;a cada 72 d&iacute;as." );
                                                        } // end else

                                                    %></p>
                                            </div>
					</div>
					<div class="portlet ui-widget ui-widget-content ui-helper-clearfix ui-corner-all">

					</div>
					
					
					
					
					<div class="box ui-widget ui-widget-content ui-corner-all">
                                            <h3>Navegaci&oacute;n</h3>
						<div class="content">
                                                        <a class="btn ui-state-default full-link ui-corner-all" href="dashboard.jsp">
								<span class="ui-icon ui-icon-mail-closed"></span>
								Principal
							</a>
                                                        <a class="btn ui-state-default full-link ui-corner-all" href="extractos.jsp">
								<span class="ui-icon ui-icon-arrowreturnthick-1-n"></span>
								Extractos
							</a>
							<a class="btn ui-state-default full-link ui-corner-all" href="certificados.jsp">
								<span class="ui-icon ui-icon-scissors"></span>
								Certificados
							</a>
							<a class="btn ui-state-default full-link ui-corner-all" href="opciones.jsp">
								<span class="ui-icon ui-icon-signal-diag"></span>
								Opciones
							</a>
							<a class="btn ui-state-default full-link ui-corner-all" href="Soporte">
								<span class="ui-icon ui-icon-alert"></span>
								Soporte
							</a>
						</div>
					</div>
					<div class="clear"></div>
				</div>
			</div>
		</div>
		<div class="clear"></div>			</div>
			<div class="clear"></div>
		</div>
	</div>
	<div class="clear"></div>
	<div id="footer">
            <a href="dashboard.jsp" title="Principal">Principal</a> | 
                <%
                    if( session.getAttribute( "nivelacceso" ).equals( "3" ) )
                    {
                        out.print( "<a href=\"extractos.jsp\" title=\"Extractos\">Extractos</a> | ");
                        out.print( "<a href=\"certificados.jsp\" title=\"Certificados\">Certificados</a> | ");
                        out.print( "<a href=\"opcionesUsuario.jsp\" title=\"Opciones\">Opciones</a> | ");
                        out.print( "<a href=\"soporte.jsp\" title=\"Soporte\">Soporte</a> ");
                   }
                %>
	</div>
	<div id="copyright">
            
	</div>
</body>
</html>
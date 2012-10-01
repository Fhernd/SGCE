<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">

<!-- www.forowarez.es -->
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
	<script type="text/javascript" src="js/custom.js"></script>
	
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
					<a href="dashboard.jsp" class="logo" title="SGCE"></a>
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
						<a href="dashboard.jsp" class="sf-with-ul">Principal</a>
						
					</li>
                                        
                                    <%@include  file="snippets/ACLMenu.jsp" %>
                                    
                                </ul>
				<div id="search-bar">
					<form method="post" action="http://www.google.com/">
						<input type="text" name="q" value="live search demo" />
					</form>
				</div>
			</div>
		</div><link href="css/ui/ui.accordion.css" rel="stylesheet" media="all" />
<script type="text/javascript" src="js/ui/ui.accordion.js"></script>
<script type="text/javascript">
$(function() {
	$("#accordion").accordion({
	});
});
</script>
		<div id="sub-nav"><div class="page-title">
			<h1>Accordions</h1>
			<span><a href="#" title="Layout Options">Layout Options</a> > <a href="#" title="Two column layout">Two column layout</a> > This is a breadcrumb example</span>
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
					<h2>Soporte</h2>
					<span></span>
				</div>
				<div class="content-box">
					<div id="accordion">
                                            
                                            
                                            <%
                                            if( session.getAttribute( "nivelacceso" ).equals( "1" ) )
								{
                                            
						out.print( "<h3><a href=\"#\">Inicio de Sesión</a></h3>");
						out.print( "<div>");
							
                                                    out.println( "<a href=\"videos/sgce_demo_01_/sgce_demo_01_.html\" target=\"_blank\">Ver</a><br/>");
                                                        
						out.print( "</div>" );
                                                                                                                                              }
                                            %>
                                            <%
                                            if( session.getAttribute( "nivelacceso" ).equals( "1" ) )
								{
                                            
						out.print( "<h3><a href=\"#\">Publiciar una Noticia</a></h3>");
						out.print( "<div>");
							
                                                    out.println( "<a href=\"videos/sgce-publiciar-noticia/sgce-publiciar-noticia.html\" target=\"_blank\">Ver</a><br/>");
                                                        
						out.print( "</div>" );
                                                                                                                                              }
                                            %>
                                            <%
                                                if( session.getAttribute( "nivelacceso" ).equals( "1" ) )
                                                {
                                            
                                                    out.print( "<h3><a href=\"#\">Subir Extractos</a></h3>");
                                                    out.print( "<div>");

                                                        out.println( "<a href=\"videos/sgce_demo_02-subirextractos/sgce_demo_02-subirextractos.html\" target=\"_blank\">Ver</a><br/>");

                                                    out.print( "</div>" );
                                                }
                                            %>
                                            <%
                                                if( session.getAttribute( "nivelacceso" ).equals( "1" ) )
                                                {
                                            
						out.print( "<h3><a href=\"#\">Subir Certificados</a></h3>");
						out.print( "<div>");
							
                                                    out.println( "<a href=\"videos/sgce_demo_02-subircertificados/sgce_demo_02-subircertificados.html\" target=\"_blank\">Ver</a><br/>");
                                                        
						out.print( "</div>" );
                                                }
                                            %>
                                            <%
                                                if( session.getAttribute( "nivelacceso" ).equals( "1" ) )
                                                {
                                            
						out.print( "<h3><a href=\"#\">Cambiar Contrase&#164a Administrador</a></h3>");
						out.print( "<div>");
							
                                                    out.println( "<a href=\"videos/sgce_demo_03-cambiarcontrasegniaadmin/sgce_demo_03-cambiarcontrasegniaadmin.html\" target=\"_blank\">Cambiar Contrase&#164a Administrador</a><br/>");
                                                        
						out.print( "</div>" );
                                                }
                                            %>
                                            <%
                                                if( session.getAttribute( "nivelacceso" ).equals( "1" ) )
                                                {
                                            
						out.print( "<h3><a href=\"#\">Cambiar Contrase&#164a Email</a></h3>");
						out.print( "<div>");
							
                                                    out.println( "<a href=\"videos/sgce_demo_03-cambiarcontraseniaemail/sgce_demo_03-cambiarcontraseniaemail.html\" target=\"_blank\">Ver</a><br/>");
                                                        
						out.print( "</div>" );
                                                }
                                            %>
                                            <%
                                                if( session.getAttribute( "nivelacceso" ).equals( "1" ) )
                                                {
                                            
						out.print( "<h3><a href=\"#\">Crear Usuario Administrador</a></h3>");
						out.print( "<div>");
							
                                                    out.println( "<a href=\"videos/sgce_demo_03-crearusuario/sgce_demo_03-crearusuario.html\" target=\"_blank\">Ver</a><br/>");
                                                        
						out.print( "</div>" );
                                                }
                                            %>
                                            <%
                                                if( session.getAttribute( "nivelacceso" ).equals( "1" ) )
                                                {
                                            
						out.print( "<h3><a href=\"#\">Reestablecer Contraseña Usuario</a></h3>");
						out.print( "<div>");
							
                                                    out.println( "<a href=\"videos/sgce_demo_03-reestablecercontraseniausuario/sgce_demo_03-reestablecercontraseniausuario.html\" target=\"_blank\">Ver</a><br/>");
                                                        
						out.print( "</div>" );
                                                }
                                            %>
                                            <%                                            
						out.print( "<h3><a href=\"#\">Descargar Extracto</a></h3>");
						out.print( "<div>");
							
                                                    out.println( "<a href=\"videos/sgce_demo_04-extracto_descargar/sgce_demo_04-extracto_descargar.html\" target=\"_blank\">Ver</a><br/>");
                                                        
						out.print( "</div>" );
                                                
                                                
						out.print( "<h3><a href=\"#\">Imprimir Extracto</a></h3>");
						out.print( "<div>");
							
                                                    out.println( "<a href=\"videos/sgce_demo_04-extracto_imprimir/sgce_demo_04-extracto_imprimir.html\" target=\"_blank\">Ver</a><br/>");
                                                        
						out.print( "</div>" );
                                                
                                                
						out.print( "<h3><a href=\"#\">Visualizar Extracto</a></h3>");
						out.print( "<div>");
							
                                                    out.println( "<a href=\"videos/sgce_demo_04-extracto_visualizar/sgce_demo_04-extracto_visualizar.html\" target=\"_blank\">Ver</a><br/>");
                                                        
						out.print( "</div>" );
                                                
                                                
                                                
						out.print( "<h3><a href=\"#\">Descargar Certificado</a></h3>");
						out.print( "<div>");
							
                                                    out.println( "<a href=\"videos/sgce_demo_05-certificado_descargar/sgce_demo_05-certificado_descargar.html\" target=\"_blank\">Ver</a><br/>");
                                                        
						out.print( "</div>" );
                                                
                                                
                                                
						out.print( "<h3><a href=\"#\">Imprimir Certificado</a></h3>");
						out.print( "<div>");
							
                                                    out.println( "<a href=\"videos/sgce_demo_05-certificado_imprimir/sgce_demo_05-certificado_imprimir.html\" target=\"_blank\">Ver</a><br/>");
                                                        
						out.print( "</div>" );
                                                
                                                
                                                
						out.print( "<h3><a href=\"#\">Visualizar Certificado</a></h3>");
						out.print( "<div>");
							
                                                    out.println( "<a href=\"videos/sgce_demo_05-certificado_visualizar/sgce_demo_05-certificado_visualizar.html\" target=\"_blank\">Ver</a><br/>");
                                                        
						out.print( "</div>" );
                                                
                                                
						out.print( "<h3><a href=\"#\">Cambiar Contraseña Usuario</a></h3>");
						out.print( "<div>");
							
                                                    out.println( "<a href=\"videos/sgce_demo_06-cambiocontrasegnia/sgce_demo_06-cambiocontrasegnia.html\" target=\"_blank\">Ver</a><br/>");
                                                        
						out.print( "</div>" );
                                            %>

                                                
					</div>
				</div>
				<div class="clearfix"></div>
				<br /><br />
				
				<div class="clearfix"></div>
				<i class="note">* </i>
						<div id="sidebar">
			<div class="sidebar-content">
				<a id="close_sidebar" class="btn ui-state-default full-link ui-corner-all" href="#drill">
					<span class="ui-icon ui-icon-circle-arrow-e"></span>
					Cerrar
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
                                                            out.println( "Recuerde cambiar su contrase&ntilde;a cada 72 d&iacute;s (Sugerencia)" );
                                                        } // end else

                                                    %></p>
                                            </div>
					</div>
					<!--<div class="portlet ui-widget ui-widget-content ui-helper-clearfix ui-corner-all">
						<div class="portlet-header ui-widget-header">Esquema de Colores<span class="ui-icon ui-icon-circle-arrow-s"></span></div>
						<div class="portlet-content">
							<ul id="style-switcher" class="side-menu">
								<li>
									<a class="set_theme" id="black_rose" href="#" title="Black Rose Theme">Rosa</a>
								</li>
								<li>
									<a class="set_theme" id="gray_standard" href="#" title="Gray Standard Theme">Gris Estándar</a>
								</li>
								<li>
									<a class="set_theme" id="gray_lightness" href="#" title="Gray Lightness Theme">Gris Brillante</a>
								</li>
								<li>
									<a class="set_theme" id="apple_pie" href="#" title="Apple Pie Theme">Manzana</a>
								</li>
								<li>
									<a class="set_theme" id="blueberry" href="#" title="Uva">Uva</a>
								</li>
							</ul>
						</div>
					</div>-->
					
					<div class="portlet ui-widget ui-widget-content ui-helper-clearfix ui-corner-all">
						<div class="portlet-header ui-widget-header">Ajustar Ancho del Sito</div>
						<div class="portlet-content">
							<ul class="side-menu layout-options">
								<li>
									Seleccione el ancho que prefiera<br /><br />
								</li>
								<li>
									<a href="javascript:void(0);" id="" title="100%"><b>100%</b></a>
								</li>
								<li>
									<a href="javascript:void(0);" id="layout90" title="90%"><b>90%</b></a>
								</li>
								<li>
									<a href="javascript:void(0);" id="layout75" title="75%"><b>75%</b></a>
								</li>
								<li>
									<a href="javascript:void(0);" id="layout980" title="980px"><b>980px</b></a>
								</li>
								<li>
									<a href="javascript:void(0);" id="layout1280" title="1280px"><b>1280px</b></a>
								</li>
								<li>
									<a href="javascript:void(0);" id="layout1400" title="1400px"><b>1400px</b></a>
								</li>
								<li>
									<a href="javascript:void(0);" id="layout1600" title="1600px"><b>1600px</b></a>
								</li>
							</ul>
						</div>
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
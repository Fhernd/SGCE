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
	<script type="text/javascript" src="js/custom.js"></script>
        <script type="text/javascript" src="js/custom/validations.js"></script>
	
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
					<a href="dashboard.jsp" class="logo" title="SGCE">SGCE</a>
					<div class="welcome">
						<span class="note">Bienvenid@, <a href="#" title="Welcome, Horia Simon"><% out.print( session.getAttribute( "name" ) ); %></a></span>
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
                                        
                                    
                                    
                                        <%@include file="snippets/ACLMenu.jsp" %>
                                    
                                    
                                </ul>
				<div id="search-bar">
					<form method="post" action="http://www.google.com/">
						<input type="text" name="q" value="live search demo" />
					</form>
				</div>
			</div>
		</div><script type="text/javascript" src="js/validate.js"></script>

	<script type="text/javascript">
$().ready(function() {
	// validate the comment form when it is submitted
	$("#commentForm").validate();
	
	// validate signup form on keyup and submit
	$("#signupForm").validate({
		rules: {
			firstname: "required",
			lastname: "required",
			username: {
				required: true,
				minlength: 2
			},
			password: {
				required: true,
				minlength: 5
			},
			confirm_password: {
				required: true,
				minlength: 5,
				equalTo: "#password"
			},
			email: {
				required: true,
				email: true
			},
			topic: {
				required: "#newsletter:checked",
				minlength: 2
			},
		messages: {
			firstname: "Please enter your firstname",
			lastname: "Please enter your lastname",
			username: {
				required: "Please enter a username",
				minlength: "Your username must consist of at least 2 characters"
			},
			password: {
				required: "Please provide a password",
				minlength: "Your password must be at least 5 characters long"
			},
			confirm_password: {
				required: "Please provide a password",
				minlength: "Your password must be at least 5 characters long",
				equalTo: "Please enter the same password as above"
			},
			email: "Please enter a valid email address",
			agree: "Please accept our policy"
		}
		}


});
});

	</script>
		<div id="sub-nav"><div class="page-title">
			<h1>Form validation example</h1>
			<span><a href="#" title="Dashboard">Dashboard</a> > <a href="#" title="Forms">Forms</a> > Form Validation</span>
		</div>
		<div id="top-buttons">
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
                                    <h2>Opciones de Usuario</h2>
					<span></span>
				</div>
				<div class="column-content-box">
					<div class="content-box content-box-header ui-corner-all">
						<div class="ui-state-default ui-corner-top ui-box-header">
							<span class="ui-icon float-left ui-icon-notice"></span>
                                                        CAMBIO DE CONTRASE&Ntilde;A:
						</div>
                                                <%
                                                    String success = "<div class=\"response-msg success ui-corner-all\"><span>Complete el formulario</span>Llene los campos que aparecen a continuaci&oacute;n para cambiar la contrase&ntilde;a. [NOTA: S&oacute;lo se admite un cambio de contrase&ntilde;a por sesi�n].</div>";
                                                    String bad = "<div class=\"response-msg error ui-corner-all\"><span>Error:</span>Los datos que ha digitado no son v&aacute;lidos. INTENTE DE NUEVO. [Nota: S&oacute;lo se admite un cambio de contrase&ntilde;a por sesi�n.</div>";
                                                    
                                                    if( session.getAttribute( "cambioContrCorrecto") == null  )
                                                    {
                                                        out.print( success );
                                                    }
                                                    else if( session.getAttribute( "cambioContrCorrecto") != null && ( Boolean )session.getAttribute( "cambioContrCorrecto" ) )
                                                    {
                                                        out.print( "<div class=\"response-msg success ui-corner-all\"><span>CAMBIO SATISFACTORIO</span>Los cambios se realizaron satisfactoriamente.</div>"  );
                                                        session.setAttribute( "cambioContrCorrecto", null);
                                                    }
                                                    else
                                                    {
                                                        out.print( bad );
                                                        session.setAttribute( "cambioContrCorrecto", null);
                                                    }
                                                    
                                                    
                                                
                                                %>
						<div class="content-box-wrapper">
							<form class="forms" id="signupForm" method="post" action="cambioContrasegnia.jsp">
								<fieldset>
									<ul>
										<li>
                                                                                    <label class="desc" for="username">Contrase&ntilde;a Actual</label>
                                                                                        <div><input id="username" class="field text full" name="oldpassword" type="password"/></div>
										</li>
										<li>
											<label class="desc" for="password">Contrase&ntilde;a</label>
								
											<div><input id="password" class="field text full" name="password" type="password" /></div>
										</li>
										<li>
										<label class="desc" for="confirm_password">Confirmar contrase&ntilde;a</label>
											<div><input id="confirm_password" class="field text full" name="confirm_password" type="password" /></div>
										</li>
								
										<li>
                                                                                    <input class="submit" type="submit" value="Cambiar"/>
                                                                                </li>
									</ul>
								</fieldset>
							</form>
						</div>
					</div>
				</div>
                                                
                                 		<div class="column-content-box">
					<div class="content-box content-box-header ui-corner-all">
						<div class="ui-state-default ui-corner-top ui-box-header">
							<span class="ui-icon float-left ui-icon-notice"></span>
                                                        CAMBIAR O ESPECIFICAR EMAIL :
						</div>
                                            
                                                <%
                                                    success = "<div class=\"response-msg success ui-corner-all\"><span>Complete el formulario</span>Llene los campos que aparecen a continuaci&oacute;n para cambiar/especificar un email.</div>";
                                                    bad = "<div class=\"response-msg error ui-corner-all\"><span>Error:</span>Los datos que ha digitado no son v&aacute;lidos. INTENTE DE NUEVO.</div>";
                                                    
                                                    if( session.getAttribute( "cambioEmailCorrecto") == null  )
                                                    {
                                                        out.print( success );
                                                    }
                                                    else if( session.getAttribute( "cambioEmailCorrecto") != null && ( Boolean )session.getAttribute( "cambioEmailCorrecto" ) )
                                                    {
                                                        out.print( "<div class=\"response-msg success ui-corner-all\"><span>CAMBIO SATISFACTORIO</span>Los cambios se realizaron satisfactoriamente.</div>"  );
                                                        session.setAttribute( "cambioEmailCorrecto", null);
                                                    }
                                                    else
                                                    {
                                                        out.print( bad );
                                                        session.setAttribute( "cambioEmailCorrecto", null);
                                                    }
                                                    
                                                    
                                                
                                                %>
						<div class="content-box-wrapper">
                                                    <form class="forms" id="signupForm" method="post" action="cambioEmail.jsp" onsubmit="return validateEmail()">
								<fieldset>
									<ul>
										<li>
											<label class="desc" for="firstname">Contrase&ntilde;a Actual</label>
											<div><input type="password" id="oldpassword" class="field text full" name="oldpassword" /></div>
										</li>
										<li>
											<label class="desc" for="email">Email Nuevo</label>
                                                                                        <div><input id="useremail" class="field text full" name="useremail"  /></div>
										</li>
								
										<li>
											<input class="submit" type="submit" value="Cambiar"/>
										</li>
									</ul>
								</fieldset>
							</form>
						</div>
					</div>
				</div>	               
				<div class="clearfix"></div>
						<div id="sidebar">
			<div class="sidebar-content">
				<a id="close_sidebar" class="btn ui-state-default full-link ui-corner-all" href="#drill">
					<span class="ui-icon ui-icon-circle-arrow-e"></span>
					Ocultar
				</a>
				<a id="open_sidebar" class="btn tooltip ui-state-default full-link icon-only ui-corner-all" title="Open Sidebar" href="#"><span class="ui-icon ui-icon-circle-arrow-w"></span></a>
				<div class="hide_sidebar">
                                        <div class="other-box yellow-box ui-corner-all ui-corner-all">
                                            <div class="cont tooltip ui-corner-all" title="Sugerencia">
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
		<a href="#" title="Home">Home</a> | 
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
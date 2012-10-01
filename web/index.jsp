 <%@ page language="java" import="java.sql.*" %>
 <%@include file="snippets/DbParams.jsp" %>
<%

    String driver = "com.mysql.jdbc.Driver";
    Class.forName(driver).newInstance();

    Connection con = null;
    ResultSet rst = null;
    Statement stmt = null;
    
    boolean error = false;

    try
    {
        con=DriverManager.getConnection( UrL, UseR, PassworD );
        stmt=con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );
        
        
        if( request.getParameter( "username" ) != null && request.getParameter( "password") != null )
        {
            
            String user = request.getParameter( "username" );
            String pass= request.getParameter( "password" );
            
            String query = "SELECT idcedulanit, nombrepropietario, contrasegnia, nivelacceso FROM usuario WHERE idcedulanit = " + Long.parseLong( user )+ " AND contrasegnia = '" + pass + "'";

            rst = stmt.executeQuery( query );

            if( rst.next() )
            {
                session.setAttribute( "username", user);
                session.setAttribute( "password", pass );
                session.setAttribute( "name", rst.getString( "nombrepropietario") );
                session.setAttribute( "nivelacceso", rst.getString( "nivelacceso") );
                
                session.setAttribute( "logged", true );
                
                con.close();
                
                    response.sendRedirect( "dashboard.jsp");
            } // end if
            else
            {
                error = true;
            } // end if
        } // end if
    } // end try
    catch(Exception e )
    {
        out.println(e.getMessage());
    } // end catch
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
	<script type="text/javascript" src="js/sidebar_menu.html"></script>
	<script type="text/javascript" src="js/tooltip.js"></script>
	<script type="text/javascript" src="js/cookie.js"></script>
	<script type="text/javascript" src="js/ui/ui.sortable.js"></script>
	<script type="text/javascript" src="js/ui/ui.draggable.js"></script>
	<script type="text/javascript" src="js/ui/ui.resizable.js"></script>
	<script type="text/javascript" src="js/ui/ui.dialog.js"></script>
	<script type="text/javascript" src="js/custom.js"></script>
        <script type="text/javascript" src="js/custom/validations.js"></script>
	
	<link href="css/ui/ui.base.css" rel="stylesheet" media="all" />

	<link href="css/ui/ui.login.css" rel="stylesheet" media="all" />

	<link href="css/themes/gray_lightness/ui.css" rel="stylesheet" media="all" />

	<link href="css/themes/gray_lightness/ui.css" rel="stylesheet" title="style" media="all" />

</head>
<body>
	<div id="page_wrapper">
		<div id="page-header">
			<div id="page-header-wrapper">
				<div id="top">
                                    <a href="#" class="logo" title="SGCE" >Plataforma de Gesti&oacute;n de Extractos y Certificados</a>
					<!--<div class="welcome">
						<span class="note">Welcome, <a href="#" title="Welcome, Horia Simon">Horia Simon</a></span>
						<a class="btn ui-state-default ui-corner-all" href="#">
							<span class="ui-icon ui-icon-wrench"></span>
							Settings
						</a>
						<a class="btn ui-state-default ui-corner-all" href="#">
							<span class="ui-icon ui-icon-person"></span>
							My account
						</a>
						<a class="btn ui-state-default ui-corner-all" href="#">
							<span class="ui-icon ui-icon-power"></span>
							Logout
						</a>						
					</div>-->
				</div>
			</div>
		</div>
<script type="text/javascript" src="js/ui/ui.tabs.js"></script>
<script type="text/javascript" src="js/validate.js"></script>

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
				required: "Espec&iacute;fique una contrase&ntilde;a",
				minlength: "Your password must be at least 5 characters long"
			},
			confirm_password: {
				required: "I",
				minlength: "Su contrase&ntilde;a debe tener por lo menos 5 caracteres.",
				equalTo: "Espec&iacute;fique una contrase&ntilde;a igual que la anterior."
			},
			email: "Espec&iacute;fique una direcci&oacute;n de email válida.",
			agree: "Please accept our policy"
		}
		}


});
});

	</script>
<script type="text/javascript">
$(document).ready(function() {
	// Tabs
	$('#tabs, #tabs2, #tabs5').tabs();
});
</script>
		<div id="sub-nav">
			<div class="page-title">
				<h1>Inicio de Sesi&oacute;n</h1>
				<span>Formulario de acceso al sistema</span>
			</div>
		<div id="top-buttons">
			<a id="modal_confirmation_link" class="btn ui-state-default ui-corner-all" href="#">
				<span class="ui-icon ui-icon-grip-dotted-horizontal"></span>
				Ayuda (?)
			</a>
			<ul class="drop-down">
				<li>

				</li>
			</ul>	
		</div>
			<div id="dialog" title="Dialog Title">
				<p>&nbsp;</p>
			</div>
			<div id="modal_confirmation" title="Ayuda">
				<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Para iniciar sesi&oacute;n introduzca su nombre de usuario (el c&oacute;digo n&uacute;mero de cuenta).</p>
			</div>
		</div>
		<div class="clear"></div>
		<div id="page-layout">
			<div id="page-content">
				<div id="page-content-wrapper">

				<div id="tabs">
					<ul>

						<li><a href="#login">Inicio Sesi&oacute;n</a></li>
						<!--<li><a href="#tabs-2">Registrarse</a></li>-->
						<li><a href="#tabs-3">Recuperar contrase&ntilde;a</a></li>
					</ul>
					<div id="login">
                                            <%
						String success = "<div class=\"response-msg success ui-corner-all\"><span>Bienvenido</span>Llene los campos que aparecen a continuaci&oacute;n para iniciar sesi&oacute;n.</div>";
                                                String bad = "<div class=\"response-msg error ui-corner-all\"><span>Error:</span>Los datos que ha digitado no son v&aacute;lidos. INTENTE DE NUEVO.</div>";
                                                
                                                if( error )
                                                {
                                                    out.print( bad );
                                                }
                                                else
                                                {
                                                    out.print( success );
                                                }
                                                                
                                            %>
                                            <form action="index.jsp" method="post" onsubmit="return validateData()">
							<ul>
								<li>
									<label for="email" class="desc">
				
										<div class="cont ui-corner-all tooltip" title="El n&uacute;mero de cuenta asignado por la inmobiliaria.">
								<h3>Nombre de usuario:							</h3>
							</div>
									</label>
									<div>
                                                                            <input type="text" tabindex="1" maxlength="255" value="" class="field text full" name="username" id="email" autocomplete="off" />
									</div>
								</li>
								<li>
									<label for="password" class="desc">
										<div class="cont ui-corner-all tooltip" title="La clave de acceso suministrada por la inmobiliaria o una personalizada.">
								<h3>Contrase&ntilde;a							</h3>
							</div>
									</label>
				
									<div>
										<input type="password" tabindex="1" maxlength="255" value="" class="field text full" name="password" id="password" autocomplete="off"/>
									</div>
								</li>
								<li class="buttons">
									<div>
										<button class="ui-state-default ui-corner-all float-right ui-button" type="submit">Iniciar Sesi&oacute;n</button>
									</div>
								</li>
							</ul>
						</form>
					</div>
					<!--<div id="tabs-2">
						<div class="other-box gray-box ui-corner-all">
							<div class="cont ui-corner-all tooltip" title="Example tooltip!">
								<h3>Registro							</h3>
							</div>
						</div>
						<p>Rellene los campos para crear el registro:</p>
                                            <div class="column-content-box">
					<div class="content-box content-box-header ui-corner-all">
						<div class="ui-state-default ui-corner-top ui-box-header">
							<span class="ui-icon float-left ui-icon-notice"></span>
							Formulario de Registro
						</div>
						<div class="content-box-wrapper">
							<form class="forms" id="signupForm" method="get" action="#">
								<fieldset>
									<ul>
										<li>
											<label class="desc" for="firstname">Nombres</label>
											<div><input id="firstname" class="field text full" name="firstname" /></div>
										</li>
										<li>
											<label class="desc" for="lastname">Apellido</label>
								
											<div><input id="lastname" class="field text full" name="lastname" /></div>
										</li>
										<li>
											<label class="desc" for="username">Nombre de usuario</label>
											<div><input id="username" class="field text full" name="username" /></div>
										</li>
										<li>
											<label class="desc" for="password">Contrase&ntilde;a</label>
								
											<div><input id="password" class="field text full" name="password" type="password" /></div>
										</li>
										<li>
											<label class="desc" for="confirm_password">Confimar contrase&ntilde;a</label>
											<div><input id="confirm_password" class="field text full" name="confirm_password" type="password" /></div>
										</li>
										<li>
											<label class="desc" for="email">Email</label>
											<div><input id="email" class="field text full" name="email" /></div>
										</li>
								
										<li>
											<input class="submit" type="submit" value="Registrarse"/>
										</li>
									</ul>
								</fieldset>
							</form>
						</div>
					</div>
				</div>
					</div>-->
					<div id="tabs-3">
                                            <form action="etc/recoverMail.jsp" onsubmit="return validateEmail()">
							<ul>
								<li>
									<label for="email" class="desc" >
										Email:
									</label>
									<div>
										<input type="text" tabindex="1" maxlength="255" class="field text full" name="useremail" id="useremail" />
									</div>
								</li>
								<li class="buttons">
									<div>
										<button class="ui-state-default ui-corner-all float-right ui-button" type="submit">Enviar contrase&ntilde;a al correo</button>
									</div>
								</li>
							</ul>
						</form>
					</div>
				</div>



				</div>
				<div class="clear"></div>
                                
                                <br/>
                                <br/>
                                <br/>
                                <br/>
                                <br/>
                                <br/>
                                <br/>
                                <br/>
                                <br/>
                                <br/>
                                <center><strong>Esta Aplicaci&oacute;n es Compatible Con:</strong></center>
                                <br/>
                                <center><table><tr><td><img src="images/browser-compatibility.jpg" width="280" height="60"></img></td></tr></table></center>
                                <br/>
                                <br/>
                                <br/>
                                <br/>
                                
			</div>
                                            
                        
		</div>
	</div>
</body>
</html>
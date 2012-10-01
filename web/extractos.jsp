<%@page import="java.sql.DriverManager"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.jdbc.Connection"%>
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
        <script type="text/javascript" src="js/custom/reporting.js"></script>
	
        <link rel="stylesheet" href="css/lightbox.css" type="text/css" media="screen" />
	<link href="css/ui/ui.base.css" rel="stylesheet" media="all" />

	<link href="css/themes/gray_lightness/ui.css" rel="stylesheet" media="all" />

	<link href="css/themes/gray_lightness/ui.css" rel="stylesheet" title="style" media="all" />
        
</head>
<body>
	<div id="page_wrapper">
		<div id="page-header">
			<div id="page-header-wrapper">
				<div id="top">
					<a href="dashboard.jsp" class="logo" title="SGCE">SGCE</a>
					<div class="welcome">
						<span class="note">Bienvenid@, <a href="#" title="Bienvenid@"><% out.print( session.getAttribute( "name" ) ); %></a></span>
						<a class="btn ui-state-default ui-corner-all" href="opcionesUsuario.jsp">
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
		</div><script type="text/javascript" src="js/ui/ui.tabs.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	// Tabs
	$('#tabs').tabs();
});
</script>
                
                
		<div id="sub-nav"><div class="page-title">
			<h1>Tabs Widget</h1>
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
					<h2>Extractos</h2>
                                        <span>Desde este apartado podrá gestionar sus extractos: Visualización, Descarga e Impresi&oacute;n</span>
				</div>

                            
                            

<br /><br />
					<div class="inner-page-title">
						<h3>Usted posee las siguientes cuentas:</h3>
					</div>
				<div class="content-box">
                                    <table width="508" border="1" class="imagetable">
				    <tr>
				      <th width="135">Número Cuenta</th>
				      <th width="28">Mes</th>
				      <th width="96">Visualizar</th>
				      <th width="59">Descargar</th>
                                    </tr>
                                    <%@include file="snippets/DbParams.jsp" %>
                                    <%
                                        
                                        String driver = "com.mysql.jdbc.Driver";
                                        Class.forName(driver).newInstance();

                                        Connection con = null;
                                        ResultSet rst = null;
                                        ResultSet rstSelect = null;
                                        Statement stmt = null;
                                        Statement stmt2 = null;

                                        try
                                        {
                                            con= (Connection )DriverManager.getConnection( UrL, UseR, PassworD );
                                            
                                            stmt= (Statement ) con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );
                                            stmt2 = (Statement ) con.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY );
                                            
                                            String query = "SELECT DISTINCT extractos.cuenta_codigocuenta FROM extractos INNER JOIN usuario_has_cuenta ON usuario_has_cuenta.usuario_idcedulanit = " + Long.parseLong( session.getAttribute( "username" ).toString() ) + " AND extractos.cuenta_codigocuenta = usuario_has_cuenta.cuenta_codigocuenta";

                                            rst = stmt.executeQuery( query );
                                            
                                            while( rst.next() )
                                            {
                                                
                                                out.print( "<tr name=\"tr\">");
                                                out.print( "<td>");
                                                out.print( rst.getLong( "cuenta_codigocuenta"));
                                                out.print( "</td>");
                                                
                                                String querySelectControl = "SELECT DATE_FORMAT(fechainicialmovimiento,'%d %b %Y') AS 'fecha_formateada', fechainicialmovimiento FROM extractos WHERE cuenta_codigocuenta = " + rst.getLong( "cuenta_codigocuenta" ) + " GROUP BY fechainicialmovimiento DESC LIMIT 3";
                                                rstSelect = stmt2.executeQuery( querySelectControl );
                                                
                                                out.print( "<td name=\"selectMonth\">");
                                                
                                                    
                                                    out.print( "<select name=\"periodos\">" );
                                                    
                                                    while( rstSelect.next() )
                                                    {
                                                       
                                                        out.print( "<option value=\"" + rstSelect.getString( "fechainicialmovimiento" ) + "\">" + ( rstSelect.getObject( "fecha_formateada" ) != null ?  rstSelect.getString( "fecha_formateada" ) : "Cuenta sin Extracto" )+ "</option>");
                                                    } // end while
                                                                                                        
                                                    out.print( "</select>");
                                                
                                                out.print( "</td>");
                                                
                                                // view report
                                                out.print( "<td name=\"td\">");
                                                    out.print( "<a href=\"#\" onclick=\"viewReport( '" + session.getAttribute( "username" ) + "', '" +  rst.getLong( "cuenta_codigocuenta" ) + "', this );\"><span class=\"ui-icon ui-icon-circle-triangle-e\"></a>");
                                                out.print( "</td>");
                                                
                                                // download report
                                                out.print( "<td>");
                                                    out.print( "<a href=\"#\" onclick=\"downloadReport( '" + session.getAttribute( "username" ) + "', '" +  rst.getLong( "cuenta_codigocuenta" ) + "', this );\"><span class=\"ui-icon ui-icon-circle-arrow-s\"></a>");
                                                out.print( "</td>");
                                                
                                                out.print( "</tr>");
                                            } // end while
                                            

                                        } // end try
                                        catch(Exception e )
                                        {
                                            out.print(e.getMessage());
                                        } // end catch
                                        finally
                                        {
                                            con.close();
                                        }

                                    %>
			      </table>
                                    <div align="center"></div>
                </div>                            
                            
                            <div class="clearfix"></div>
                           
                                <div class="content-box">
                                     <div id="printableArea">
                                        <center><iframe id="reportPlaceHolder" width="100%" height="1399" style="dispaly:none;"></iframe></center>
                                        
                                      </div>  
                                </div>
				<div class="clearfix"></div>
				<i class="note">* To .</i>
						<div id="sidebar">
			<div class="sidebar-content">
				<a id="close_sidebar" class="btn ui-state-default full-link ui-corner-all" href="#drill">
					<span class="ui-icon ui-icon-circle-arrow-e"></span>
					Ocultar Barra de Opciones
				</a>
				<a id="open_sidebar" class="btn tooltip ui-state-default full-link icon-only ui-corner-all" title="Open Sidebar" href="#"><span class="ui-icon ui-icon-circle-arrow-w"></span></a>
				<div class="hide_sidebar">

					
					<div class="portlet ui-widget ui-widget-content ui-helper-clearfix ui-corner-all">
						<div class="portlet-header ui-widget-header">Ajustar Ancho del Sitio</div>
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
						<h3>Navigation</h3>
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
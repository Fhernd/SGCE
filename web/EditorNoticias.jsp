<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">

<%
    if( !( Boolean.parseBoolean( String.valueOf( session.getAttribute( "logged" ) ) ) ) )
    {
        response.sendRedirect( "index.jsp" );
    }
    else
    {
        
    }
%>
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
        
        <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.8.0r4/build/assets/skins/sam/skin.css">
        <script type="text/javascript" src="http://yui.yahooapis.com/2.8.0r4/build/yahoo-dom-event/yahoo-dom-event.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.8.0r4/build/element/element-min.js"></script>
        <script src="http://yui.yahooapis.com/2.8.0r4/build/container/container_core-min.js"></script>
        <script src="http://yui.yahooapis.com/2.8.0r4/build/menu/menu-min.js"></script>
        <script src="http://yui.yahooapis.com/2.8.0r4/build/button/button-min.js"></script>
        <script src="http://yui.yahooapis.com/2.8.0r4/build/editor/editor-min.js"></script>
	
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
		</div>
<script type="text/javascript" src="tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript">
	tinyMCE.init({
		// General options
		mode : "textareas",
		theme : "advanced",
		plugins : "safari,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,wordcount",

		// Theme options
		theme_advanced_buttons1 : "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect",
		theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
		theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
		theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak",
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",
		theme_advanced_statusbar_location : "bottom",
		theme_advanced_resizing : true,



		// Drop lists for link/image/media/template dialogs
		template_external_list_url : "lists/template_list.js",
		external_link_list_url : "lists/link_list.js",
		external_image_list_url : "lists/image_list.js",
		media_external_list_url : "lists/media_list.js",

		// Replace values for the template plugin
		template_replace_values : {
			username : "Some User",
			staffid : "991234"
		}
	});
</script>
<!-- /TinyMCE -->

		<div id="sub-nav"><div class="page-title">
			<h1>Editor de Notificaciones de Portada</h1>
			<span>Redactar notificaciones.</span>
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
		
						<iframe src="http://209.51.146.156/ext/cms/index.php/81-admin/71-auth-form" style="width: 100%; height: 69%;"></iframe>
                            
                            
				<div class="clearfix"></div>
						<div id="sidebar">
			<div class="sidebar-content">
				<a id="close_sidebar" class="btn ui-state-default full-link ui-corner-all" href="#drill">
					<span class="ui-icon ui-icon-circle-arrow-e"></span>
					Close Sidebar
				</a>
				<a id="open_sidebar" class="btn tooltip ui-state-default full-link icon-only ui-corner-all" title="Open Sidebar" href="#"><span class="ui-icon ui-icon-circle-arrow-w"></span></a>
				<div class="hide_sidebar">
					<!--<div class="portlet ui-widget ui-widget-content ui-helper-clearfix ui-corner-all">
						<div class="portlet-header ui-widget-header">Theme Switcher<span class="ui-icon ui-icon-circle-arrow-s"></span></div>
						<div class="portlet-content">
							<ul id="style-switcher" class="side-menu">
								<li>
									<a class="set_theme" id="black_rose" href="#" title="Black Rose Theme">Black Rose Theme</a>
								</li>
								<li>
									<a class="set_theme" id="gray_standard" href="#" title="Gray Standard Theme">Gray Standard Theme</a>
								</li>
								<li>
									<a class="set_theme" id="gray_lightness" href="#" title="Gray Lightness Theme">Gray Lightness Theme</a>
								</li>
								<li>
									<a class="set_theme" id="apple_pie" href="#" title="Apple Pie Theme">Apple Pie Theme</a>
								</li>
								<li>
									<a class="set_theme" id="blueberry" href="#" title="Blueberry Theme">Blueberry Theme</a>
								</li>
							</ul>
						</div>
					</div>-->
					
					<!--<div class="portlet ui-widget ui-widget-content ui-helper-clearfix ui-corner-all">
						<div class="portlet-header ui-widget-header">Change layout width</div>
						<div class="portlet-content">
							<ul class="side-menu layout-options">
								<li>
									What width would you like the page to have ?<br /><br />
								</li>
								<li>
									<a href="javascript:void(0);" id="" title="Switch to 100% width layout">Switch to <b>100%</b> width</a>
								</li>
								<li>
									<a href="javascript:void(0);" id="layout90" title="Switch to 90% width layout">Switch to <b>90%</b> width</a>
								</li>
								<li>
									<a href="javascript:void(0);" id="layout75" title="Switch to 75% width layout">Switch to <b>75%</b> width</a>
								</li>
								<li>
									<a href="javascript:void(0);" id="layout980" title="Switch to 980px layout">Switch to <b>980px</b> width</a>
								</li>
								<li>
									<a href="javascript:void(0);" id="layout1280" title="Switch to 1280px layout">Switch to <b>1280px</b> width</a>
								</li>
								<li>
									<a href="javascript:void(0);" id="layout1400" title="Switch to 1400px layout">Switch to <b>1400px</b> width</a>
								</li>
								<li>
									<a href="javascript:void(0);" id="layout1600" title="Switch to 1600px layout">Switch to <b>1600px</b> width</a>
								</li>
							</ul>
						</div>
					</div>-->
					
					<!--
					<div class="box ui-widget ui-widget-content ui-corner-all">
						<h3>Navigation</h3>
						<div class="content">
							<a class="btn ui-state-default full-link ui-corner-all" href="#">
								<span class="ui-icon ui-icon-mail-closed"></span>
								Dummy link
							</a>
							<a class="btn ui-state-default full-link ui-corner-all" href="#">
								<span class="ui-icon ui-icon-arrowreturnthick-1-n"></span>
								Dummy link
							</a>
							<a class="btn ui-state-default full-link ui-corner-all" href="#">
								<span class="ui-icon ui-icon-scissors"></span>
								Dummy link
							</a>
							<a class="btn ui-state-default full-link ui-corner-all" href="#">
								<span class="ui-icon ui-icon-signal-diag"></span>
								Dummy link
							</a>
							<a class="btn ui-state-default full-link ui-corner-all" href="#">
								<span class="ui-icon ui-icon-alert"></span>
								With icon and also quite large link
							</a>
						</div>
					</div>-->
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
		
	</div>
<!-- Do not remove the copyright notice unless you have purchased a Commercial License from admintasia.com -->
	<div id="copyright">
		
	</div>
<!-- Do not remove the copyright notice unless you have purchased a Commercial License from admintasia.com --></div>
</body>

<!-- www.forowarez.es -->
</html>
<%-- 
    Document   : NewsEditorç
    Created on : Dec 12, 2011, 5:06:47 PM
    Author     : johnoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.8.0r4/build/assets/skins/sam/skin.css">
        <script type="text/javascript" src="http://yui.yahooapis.com/2.8.0r4/build/yahoo-dom-event/yahoo-dom-event.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.8.0r4/build/element/element-min.js"></script>
        <script src="http://yui.yahooapis.com/2.8.0r4/build/container/container_core-min.js"></script>
        <script src="http://yui.yahooapis.com/2.8.0r4/build/menu/menu-min.js"></script>
        <script src="http://yui.yahooapis.com/2.8.0r4/build/button/button-min.js"></script>
        <script src="http://yui.yahooapis.com/2.8.0r4/build/editor/editor-min.js"></script>
        <script language="javascript">
            
            function activateDeactivateTextArea( thisElement )
            {
                document.write( "okeh" );

            }
            
        </script>
    </head>
    <body>
        <form action="NewsEditor.jsp" method="post">
            <p class="yui-skin-sam">
                <textarea name="myrichtext" id="myrichtext"  onkeypress="activateDeactivateTextArea(this)"></textarea> 
                <script>
                    var myEditor = new YAHOO.widget.Editor('myrichtext', {
                    height: '300px',
                    width: '600px',
                    dompath: true, //Turns on the bar at the bottom
                    animate: true, //Animates the opening, closing and moving of Editor windows
                    handleSubmit: true 
                    });
                    myEditor.render();
                </script>
            </p>
            
            <input type="Submit" value="Set" id="save"/>
        </form>
    </body>
    
    
    <%
        out.println( request.getParameter( "myrichtext" ) );
    %>
</html>

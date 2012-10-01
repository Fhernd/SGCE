<%@page import="java.sql.DriverManager"%>
<%@page import="mail.MailSender"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.jdbc.Connection"%>
<%@include file="../snippets/DbParams.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />
        <script type="text/javascript"
        src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
        <script src="../js/jquery.autocomplete.js"></script>
        <style>
            input {
                font-size: 120%;
            }
        </style>



        <link rel="stylesheet" type="text/css" href="../css/VisualComponents.css" />

    </head>
    <body>

        <form id="form1" action="EnviarEmailCPProcesar.jsp" onsubmit="return observacionNueva()">

            <br/>
            <br/>
            <label>Fecha de carga de Cupones de Pago:</label>
            <select name="fechaCP" id="fechaCPID">

            <%

                Connection con = null;
                ResultSet rst = null;
                Statement stmt = null;

                try {
                    String driver = "com.mysql.jdbc.Driver";
                    Class.forName(driver).newInstance();

                    con = (Connection) DriverManager.getConnection(UrL, UseR, PassworD);

                    stmt = (Statement) con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);

                    String query = "SELECT DISTINCT fechaadicioncuponpago FROM usuario_como_inquilino ";

                    rst = stmt.executeQuery(query);

                    while (rst.next()) {
                        out.print("<option value=\"" + rst.getString("fechaadicioncuponpago") + "\">");
                        out.print(rst.getString("fechaadicioncuponpago"));
                        out.print("</option>");
                    }

                    con.close();
                } // end try
                catch (Exception e) {
                    e.printStackTrace();
                } // end catch*/

            %>
            </select>
            <input type="submit" value="Enviar Email" class="myButton">

        </form>
    </body>
</html>
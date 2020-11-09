<%-- 
    Document   : reporte1
    Created on : Nov 9, 2020, 4:06:49 AM
    Author     : demon
--%>

<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%@page import="java.io.File"%>
<%@page import="com.conexion.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String start = request.getParameter("datFrom");
            String end = request.getParameter("datTo");
            Conexion con = new Conexion();
            con.conectar();
            File reporte = new File(application.getRealPath("/DauteProject/web/reportes/report2.jasper"));
            Map parametros = new HashMap();
        //    parametros.put("dFrom", start);
          //  parametros.put("dTo", end);
            byte[] bytes = JasperRunManager.runReportToPdf(reporte.getPath(), parametros,con.getCon());
            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream output = response.getOutputStream();
            response.getOutputStream();
            output.write(bytes, 0, bytes.length);
            output.flush();
            output.close();
        %>
        
    </body>
</html>

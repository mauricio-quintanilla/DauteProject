<%-- 
    Document   : repBoleta
    Created on : 13-nov-2020, 4:39:14
    Author     : abc
--%>

<%@page import="java.util.Map"%>
<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.io.File"%>
<%@page import="com.conexion.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Boleta de pago</title>
    </head>
    <body>
        <%
           
             int valor=1;
             if(request.getParameter("id") != null){
                 valor = Integer.parseInt(request.getParameter("id"));
             } else {
                 valor = 1;
             }
             
            Conexion con = new Conexion();
            con.conectar();
            File reporte = new File(application.getRealPath("reportes/repoBoleta.jasper"));
            Map parametros = new HashMap();
            parametros.put("name",valor);
            byte[] bytes = JasperRunManager.runReportToPdf(reporte.getPath(), parametros, con.getCon());
            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream output = response.getOutputStream();
            output.write(bytes, 0, bytes.length);
            output.flush();
            output.close();
        
        %>
    </body>
</html>

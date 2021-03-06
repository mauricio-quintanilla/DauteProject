<%-- 
    Document   : rep11
    Created on : Nov 9, 2020, 5:16:01 PM
    Author     : demon
--%>

<%@page import="java.util.HashMap"%>
<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%@page import="java.util.Map"%>
<%@page import="java.io.File"%>
<%@page import="com.conexion.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reportes</title>
    </head>
    <body>
        <%
            String sta;
            String fin;
            int idEmp ;
            Conexion con = new Conexion();
            con.conectar();
            File reporte = null;
            Map parametros = new HashMap();
            if(request.getParameter("fin")!=null){
                reporte = new File(application.getRealPath("/reportes/repProFinal.jasper"));
                sta = request.getParameter("datFrom");
                fin = request.getParameter("datTo");
                parametros.put("dFrom", sta);
                parametros.put("dTo", fin);
            }else if(request.getParameter("active")!=null){
                reporte = new File(application.getRealPath("/reportes/repProFechas.jasper"));
                sta = request.getParameter("datFrom");
                fin = request.getParameter("datTo");
                parametros.put("dFrom", sta);
                parametros.put("dTo", fin);
            }else{
                idEmp = Integer.parseInt(request.getParameter("selectB"));
                reporte = new File(application.getRealPath("/reportes/repoBoletas.jasper"));
                parametros.put("id", idEmp);
            }
            byte[] bytes = JasperRunManager.runReportToPdf(reporte.getPath(), parametros ,con.getCon());
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

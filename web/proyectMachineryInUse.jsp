<%-- 
    Document   : proyectMachineryInUse
    Created on : 04-nov-2020, 21:39:51
    Author     : abc
--%>

<%@page import="java.util.List"%>
<%@page import="com.model.Project"%>
<%@page import="com.model.InUse"%>
<%@page import="com.model.Equipment"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <%
            HttpSession sesion = request.getSession();
            String rol;
            if (sesion.getAttribute("rolName") == null) {
                response.sendRedirect("loginController?nosession=y");
            }
        %>
    <label>Role: <%= session.getAttribute("rolName")%></label>
    <label> Logged as: <%= session.getAttribute("usrOnSess")%></label>
    <img src="imgs/<%= session.getAttribute("profPic")%>" height="40px" width="40px">
    <a href="loginController?logout=y">Log out</a>
    <%
        Equipment equ = new Equipment();
        InUse inu = new InUse();
        Project prj = new Project();

    %>
    <title>Equipment</title>
    <script type="text/javascript" src="jquery.js"></script>
    <script>

    </script>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-1"></div>
            <div class="col-md-10">
                <center><h3>Maquinaria para el proyecto <%= session.getAttribute("name_attr")%> </h3></center>
            </div>
            <div class="col-md-1"></div>
        </div>

        <div class="row">

            <div class="col-md-12">
                
                
                <table  class='table'>
                    <tr class="thead-dark">
                        <th>Record Id</th>
                        <th>Equipment</th>
                        <th>on Project</th>
                        <th>Assigned</th>
                        <th>In Stock</th>
                        <th>action</th>
                    </tr>
                    <%
                        int id_param = (Integer) session.getAttribute("id_attr");
                        List<InUse> lst2 = inu.showInUse4Proyect(id_param);
                        for (InUse i : lst2) {
                    %>
                    <tr>
                        <td><%= i.getId()%></td>
                        <td><%= equ.getEqu(i.getEquipment_id()).getName()%> <%= equ.getEqu(i.getEquipment_id()).getModel()%></td>
                        <td><%= prj.getProyect(i.getProject_id()).getName()%></td>
                        <td><%= i.getEquipment_quantity()%> units</td>
                        <td><%= equ.getEqu(i.getEquipment_id()).getStock()%> units</td>
                        <td><a href="javascript:myLoad('<%= i.getId()%>','<%= i.getEquipment_id()%>',
                               '<%= i.getProject_id()%>','<%= i.getEquipment_quantity()%>')">Select</a></td>
                    </tr>
                    <%
                        }
                    %>
                </table>


            </div>
            <div>


            </div>




            <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
            </body>
            </html>

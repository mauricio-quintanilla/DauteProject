<%-- 
    Document   : workingDetalle
    Created on : 07-nov-2020, 10:33:21
    Author     : Ismael Castillo
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="com.model.Position"%>
<%@page import="java.util.List"%>
<%@page import="com.model.Employees"%>
<%@page import="com.model.Project"%>
<%@page import="com.model.Working"%>
<%@page session="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <%
            DecimalFormat df = new DecimalFormat("##.00");
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
        Working wop = new Working();
        Project prj = new Project();
        Employees emp = new Employees();
        Position pos = new Position();

    %>
    <title><%= session.getAttribute("name_attr")%> STAFF</title>
    <script type="text/javascript" src="jquery.js"></script>
    <script>
        function myLoad(id, project, employee, from, to, cost) {
            $("#txtId").val(id);
            $("#slctProId").val(project);
            $("#slctEmpId").val(employee);
            $("#datFrom").val(from);
            $("#datTo").val(to);
            $("#numCost").val(cost);
        }
    </script>
</head>
<body>
<center><h2>Personal de <%= session.getAttribute("name_attr")%></h2></center>
<div class="container">
    <form id="frmMain" action="workingDetalleController" method="POST">
        <div class='row'>
            <input type="hidden" name="txtId" id="txtId" class='form-control' value="0"/>
            <input type="hidden" name="slctProId" id="slctProId" value="<%= (Integer) session.getAttribute("id_attr")%>">
            <div class="col-6">
                <label>Employee</label>
                <select name="slctEmpId" id="slctEmpId" class='form-control'>
                    <%
                        List<Employees> lst = emp.showEmp();

                        for (Employees e : lst) {
                    %>
                    <option value="<%= e.getId()%>"><%= e.getFirst_name()%>
                        <%= e.getLast_name()%> (<%= pos.getPos(e.getPosition_id()).getName()%>) - <%= e.getStatus()%> </option>
                        <%
                            }
                        %>
                </select>
            </div>
            <div class="col-md-6">
                <label>Adding to project</label>
                <label>Cost</label>
                <input type="number" name="numCost" id="numCost" min='0.01' step="0.01" class='form-control' required/>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <label>en projecto desde</label>
                <input type="date" name="datFrom" id="datFrom" class='form-control' min='' max='' required/>
            </div>
            <div class="col-md-6">
                <label>en projecto hasta</label>
                <input type="date" name="datTo" id="datTo" value="" class='form-control' min='' max='' required/>
            </div>
        </div>






        <br>
        <input type="reset" name="btnNew" value="Add/Clear" class="btn btn-outline-info"/>
        <input type="submit" name="btnCreate" id="btnCreate" value="Create" class="btn btn-outline-success"/>
        <input type="submit" name="btnUpdate" id="btnUpdate" value="Update" class="btn btn-outline-warning"/>
        <input type="submit" name="btnDelete" id="btnDelete" value="Delete" class="btn btn-outline-danger"/>
    </form>
                
                <br>

    <table   class='table table-hover'>
        <tr class="thead-dark">
            <th>Nombre</th>
            <th>Cargo</th>
            <th>desde</th>
            <th>hasta</th>
            <th>dias en project</th>
            <th>sal mensual en proj</th>
            <th>costo en project</th>
            <th>action</th>
        </tr>
        <%
            int idHere = (Integer) session.getAttribute("id_attr");

            List<Working> lst1 = wop.showWorkingByPro(idHere);
            double total = 0;
            double totalF = 0;
            for (Working w : lst1) {
                String name = emp.getEmp(w.getEmployee_id()).getFirst_name()
                        + " " + emp.getEmp(w.getEmployee_id()).getLast_name();
        %>
        <tr>
            <td><%= name%></td>
            <td><%= pos.getPos((emp.getEmp(w.getEmployee_id()).getPosition_id())).getName()%></td>
            <td><%= w.getIn_pro_from()%></td>
            <td><%= w.getIn_pro_to()%></td>
            <td><%= w.daysIn(w.getIn_pro_from(), w.getIn_pro_to())%></td>
            <td>$<%= df.format(w.getCost())%></td>
            <%
                total = (w.daysIn(w.getIn_pro_from(), w.getIn_pro_to())) * (w.getCost() / 30);
                totalF = totalF + total;


            %>
            <td>$<%= df.format(total)%></td>
            <td><a href="javascript:myLoad(<%= w.getId()%>,<%= w.getProject_id()%>,
                           <%= w.getEmployee_id()%>,'<%= w.getIn_pro_from()%>','<%= w.getIn_pro_to()%>',
                           <%= w.getCost()%>)">Select</a>
            </td>
            <%
                }
            %>

        </tr>
        <tr>
            <th colspan="7">Total</th>
            <th>$<%= df.format(totalF)%></th>
            
        </tr>
    </table>
    <br>
    <p>go back to <a href="index.jsp">index</a></p>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
</body>
</html>
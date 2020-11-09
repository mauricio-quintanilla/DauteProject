<%-- 
    Document   : working
    Created on : Oct 23, 2020, 9:47:05 PM
    Author     : demon
--%>

<%@page import="java.time.LocalDate"%>
<%@page import="java.time.ZoneId"%>
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
            String aa = "";
            String bb = "";
            ZoneId zonedId = ZoneId.of( "America/El_Salvador" );
            LocalDate today = LocalDate.now( zonedId );
        %>
        <title>Project staff</title>
        <script type="text/javascript" src="jquery.js"></script>
        <script>
            function myLoad(id, project, employee, from, to, cost, minD, maxD, sal) {
                $("#txtId").val(id);
                $("#slctProId").val(project);
                $("#slctEmpId").val(employee);
                $("#datFrom").val(from);
                $("#datFrom").attr('min',minD);
                $("#datFrom").attr('max',maxD);
                $("#datTo").val(to);
                $("#datTo").attr('max',maxD);
                $("#datTo").attr('min',minD);
                $("#numCost").val(cost);
                $("#numCost").attr('min', sal);
            }
            function checkDates() {
                var dateS = document.getElementById('datFrom').value;
                var dateE = document.getElementById('datTo').value;
                var dateSP = new Date(dateS);
                var dateEP = new Date(dateE);
                if ( dateEP < dateSP ) { 
                    alert('fecha fin ' + dateEP + 'debe ser mayor fecha inicio' + dateSP);
                }
            }
            function setDates() {
                
            }
        </script>
    </head>
    <body>
        <h1>working in project CRUD</h1>
        <div class="container">
            <form id="frmMain" action="workingController" method="POST">
                <div class='col-6'>
                    <input type="hidden" name="txtId" id="txtId" class='form-control' value="0"/>
                    <label>Employee</label>
                    <select name="slctEmpId" id="slctEmpId" class='form-control'>
                        <%
                            List<Employees> lst = emp.showEmp();
                            //List<Employees> lst = emp.showEmpAvaila(); 
                            /*
                             *emp.showEmpAvaila() este metodo solo 
                             *muestra los availa pero a la hora de seleccionar para editar
                             *no permite elejir este valor asi que hay que validar que 
                             *no se puedan agregar nuevos usuarios que esten Unavailable
                            */
                            for (Employees e : lst) {
                        %>
                            <option value="<%= e.getId()%>"><%= e.getFirst_name()%>
                                <%= e.getLast_name()%> (<%= pos.getPos(e.getPosition_id()).getName()%>) - <%= e.getStatus()%> </option>
                        <%
                            }
                        %>
                    </select>
                    <label>Adding to project</label>
                    <select name="slctProId" id="slctProId" class='form-control'>
                        <%
                            List<Project> lst2 = prj.showPrj();
                            for (Project p : lst2) {
                        %>
                            <option value="<%= p.getId()%>" ><%= p.getName()%> <%= p.getDescription()%></option>
                        <%
                            }
                        %>
                    </select>
                    <label>en projecto desde</label>
                    <input type="date" name="datFrom" id="datFrom" class='form-control' min='' max='' required/>
                    <label>en projecto hasta</label>
                    <input type="date" name="datTo" id="datTo" class='form-control' min='' max='' required/>
                    <label>Cost</label>
                    <input type="number" name="numCost" id="numCost" min='0.01' step="0.01" class='form-control' required/>
                    
                </div>
                <br>
                <input type="button" onclick="checkDates()" class="btn btn-outline-info"/>
                <input type="reset" name="btnNew" value="Add/Clear" class="btn btn-outline-info"/>
                <input type="submit" name="btnCreate" id="btnCreate" value="Create" class="btn btn-outline-success"/>
                <input type="submit" name="btnUpdate" id="btnUpdate" value="Update" class="btn btn-outline-warning"/>
                <input type="submit" name="btnDelete" id="btnDelete" value="Delete" class="btn btn-outline-danger"/>
            </form>

            <table border="1" class=''>
                <tr>
                    <th>record id</th>
                    <th>employee</th>
                    <th>working on</th>
                    <th>on project from</th>
                    <th>on project to</th>
                    <th>cost</th>
                    <th>action</th>
                </tr>
                <%
                    List<Working> lst3 = wop.showWorking();
                    for (Working w : lst3) {
                        String name=emp.getEmp(w.getEmployee_id()).getFirst_name()
                                +" "+emp.getEmp(w.getEmployee_id()).getLast_name()
                                +"("+pos.getPos((emp.getEmp(w.getEmployee_id()).getPosition_id())).getName()+")";
                %>
                <tr>
                    <td><%= w.getId()%></td>//Id_del detalle
                    <td><%= name%></td>//nombre del Empleado
                    <td>
                        <%= prj.getProyect(w.getProject_id()).getName()%> //proyecto en el que está el empleaod 
                        <%= prj.getProyect(w.getProject_id()).getDescription()%>
                    </td>
                    <td><%= w.getIn_pro_from()%></td>//Fecha de inicio
                    <td><%= w.getIn_pro_to()%></td>//Fecha de finalización
                    <td>$<%= w.getCost()%></td>//Costo
                    <td><a href="javascript:myLoad('<%= w.getId()%>','<%= w.getProject_id()%>',
                           '<%= w.getEmployee_id()%>','<%= w.getIn_pro_from()%>','<%= w.getIn_pro_to()%>',
                           <%= w.getCost()%>,'<%= prj.getProyect(w.getProject_id()).getStarted_date()%>',
                           '<%= prj.getProyect(w.getProject_id()).getFinish_date()%>',
                           <%= emp.getEmp(w.getEmployee_id()).getSalary()%>)">Select</a></td>
                </tr>
                <%
                    }
                %>
            </table>
            <br>
            <p>go back to <a href="index.jsp">index</a></p>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
    </body>
</html>

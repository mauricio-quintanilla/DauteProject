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
         <!-- JQuery -->
        <script type="text/javascript" src="jquery.js"></script>
        <!-- SweetAlert -->
        <script type="text/javascript" src="js/sweetalert2.all.min.js"></script>
        
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

   

        function myLoad(id, project, employee, from, to, cost, salario) {
            $("#txtId").val(id);
            $("#slctProId").val(project);
            $("#slctEmpId").val(employee);
            $("#datFrom").val(from);
            $("#datTo").val(to);
            $("#numCost").val(cost);
            $("#numCost").attr('min',salario);//cuando elegimos un empleado su salario en el proyecto 
            //debe ser mayor a el salario de la empresa por eso damos el valor de salario como min attribute
            
             $('#btnUpdate').attr('disabled',false);
                $('#btnDelete').attr('disabled',false);
                $('#btnCreate').attr('disabled',true); 
        }
        
        function clean(){
                $('#btnCreate').attr('disabled',false);
                $('#btnUpdate').attr('disabled',true);
                $('#btnDelete').attr('disabled',true);
            }



    </script>
</head>
<body>
    <header>
            <script>
                $(document).ready(function () {

                    //update question
                    $('#btnUpdate').click(function () {
                        swal.fire({
                            type: "question",
                            title: "¿Desea Modficar el registro?",
                            text: "La modificación será irreversible",
                            showCancelButton: true,
                            cancelButtonColor: "red",
                            ShowConfirmButton: true,
                            confirmButtonColor: '#5cb85c',
                            confirmButtonText: "Sí, Modificar"
                        }).then((result) => {
                            if (result.value) {
                                $('#question').append("<input type='hidden' name='btnUpdate'>");
                                $('#frmMain').submit();
                            }
                        });

                    });

                    $('#btnDelete').click(function () {
                        swal.fire({
                            type: "question",
                            title: "¿Desea eliminar registro?",
                            text: "No se prodrá recuperar el registro",
                            showCancelButton: true,
                            cancelButtonColor: "red",
                            ShowConfirmButton: true,
                            confirmButtonColor: '#5cb85c',
                            confirmButtonText: "Sí, eliminar"
                        }).then((result) => {
                            if (result.value) {
                                $('#question').append("<input type='hidden' name='btnDelete'>");
                                $('#frmMain').submit();
                            }
                        });
                    });
                });

            </script>
            <%
                if (request.getSession().getAttribute("msj") != null
                        && request.getSession().getAttribute("conta").equals(1)) {
            %>
            <script type="text/javascript">

                Swal.fire(
                        'Department',
                        '<%= request.getSession().getAttribute("msj")%>',
                        '<%= request.getSession().getAttribute("type")%>'
                        );

            </script>
            <%
                    request.getSession().setAttribute("conta", 2);
                }
            %>
        </header>
<center><h2>Personal de <%= session.getAttribute("name_attr")%></h2></center>
<div class="container">
    <form id="frmMain" action="workingDetalleController" method="POST">
        <div id="question"></div>
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

                <label>Montly Cost</label>
                <input type="number" name="numCost" id="numCost" min='0.01' step="0.01" class='form-control' required/>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <label>en projecto desde</label>
                <input type="date" name="datFrom" id="datFrom" class='form-control' 
                       value="<%= prj.getProyect((Integer) session.getAttribute("id_attr")).getStarted_date()%>" 
                       min='<%= prj.getProyect((Integer) session.getAttribute("id_attr")).getStarted_date()%>' 
                       max='<%= prj.getProyect((Integer) session.getAttribute("id_attr")).getFinish_date()%>' required/>
            </div>
            <div class="col-md-6">
                <label>en projecto hasta <%= prj.getProyect((Integer) session.getAttribute("id_attr")).getFinish_date()%></label>
                <input type="date" name="datTo" id="datTo" 
                       value="<%= prj.getProyect((Integer) session.getAttribute("id_attr")).getFinish_date()%>" 
                       class='form-control' 
                       min='<%= prj.getProyect((Integer) session.getAttribute("id_attr")).getStarted_date()%>' 
                       max='<%= prj.getProyect((Integer) session.getAttribute("id_attr")).getFinish_date()%>' 
                       required/>
            </div>
        </div>






        <br>
        <input type="reset" onclick="clean();" name="btnNew" value="Add/Clear" class="btn btn-outline-info"/>
        <input type="submit" name="btnCreate" disabled="disabled" id="btnCreate" value="Create" class="btn btn-outline-success"/>
        <input type="button" name="btnUpdate" disabled="disabled" id="btnUpdate" value="Update" class="btn btn-outline-warning"/>
        <input type="button" name="btnDelete" disabled="disabled" id="btnDelete" value="Delete" class="btn btn-outline-danger"/>
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
                   <%= w.getCost()%>,<%= emp.getEmp(w.getId()).getSalary()%>)">Select</a>
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
    <p>go back to <a href="proyectAdd.jsp">the <%= session.getAttribute("name_attr")%> Menú</a></p>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
</body>
</html>
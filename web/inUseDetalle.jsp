<%-- 
    Document   : inUseDetalle
    Created on : 07-nov-2020, 22:24:56
    Author     : ismael
--%>

<%@page import="com.model.Working"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.model.Equipment"%>
<%@page import="com.model.Project"%>
<%@page import="com.model.InUse"%>
<%@page session="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <script type="text/javascript" src="jquery.js"></script>
        <!-- SweetAlert -->
        <script type="text/javascript" src="js/sweetalert2.all.min.js"></script>
        <%
            DecimalFormat df = new DecimalFormat("##.##");
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
        InUse inu = new InUse();
        Project prj = new Project();
        Equipment equ = new Equipment();
        Working wrk = new Working();
        int idCustom = 0;

    %>
    <title><%= session.getAttribute("name_attr")%></title>
    <script type="text/javascript" src="jquery.js"></script>

    <script>
        function myLoad(id, equi, proj, df, dt, eqQ, cst, stock) {
            var textSelected = document.getElementById("slctEqId");
            var str = textSelected.options[textSelected.selectedIndex].text;
            var maxi = str.match(/\(([^)]+)\)/)[1];
            $("#numEqQu").attr('max', stock);
            $("#txtId").val(id);
            $("#slctEqId").val(equi);
            $("#slctProId").val(proj);
            $("#datFrom").val(df);
            $("#datTo").val(dt);
            $("#numEqQu").val(eqQ);
            $("#numCost").val(cst);
            $("#vliStock").val(eqQ);
            $('#btnUpdate').attr('disabled', false);
            $('#btnDelete').attr('disabled', false);
            $('#btnCreate').attr('disabled', true);
        }
        
        function getMInMax(){
            var textSelected = document.getElementById("slctEqId");
            var str = textSelected.options[textSelected.selectedIndex].text;
            var patt = /\((\d)\)/;
            var maxi = str.match(/\(([^)]+)\)/)[1];
            $("#numEqQu").attr('max', maxi);
            $("#numEqQu").val(1);
        }

        function clean() {
            $('#btnCreate').attr('disabled', false);
            $('#btnUpdate').attr('disabled', true);
            $('#btnDelete').attr('disabled', true);
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
            if ((request.getSession().getAttribute("msj") != null)
                    && (request.getSession().getAttribute("conta").equals(1))) {
        %>
        <script type="text/javascript">

            Swal.fire(
                    'Project',
                    '<%= request.getSession().getAttribute("msj")%>',
                    '<%= request.getSession().getAttribute("type")%>'
                    );

        </script>
        <%
                request.getSession().setAttribute("conta", 2);
            }
        %>
    </header>
<center><h2><%= session.getAttribute("name_attr")%> Equipment in use CRUD</h2></center>
<div class="container">
    <form id="frmMain" action="inUseDetController" method="POST">
        <div id="question"></div>
        <input type="hidden" name="slctProId" id="slctProId" value="<%= (Integer) session.getAttribute("id_attr")%>" class='form-control'>
        <input type="hidden" name="vliStock" id="vliStock">
        <div class='row'>
            <input type="hidden" name="txtId" id="txtId" class='form-control' value="0"/>
            <div class='col-md-6'>
                <label>Equipment</label>
                <select name="slctEqId" id="slctEqId" required="required" class='form-control' onchange="getMInMax()">
                    <%
                        List<Equipment> lst = equ.showEqu();
                        for (Equipment e : lst) {
                            int inv = e.getInventory();
                            int quant = inu.getQuantInPro(e.getId(),(Integer) session.getAttribute("id_attr")).getEquipment_quantity();
                            int stockTrue = inv - quant;
                    %>
                    <option value="<%= e.getId()%>"><%= e.getName()%> <%= e.getModel()%>
                        En Stock (<%= stockTrue%>)</option>
                    <%
                        }
                    %>
                </select>
            </div>
                
        </div>
        <div class='row'>
            <div class='col-md-6'>
                <label>en projecto desde</label>
                <input type="date" name="datFrom" id="datFrom" class='form-control' 
                       value="<%= prj.getProyect((Integer) session.getAttribute("id_attr")).getStarted_date()%>"
                       min='<%= prj.getProyect((Integer) session.getAttribute("id_attr")).getStarted_date()%>' 
                       max='<%= prj.getProyect((Integer) session.getAttribute("id_attr")).getFinish_date()%>' 
                       required/>
            </div>
            <div class='col-md-6'>
                <label>en projecto hasta</label>
                <input type="date" name="datTo" id="datTo" class='form-control'
                       value="<%= prj.getProyect((Integer) session.getAttribute("id_attr")).getFinish_date()%>"
                       min='<%= prj.getProyect((Integer) session.getAttribute("id_attr")).getStarted_date()%>' 
                       max='<%= prj.getProyect((Integer) session.getAttribute("id_attr")).getFinish_date()%>' 
                       required/>
            </div>

        </div>

        <div class='row'>
            <div class='col-md-6'>
                <label>Número de unidades a asignar </label>

                <input type="number" name="numEqQu" id="numEqQu" max="" min="1"
                       step="1" class='form-control' required/>
            </div>
            <div class='col-md-6'>
                <label>Precio Unitario de alquiler</label>
                <input type="number" name="numCost" id="numCost" min="5" step="0.01" class='form-control' required/>
            </div>
        </div>


        <br>
        <input type="reset" name="btnNew" onclick="clean();" value="Add/Clear" class="btn btn-outline-info"/>
        <input type="submit" disabled="disabled" name="btnCreate" id="btnCreate" value="Create" class="btn btn-outline-success"/>
        <input type="button" disabled="disabled" id="btnUpdate" value="Update" class="btn btn-outline-warning"/>
        <input type="button" disabled="disabled" id="btnDelete" value="Delete" class="btn btn-outline-danger"/>
    </form>
    <br>
    <table  class='table table-hover'>
        <tr class="thead-dark">
            <th>maquinaria</th>
            <th>Unidades en proyecto</th>
            <th>Unidades In Stock</th>
            <th>desde</th>
            <th>hasta</th>
            <th>dias en project</th>
            <th>Costo diario (unitario)</th>
            <th>costo en project</th>
            <th>Acción</th>
        </tr>
        <%
            int id;
            id = (Integer) session.getAttribute("id_attr");

            List<InUse> lst3 = inu.showInUsebyPro(id);
            double totalM = 0.0;
            double totalFM = 0.0;
            for (InUse i : lst3) {
                String name = equ.getEqu(i.getEquipment_id()).getName() + " " + equ.getEqu(i.getEquipment_id()).getModel();
        %>
        <tr>
            <td><%= name%></td>
            <td><%= i.getEquipment_quantity()%></td> 
            <td><%= equ.getEqu(i.getEquipment_id()).getInventory()-i.getEquipment_quantity() %></td>
            <td><%= i.getIn_pro_from()%></td>
            <td><%= i.getIn_pro_to()%></td>
            <td><%= i.daysInUse(i.getIn_pro_from(), i.getIn_pro_to())%></td>
            <td>$<%= df.format(i.getCost())%></td>
            <%
                //here we need to calculate total cost per truck daysInUse
                totalM = (i.daysInUse(i.getIn_pro_from(), i.getIn_pro_to())) * (i.getCost() * i.getEquipment_quantity());
                totalFM = totalFM + totalM;

            %>
            <td>$<%= df.format(totalM)%></td>
            <td>
                <a><button onclick="myLoad(<%= i.getId()%>,<%= i.getEquipment_id()%>,<%= i.getProject_id()%>, 
                   '<%= i.getIn_pro_from()%>', '<%= i.getIn_pro_to()%>', <%= i.getEquipment_quantity()%>, 
          <%= i.getCost()%>, <%= equ.getEqu(i.getEquipment_id()).getInventory()-i.getEquipment_quantity() %>)">Select</button></a></td>
            </td>
            <%
                }
            %>

        </tr>
        <tr>
            <th colspan="8">Total</th>
            <th>$<%= df.format(totalFM)%></th>

        </tr>
    </table>
    <br>
    <p>go back to <a href="index.jsp">index</a></p>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
</body>
</html>

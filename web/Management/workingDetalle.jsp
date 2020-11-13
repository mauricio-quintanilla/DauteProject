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
<%
    DecimalFormat df = new DecimalFormat("##.00");
    HttpSession sesion = request.getSession();
    String rol;
    if (sesion.getAttribute("rolName") == null) {
        response.sendRedirect("loginController?nosession=y");
    }
%>
<!doctype html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Recurso Humano Proyecto - CONSTRU SV</title>
        <!-- Icon -->
        <link rel="icon" href="../imgs/logos/Logo.png" type="image/png">
        <!-- Tailwind -->
        <link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet">
        <!-- CSS -->
        <link rel="stylesheet" href="../css/style.css">
        <!-- JQuery -->
        <script type="text/javascript" src="../jquery.js"></script>

        <!-- SweetAlert -->
        <script type="text/javascript" src="../js/sweetalert2.all.min.js"></script>

        <script>
        function myLoad(id, project, employee, from, to, cost, salario) {
            $("#divAdd").hide();
            $("#divUpdDel").show();
            $("#txtId").val(id);
            $("#slctProId").val(project);
            $("#slctEmpId2").val(employee);
            $("#datFrom").val(from);
            $("#datTo").val(to);
            $("#numCost").val(cost);
            $("#numCost").attr('min',salario);
            $("#divAdd").hide();
            $("#divUpdDel").show();
            $('#btnUpdate').attr('disabled',false);
            $('#btnDelete').attr('disabled',false);
            $('#btnCreate').attr('disabled',true); 
        }
        
        function clean(){
                $("#divAdd").show();
                $("#divUpdDel").hide();
                $('#btnCreate').attr('disabled',false);
                $('#btnUpdate').attr('disabled',true);
                $('#btnDelete').attr('disabled',true);
            }
    </script>
</head>
<%
    Working wop = new Working();
    Project prj = new Project();
    Employees emp = new Employees();
    Position pos = new Position();

%>
<body class="bg-black">
    <header>
            <script>
                $(document).ready(function () {
                    $("#divAdd").show();
                    $("#divUpdDel").hide();
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

                    
                $('#btnLogout').click(function () {
                    swal.fire({
                        type: "warning",
                        title: "¿En realidad desea cerrar sesión?",

                        showCancelButton: true,
                        cancelButtonColor: "red",
                        ShowConfirmButton: true,
                        confirmButtonColor: '#5cb85c',
                        confirmButtonText: "Cerrar Sesión",
                        cancelButtonText: "Calcelar"
                    }).then((result) => {
                        if (result.value) {
                            $('#log').append("<a id='home-link' href='../loginController?logout=y'></a>");
                            document.getElementById("home-link").click();

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
                        'Recurso Humano',
                        '<%= request.getSession().getAttribute("msj")%>',
                        '<%= request.getSession().getAttribute("type")%>'
                        );

            </script>
            <%
                    request.getSession().setAttribute("conta", 2);
                }
            %>
        </header>

        <div id="opciones" class="hidden p-4 bg-gray2 border-b-2 border-black text-white">
            <div class="flex items-center justify-center w-ful flex-wrap">
                <div class="flex w-full md:w-1/4 lg:w-1/5 my-1 md:mr-4">
                    <div class="border-2 border-white divide-y divide-gray-400 rounded-lg w-full p-2">
                        <h1 class="font-bold text-lg text-center">Gestionar:</h1>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="project.jsp">Gestionar Proyectos</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="users.jsp">Gestionar Usuarios</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="client.jsp">Gestionar Clientes</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="equipment.jsp">Inventario Equipo</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="employees.jsp">Gestionar Empleados</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="department.jsp">Gestionar Departamentos</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="position.jsp">Gestionar Posiciones</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="reptest.jsp">Gestionar Reportes</a></div>
                    </div>
                </div>
            </div>
            <div class="flex items-center justify-center mt-4">
                <!-- <a href="loginController?logout=y" class="bg-blue-500 hover:bg-blue-700 font-bold text-xs md:text-sm text-white p-2 rounded-lg">Cerrar Sesión</a><br> -->
                <button id="btnLogout" class="bg-blue-500 hover:bg-blue-700 font-bold text-xs md:text-sm text-white p-2 rounded-lg">Cerrar Sesión</button><br>
            </div>
        </div> 
        <!--  -->
    
    
        <div class="flex bg-gray w-full px-4 md:px-16">
            <div class="flex w-8/12 py-2">
                <div class="flex items-center justify-center mr-2 w-10 p-1 rounded bg-white">
                    <!-- <img src='imgs/<%= session.getAttribute("profPic")%>' height="40px" width="40px" class="rounded">  -->
                    <img src='../imgs/logos/Logo-Fondo.jpg' class="object-contain"> 
                </div>
                <div class="flex items-center">
                    <label class="font-bold text-white text-xl"><%= session.getAttribute("usrOnSess")%> | <%= session.getAttribute("rolName")%></label>
                </div>
            </div>
            <div class="flex justify-end w-4/12 py-2">
                <div class="flex items-center justify-center">
                    <button class="text-white p-1 border-2 boder-white rounded-lg hover:bg-white hover:text-gray-800 focus:outline-none" onclick="menu()" id="menu">Menú</button>
                </div>
            </div>
        </div>
    
        <div style="visibility: hidden;" id="log"></div>
    
        <!-- ---------------------------------------------------------------------- -->

        <div class="text-white flex justify-center mt-4">
            <h1 class="text-white text-4xl font-bold text-center">Gestión Recurso Humano en Proyecto</h1>
        </div>
        <div class="flex justify-center">
            <a href="proyectAdd.jsp" class="text-center font-bold text-lg text-blue-500 hover:underline">← Regresar</a>
        </div>
        <div class="text-white flex justify-center mt-4">
            <h1 class="text-white text-xl font-bold text-center">Proyecto: <%= session.getAttribute("name_attr")%></h1>
        </div>

<div class="text-white flex justify-center w-full md:w-auto mt-4">
    <form id="frmMain" action="../workingDetalleController" method="POST">
        <div id="question"></div>
        <input type="hidden" name="txtId" id="txtId" value="0"/>
        <input type="hidden" name="slctProId" id="slctProId" value="<%= (Integer) session.getAttribute("id_attr")%>">
        
            <div id="divAdd">
                <label>Empleado: </label><br>
                <select name="slctEmpId" id="slctEmpId" class="text-black font-bold text-lg p-2 rounded">
                    <%
                       String ini=prj.getProyect((Integer) session.getAttribute("id_attr")).getStarted_date(); 
                       String fin=prj.getProyect((Integer) session.getAttribute("id_attr")).getFinish_date();
                        List<Employees> lst = emp.showAvailaByDate(ini, fin);
                        for (Employees e : lst) {
                    %>
                    <option value="<%= e.getId()%>"><%= e.getFirst_name()%>
                        <%= e.getLast_name()%> (<%= pos.getPos(e.getPosition_id()).getName()%>)</option>
                        <%
                            }
                        %>
                </select><br>
            </div>
            <div id="divUpdDel">
                <label>Empleados</label><br>
                <select name="slctEmpId2" id="slctEmpId2" class="text-black font-bold text-lg p-2 rounded">
                    <%
                        List<Employees> lst2 = emp.showEmp();
                        for (Employees e : lst2) {
                    %>
                    <option value="<%= e.getId()%>"><%= e.getFirst_name()%>
                        <%= e.getLast_name()%> (<%= pos.getPos(e.getPosition_id()).getName()%>)</option>
                        <%
                            }
                        %>
                </select><br>
            </div>
            

                <label>Costo Diario</label><br>
                <input type="number" name="numCost" id="numCost" min='0.01' step="0.01" class="text-black font-bold text-lg p-2 rounded" required/><br>
        

        
                <label>En Proyecto desde</label><br>
                <input type="date" name="datFrom" id="datFrom" class="text-black font-bold text-lg p-2 rounded" 
                       value="<%= prj.getProyect((Integer) session.getAttribute("id_attr")).getStarted_date()%>" 
                       min='<%= prj.getProyect((Integer) session.getAttribute("id_attr")).getStarted_date()%>' 
                       max='<%= prj.getProyect((Integer) session.getAttribute("id_attr")).getFinish_date()%>' required/> <br>

                <label>En Proyecto hasta <%= prj.getProyect((Integer) session.getAttribute("id_attr")).getFinish_date()%></label> <br>
                <input type="date" name="datTo" id="datTo" 
                       value="<%= prj.getProyect((Integer) session.getAttribute("id_attr")).getFinish_date()%>" 
                       class="text-black font-bold text-lg p-2 rounded" 
                       min='<%= prj.getProyect((Integer) session.getAttribute("id_attr")).getStarted_date()%>' 
                       max='<%= prj.getProyect((Integer) session.getAttribute("id_attr")).getFinish_date()%>' 
                       required/>

        <div class="mt-8">
            <input type="reset" name="btnNew" value="Limpiar" onclick="clean();" class="text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
            <input type="submit" name="btnCreate" id="btnCreate" disabled="disabled" value="Crear" class="text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
            <input type="button" id="btnUpdate" value="Actualizar" disabled="disabled" class="text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
            <input type="button" id="btnDelete" value="Eliminar" disabled="disabled"  class="text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
        </div>
    </form>
</div>

    <br>

    <div class="text-white md:flex md:justify-center w-full md:w-auto mt-4 px-4 overflow-x-auto">
    <table>
        <thead>
            <th class="border-2 border-white border-dashed p-2">Nombre</th>
            <th class="border-2 border-white border-dashed p-2">Cargo</th>
            <th class="border-2 border-white border-dashed p-2">Desde</th>
            <th class="border-2 border-white border-dashed p-2">Hasta</th>
            <th class="border-2 border-white border-dashed p-2">Días en Proyecto</th>
            <th class="border-2 border-white border-dashed p-2">Costo Diario</th>
            <th class="border-2 border-white border-dashed p-2">Costo Total</th>
            <th class="border-2 border-white border-dashed p-2">Seleccionar</th>
        </thead>
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
            <td class="border-2 border-white border-dashed p-2"><%= name%></td>
            <td class="border-2 border-white border-dashed p-2"><%= pos.getPos((emp.getEmp(w.getEmployee_id()).getPosition_id())).getName()%></td>
            <td class="border-2 border-white border-dashed p-2"><%= w.getIn_pro_from()%></td>
            <td class="border-2 border-white border-dashed p-2"><%= w.getIn_pro_to()%></td>
            <td class="border-2 border-white border-dashed p-2"><%= w.daysIn(w.getIn_pro_from(), w.getIn_pro_to())%></td>
            <td class="border-2 border-white border-dashed p-2">$<%= df.format(w.getCost())%></td>
            <%
                total = (w.daysIn(w.getIn_pro_from(), w.getIn_pro_to())) * (w.getCost());
                totalF = totalF + total;


            %>
            <td class="border-2 border-white border-dashed p-2">$<%= df.format(total)%></td>
            <td class="border-2 border-white border-dashed p-2"><a href="javascript:myLoad(<%= w.getId()%>,<%= w.getProject_id()%>,
                   <%= w.getEmployee_id()%>,'<%= w.getIn_pro_from()%>','<%= w.getIn_pro_to()%>',
                   <%= w.getCost()%>,<%= emp.getEmp(w.getId()).getSalary()%>)"
                   class="font-bold text-blue-500 hover:underline">Seleccionar</a>
            </td>
            <%
                }
            %>

        </tr>
        <tr>
            <th colspan="6" class="border-2 border-white border-dashed p-2 text-right">Total</th>
            <th class="border-2 border-white border-dashed p-2">$<%= df.format(totalF)%></th>

        </tr>
    </table>
</div>
    <br>

    <!-- Navbar -->
    <script src="../js/navbar.js"></script>

</body>
</html>
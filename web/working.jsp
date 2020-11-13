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
<%
    HttpSession sesion = request.getSession();
    response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader("Expires", 0);
    if (sesion.getAttribute("rolName") == null) {
        response.sendRedirect("loginController?nosession=y");
    }
%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Recurso Humano - CONSTRU SV</title>
        <!-- Icon -->
        <link rel="icon" href="imgs/logos/Logo.png" type="image/png">
        <!-- Tailwind -->
        <link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet">
        <!-- CSS -->
        <link rel="stylesheet" href="css/style.css">
        <!-- JQuery -->
        <script type="text/javascript" src="jquery.js"></script>
        <!-- SweetAlert -->
        <script type="text/javascript" src="js/sweetalert2.all.min.js"></script>

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

                $('#btnUpdate').attr('disabled',false);
                $('#btnDelete').attr('disabled',false);
                $('#btnCreate').attr('disabled',true); 
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
            function clean(){
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
            String aa = "";
            String bb = "";
            ZoneId zonedId = ZoneId.of( "America/El_Salvador" );
            LocalDate today = LocalDate.now( zonedId );
        %>
    <body class="bg-black">
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
                        'Recurso Humano',
                        '<%= request.getSession().getAttribute("msj")%>',
                        'success'
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
                        <h1 class="font-bold text-lg text-center">Proyectos:</h1>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="project.jsp">Gestionar Proyectos</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="projectview.jsp">Detalle Proyectos</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="working.jsp">Recurso humano en proyecto</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="inuse.jsp">Equipo en uso</a></div>
                    </div>
                </div>
                <div class="flex w-full md:w-1/4 lg:w-1/5 my-1">
                    <div class="border-2 border-white divide-y divide-gray-400 rounded-lg w-full p-2">
                        <h1 class="font-bold text-lg text-center">Usuarios:</h1>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="users.jsp">Gestionar Usuarios</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="client.jsp">Gestionar Clientes</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="logs.jsp">Logs Usuarios</a></div>
                    </div>
                </div>
                <div class="flex w-full md:w-1/4 lg:w-1/5 my-1 md:ml-4">
                    <div class="border-2 border-white divide-y divide-gray-400 rounded-lg w-full p-2">
                        <h1 class="font-bold text-lg text-center">Empresa:</h1>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="equipment.jsp">Inventario Equipo</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="employees.jsp">Gestionar Empleados</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="department.jsp">Gestionar Departamentos</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-lg text-blue-500 hover:underline" href="position.jsp">Gestionar Posiciones</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-lg text-blue-500 hover:underline" href="reptest.jsp">Gestionar Reportes</a></div>
                    </div>
                </div>
            </div>
            <div class="flex items-center justify-center mt-4">
                <a href="loginController?logout=y" class="bg-blue-500 hover:bg-blue-700 font-bold text-xs md:text-sm text-white p-2 rounded-lg">Cerrar Sesión</a><br>
            </div>
        </div> 
        <!--  -->


        <div class="flex bg-gray w-full px-4 md:px-16">
            <div class="flex w-8/12 py-2">
                <div class="flex items-center justify-center mr-2 w-10 p-1 rounded bg-white">
                    <!-- <img src='imgs/<%= session.getAttribute("profPic")%>' height="40px" width="40px" class="rounded">  -->
                    <img src='imgs/logos/Logo-Fondo.jpg' class="object-contain"> 
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

        <!-- ---------------------------------------------------------------------- -->

        <div class="text-white flex justify-center mt-4">
            <h1 class="text-white text-4xl font-bold text-center">Gestión Recurso Humano en Proyectos</h1>
        </div>
        <div class="flex justify-center">
            <a href="index.jsp" class="text-center font-bold text-lg text-blue-500 hover:underline">← Regresar</a>
        </div>

        
        <div class="text-white flex justify-center w-full md:w-auto mt-4">
            <form id="frmMain" action="workingController" method="POST">
                <div id="question"></div>
                    <input type="hidden" name="txtId" id="txtId" value="0"/><br>
                    <label>Empleado:</label><br>
                    <select name="slctEmpId" id="slctEmpId" class="text-black font-bold text-lg p-2 rounded">
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
                                <%= e.getLast_name()%> (<%= pos.getPos(e.getPosition_id()).getName()%>)</option>
                        <%
                            }
                        %>
                    </select><br>
                    <label>Añadir a Proyecto: </label><br>
                    <select name="slctProId" id="slctProId" class="text-black font-bold text-lg p-2 rounded">
                        <%
                            List<Project> lst2 = prj.showPrj();
                            for (Project p : lst2) {
                        %>
                            <option value="<%= p.getId()%>" ><%= p.getName()%> <%= p.getDescription()%></option>
                        <%
                            }
                        %>
                    </select><br>
                    <label>Fecha de Inicio en Proyecto:</label><br>
                    <input type="date" name="datFrom" id="datFrom" class="text-black font-bold text-lg p-2 rounded" min='' max='' required/><br>
                    <label>Fecha de Finalización en Proyecto: </label><br>
                    <input type="date" name="datTo" id="datTo" class="text-black font-bold text-lg p-2 rounded" min='' max='' required/><br>
                    <label>Costo: </label><br>
                    <input type="number" name="numCost" id="numCost" min='0.01' step="0.01" class="text-black font-bold text-lg p-2 rounded" required/>
                    
                    <div class="mt-8">
                        <input type="button" onclick="checkDates()" />

                        <input type="reset" name="btnNew" value="Limpiar" onclick="clean();" class="text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                        <input type="submit" name="btnCreate" id="btnCreate" disabled="disabled" value="Crear" class="text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                        <input type="button" id="btnUpdate" value="Actualizar" disabled="disabled" class="text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                        <input type="button" id="btnDelete" value="Eliminar" disabled="disabled"  class="text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                    </div>
                
            </form>
        </div>

        <div class="text-white md:flex md:justify-center w-full md:w-auto mt-4 px-4 overflow-x-auto">
            <table>
                <thead>
                    <th class="border-2 border-white border-dashed p-2">ID</th>
                    <th class="border-2 border-white border-dashed p-2">Empleado</th>
                    <th class="border-2 border-white border-dashed p-2">Trabajando En:</th>
                    <th class="border-2 border-white border-dashed p-2">En Proyecto desde</th>
                    <th class="border-2 border-white border-dashed p-2">En Proyecto hasta</th>
                    <th class="border-2 border-white border-dashed p-2">Costo</th>
                    <th class="border-2 border-white border-dashed p-2">Seleccionar</th>
                </thead>
                <%
                    List<Working> lst3 = wop.showWorking();
                    for (Working w : lst3) {
                        String name=emp.getEmp(w.getEmployee_id()).getFirst_name()
                                +" "+emp.getEmp(w.getEmployee_id()).getLast_name()
                                +"("+pos.getPos((emp.getEmp(w.getEmployee_id()).getPosition_id())).getName()+")";
                %>
                <tr>
                    <td class="border-2 border-white border-dashed p-2"><%= w.getId()%></td>
                    <td class="border-2 border-white border-dashed p-2"><%= name%></td>
                    <td class="border-2 border-white border-dashed p-2">
                        <%= prj.getProyect(w.getProject_id()).getName()%> 
                        <%= prj.getProyect(w.getProject_id()).getDescription()%>
                    </td>
                    <td class="border-2 border-white border-dashed p-2"><%= w.getIn_pro_from()%></td>
                    <td class="border-2 border-white border-dashed p-2"><%= w.getIn_pro_to()%></td>
                    <td class="border-2 border-white border-dashed p-2">$<%= w.getCost()%></td>
                    <td class="border-2 border-white border-dashed p-2"><a href="javascript:myLoad('<%= w.getId()%>','<%= w.getProject_id()%>',
                           '<%= w.getEmployee_id()%>','<%= w.getIn_pro_from()%>','<%= w.getIn_pro_to()%>',
                           <%= w.getCost()%>,'<%= prj.getProyect(w.getProject_id()).getStarted_date()%>',
                           '<%= prj.getProyect(w.getProject_id()).getFinish_date()%>',
                           <%= emp.getEmp(w.getEmployee_id()).getSalary()%>)"
                           class="font-bold text-blue-500 hover:underline">Seleccionar</a></td>
                </tr>
                <%
                    }
                %>
            </table>
        </div>
            <br>
        
    <!-- Navbar -->
    <script src="js/navbar.js"></script>
    </body>
</html>

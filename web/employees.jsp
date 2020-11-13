<%-- 
    Document   : employees
    Created on : Oct 21, 2020, 10:54:02 PM
    Author     : demon
--%>

<%@page import="java.util.List"%>
<%@page import="com.model.Employees"%>
<%@page import="com.model.Position"%>
<%@page import="com.model.Users"%>
<%@page session="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession();
    String rol;
    if (sesion.getAttribute("rolName") == null) {
        response.sendRedirect("loginController?nosession=y");
    }
%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Departamentos - CONSTRU SV</title>
        <!-- Icon -->
        <link rel="icon" href="imgs/logos/Logo.png" type="image/png">
        <!-- Tailwind -->
        <link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet">
        <!-- CSS -->
        <link rel="stylesheet" href="css/style.css">
        <!-- JQuery -->
        <script type="text/javascript" src="jquery.js"></script>

        <!-- SWEET ALERT -->
        <script type="text/javascript" src="js/sweetalert2.all.min.js"></script>


        <script>
            function myLoad(id, first, last, dob, address, phone, dui, nit, salary, position, user, imga) {
                $("#txtId").val(id);
                $("#txtName").val(first);
                $("#txtLast").val(last);
                $("#dapDob").val(dob);
                $("#txtAddress").val(address);
                $("#txtPhone").val(phone);
                $("#txtDui").val(dui);
                $("#txtNit").val(nit);
                $("#numSalary").val(salary);
                $("#slctPos").val(position);
                $("#slctUser").val(user);
                $("#fileImgBU").val(imga);
            
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
<%
    Position pos = new Position();
    Employees emp = new Employees();
    Users usr = new Users();
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
                            $('#frmMain').attr('action', 'employeesController?btnUpdate=y');
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
                            $('#frmMain').attr('action', 'employeesController?btnDelete=y');
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
                    'Empleados',
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
        <h1 class="text-white text-4xl font-bold text-center">Gestión Empleados</h1>
    </div>
    <div class="flex justify-center">
        <a href="index.jsp" class="text-center font-bold text-lg text-blue-500 hover:underline">← Regresar</a>
    </div>
    <div class="text-white flex justify-center w-full md:w-auto mt-4">
            <form id="frmMain" method="POST" enctype="multipart/form-data">
                <div id="question"></div>
                <input type="hidden" name="txtId" id="txtId" value="0"/>

                <div class="flex flex-wrap w-full">
                    <div class="w-full md:w-1/2">
                        <label>Nombre: </label><br>
                        <input type="text" name="txtName" id="txtName" class='text-black font-bold text-lg p-2 rounded w-full' required/><br>
                        <label>Apellido: </label><br>
                        <input type="text" name="txtLast" id="txtLast" class='text-black font-bold text-lg p-2 rounded w-full' required/><br>
                        <label>Fecha de Nacimiento: </label><br>
                        <input type="date" name="dapDob" id="dapDob" class='text-black font-bold text-lg p-2 rounded w-full' min='1980-01-01' max='2002-12-31' required/><br>
                        <label>Ubicación: </label><br>
                        <textarea class="text-black font-bold text-lg p-2 rounded w-full" name="txtAddress" id="txtAddress" placeholder="Address" required rows="3"></textarea><br>
                        <label>Teléfono: </label><br>
                        <input type="text" name="txtPhone" id="txtPhone" pattern="[0-9]{4}-[0-9]{4}" placeholder="0000-0000"
                               class='text-black font-bold text-lg p-2 rounded w-full' required/><br>
                        <label>DUI: </label><br>
                        <input type="text" name="txtDui" id="txtDui" pattern="[0-9]{8}-[0-9]{1}" placeholder="00000000-0"
                               class='text-black font-bold text-lg p-2 rounded w-full' required/><br>
                    </div>
                    <div class="w-full md:w-1/2 md:pl-4">
                        <label>NIT: </label><br>
                        <input type="text" name="txtNit" id="txtNit" pattern="[0-9]{4}-[0-9]{6}-[0-9]{3}-[0-9]{1}" placeholder="0000-000000-000-0"
                               class='text-black font-bold text-lg p-2 rounded w-full' required/><br>
                        <label>Salario: </label><br>
                        <input type="number" name="numSalary" id="numSalary" min='300' step="1" class='text-black font-bold text-lg p-2 rounded w-full' required/><br>
                        <label>Posición: </label><br>
                        <select name="slctPos" id="slctPos" class='text-black font-bold text-lg p-2 rounded w-full'>
                            <%
                                List<Position> lst = pos.showPos();
                                for (Position p : lst) {
                            %>
                            <option value="<%= p.getId()%>"><%= p.getName()%></option>
                            <%
                                }
                            %>
                        </select><br>
                        <label>Usuario: </label><br>
                        <select name="slctUser" id="slctUser" class='text-black font-bold text-lg p-2 rounded w-full'>
                            <%
                                List<Users> lst2 = usr.showUsers();
                                for (Users u : lst2) {
                            %>
                            <option value="<%= u.getId()%>"><%= u.getUser_name()%></option>
                            <%
                                }
                            %>
                        </select><br>
                        <label>Foto: </label><br>
                        <input type="file" class="bg-white text-black font-bold text-lg p-2 rounded w-full" name="fileImg" id="fileImg" aria-describedby="inputGroupFileAddon03"><br>
                    </div>
                </div>
                
                    
                    
                    <!-- this input allows us to temporarily store img value in case update is in process-->
                    <input type="hidden" name="fileImgBU" id="fileImgBU" class='form-control' value=""/>

                <div class="mt-8">
                    <div class="md:flex md:justify-center w-full p-2">
                        <input type="reset" name="btnNew" value="Limpiar" onclick="clean();" class="mt-2 md:mt-0 text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                        <input formaction="employeesController?btnCreate=y" disabled="disabled"  type="submit" name="btnCreate" id="btnCreate" value="Crear" class="mt-2 md:mt-0 text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                        <input type="button" name="btnUpdate" id="btnUpdate" disabled="disabled"  value="Actualizar" class="mt-2 md:mt-0 text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                        <input type="button" name="btnDelete" id="btnDelete" disabled="disabled"  value="Eliminar" class="mt-2 md:mt-0 text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                    </div>
                </div>
            </form>
        </div>

        <div class="text-white w-full md:w-auto mt-4 px-4 overflow-x-auto">
            <table>
                <thead>
                    <th class="border-2 border-white border-dashed p-2">Id</th>
                    <th class="border-2 border-white border-dashed p-2">Nombre</th>
                    <th class="border-2 border-white border-dashed p-2">Apellido</th>
                    <th class="border-2 border-white border-dashed p-2">Fecha de Nacimiento</th>
                    <th class="border-2 border-white border-dashed p-2">Dirreción</th>
                    <th class="border-2 border-white border-dashed p-2">Teléfono</th>
                    <th class="border-2 border-white border-dashed p-2">DUI</th>
                    <th class="border-2 border-white border-dashed p-2">NIT</th>
                    <th class="border-2 border-white border-dashed p-2">Salario</th>
                    <th class="border-2 border-white border-dashed p-2">Posición</th>
                    <th class="border-2 border-white border-dashed p-2">Usuario</th>
                    <th class="border-2 border-white border-dashed p-2">Foto</th>
                    <th class="border-2 border-white border-dashed p-2">Seleccionar</th>
                </thead>
                <tbody>
                <%
                    List<Employees> lst3 = emp.showEmp();
                    for (Employees e : lst3) {
                %>
                <tr>
                    <td class="border-2 border-white border-dashed p-2"><%= e.getId()%></td>
                    <td class="border-2 border-white border-dashed p-2"><%= e.getFirst_name()%></td>
                    <td class="border-2 border-white border-dashed p-2"><%= e.getLast_name()%></td>
                    <td class="border-2 border-white border-dashed p-2"><%= e.getDob()%></td>
                    <td class="border-2 border-white border-dashed p-2"><%= e.getAddress()%></td>
                    <td class="border-2 border-white border-dashed p-2"><%= e.getPhone_number()%></td>
                    <td class="border-2 border-white border-dashed p-2"><%= e.getDui()%></td>
                    <td class="border-2 border-white border-dashed p-2"><%= e.getNit()%></td>
                    <td class="border-2 border-white border-dashed p-2">$<%= e.getSalary()%></td>
                    <td class="border-2 border-white border-dashed p-2"><%= pos.getPos(e.getPosition_id()).getName()%></td>
                    <td class="border-2 border-white border-dashed p-2"><%= usr.getUsers(e.getUser_id()).getUser_name()%></td>
                    <td class="border-2 border-white border-dashed p-2"><img src="imgs/<%= e.getImage()%>" height="75px" width="100px"></td>
                    <td class="border-2 border-white border-dashed p-2">
                        <a href="javascript:myLoad('<%= e.getId()%>','<%= e.getFirst_name()%>','<%= e.getLast_name()%>',
                           '<%= e.getDob()%>','<%= e.getAddress()%>','<%= e.getPhone_number()%>','<%= e.getDui()%>',
                           '<%= e.getNit()%>','<%= e.getSalary()%>','<%= e.getPosition_id()%>','<%= e.getUser_id()%>',
                           '<%= e.getImage()%>')"
                           class="font-bold text-blue-500 hover:underline">Seleccionar</a>
                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
            <br>

        
    <!-- Navbar -->
    <script src="js/navbar.js"></script>
    </body>
</html>
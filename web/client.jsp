<%-- 
    Document   : client
    Created on : Oct 22, 2020, 9:03:34 PM
    Author     : demon
--%>

<%@page import="com.model.Users"%>
<%@page import="java.util.List"%>
<%@page import="com.model.Client"%>
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
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Clientes - CONSTRU SV</title>
        <!-- Icon -->
        <link rel="icon" href="imgs/logos/Logo.png" type="image/png">
        <!-- Tailwind -->
        <link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet">
        <!-- CSS -->
        <link rel="stylesheet" href="css/style.css">
        <!-- JQuery -->
        <script type="text/javascript" src="jquery.js"></script>

        <!-- SWEET ALERT -->
        <script type="text/javascript" src="sweetalert2.all.min.js"></script>
        
        
        <script>
            function myLoad(id, name, email, phone, nit, comName, comAdd, userId) {
                $("#txtId").val(id);
                $("#txtName").val(name);
                $("#txtEmail").val(email);
                $("#txtPhone").val(phone);
                $("#txtNit").val(nit);
                $("#txtComName").val(comName);
                $("#txtComAdd").val(comAdd);
                $("#slctUser").val(userId);
            }
        </script>
    </head>
<%
    Client cli = new Client();
    Users usr = new Users();
%>
    <body class="bg-black">
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
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="role.jsp">Gestionar Roles</a></div>
                    
                    </div>
                </div>
                <div class="flex w-full md:w-1/4 lg:w-1/5 my-1 md:ml-4">
                    <div class="border-2 border-white divide-y divide-gray-400 rounded-lg w-full p-2">
                        <h1 class="font-bold text-lg text-center">Empresa:</h1>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="equipment.jsp">Inventario Equipo</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="employees.jsp">Gestionar Empleados</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="department.jsp">Gestionar Departamentos</a></div>
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
            <h1 class="text-white text-4xl font-bold text-center">Gestión Clientes</h1>
        </div>
        <div class="flex justify-center">
            <a href="index.jsp" class="text-center font-bold text-lg text-blue-500 hover:underline">← Regresar</a>
        </div>
        
        <div class="text-white flex justify-center w-full md:w-auto mt-4">
            <form id="frmMain" action="clientController" method="POST">
                    <input type="hidden" name="txtId" id="txtId" class='text-black font-bold text-lg p-2 rounded w-full' value="0"/>
                    <div class="flex flex-wrap w-full">
                        <div class="w-full md:w-1/2">
                            <label>Nombre: </label><br>
                            <input type="text" name="txtName" id="txtName" class='text-black font-bold text-lg p-2 rounded w-full' required/><br>
                            <label>Correo: </label><br>
                            <input type="email" name="txtEmail" id="txtEmail" class='text-black font-bold text-lg p-2 rounded w-full' required/><br>
                            <label>Número de Teléfono: </label><br>
                            <input type="text" name="txtPhone" id="txtPhone" class='text-black font-bold text-lg p-2 rounded w-full' required/><br>
                            <label>NIT: </label><br>
                            <input type="text" name="txtNit" id="txtNit" class='text-black font-bold text-lg p-2 rounded w-full' required/><br>
                        </div>
                        <div class="w-full md:w-1/2 md:pl-4">
                            <label>Compañía: </label><br>
                            <input type="text" name="txtComName" id="txtComName" class='text-black font-bold text-lg p-2 rounded w-full' required/><br>
                            <label>Dirección Compañía:</label><br>
                            <textarea class='text-black font-bold text-lg p-2 rounded w-full' name="txtComAdd" id="txtComAdd" required rows="3"></textarea><br>
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
                        </div>
                    </div>

                
                <div class="mt-8">
                    <div class="md:flex md:justify-center w-full p-2">
                        <input type="reset" name="btnNew" value="Add/Clear" class="mt-2 md:mt-0 text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                        <input type="submit" name="btnCreate" id="btnCreate" value="Create" class="mt-2 md:mt-0 text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                        <input type="submit" name="btnUpdate" id="btnUpdate" value="Update" class="mt-2 md:mt-0 text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                        <input type="submit" name="btnDelete" id="btnDelete" value="Delete" class="mt-2 md:mt-0 text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                    </div>
                </div>
            </form>
        </div>

        <div class="text-white w-full md:flex md:justify-center md:w-auto mt-4 px-4 overflow-x-auto">
            <table border="1" class=''>
                <thead>
                    <th class="border-2 border-white border-dashed p-2">ID</th>
                    <th class="border-2 border-white border-dashed p-2">Nombre Cliente</th>
                    <th class="border-2 border-white border-dashed p-2">Correo</th>
                    <th class="border-2 border-white border-dashed p-2">Teléfono</th>
                    <th class="border-2 border-white border-dashed p-2">NIT</th>
                    <th class="border-2 border-white border-dashed p-2">Compañía</th>
                    <th class="border-2 border-white border-dashed p-2">Dirección Compañía</th>
                    <th class="border-2 border-white border-dashed p-2">Usuario</th>
                    <th class="border-2 border-white border-dashed p-2">Seleccionar</th>
                </thead>
                <tbody>
                <%
                    List<Client> lst = cli.showClient();
                    for (Client c : lst) {
                %>
                <tr>
                    <td class="border-2 border-white border-dashed p-2"><%= c.getId()%></td>
                    <td class="border-2 border-white border-dashed p-2"><%= c.getName()%></td>
                    <td class="border-2 border-white border-dashed p-2"><%= c.getEmail()%></td>
                    <td class="border-2 border-white border-dashed p-2"><%= c.getPhone_number()%></td>
                    <td class="border-2 border-white border-dashed p-2"><%= c.getNit()%></td>
                    <td class="border-2 border-white border-dashed p-2"><%= c.getCompany_name()%></td>
                    <td class="border-2 border-white border-dashed p-2"><%= c.getCompany_address()%></td>
                    <td class="border-2 border-white border-dashed p-2"><%= usr.getUsers(c.getUser_id()).getUser_name() %></td>
                    <td class="border-2 border-white border-dashed p-2">
                        <a href="javascript:myLoad('<%= c.getId()%>','<%= c.getName()%>','<%= c.getEmail()%>',
                           '<%= c.getPhone_number()%>','<%= c.getNit()%>','<%= c.getCompany_name()%>','<%= c.getCompany_address()%>','<%= c.getUser_id()%>')"
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
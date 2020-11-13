<%-- 
    Document   : logs
    Created on : Nov 13, 2020, 2:22:11 AM
    Author     : luisbonilla
--%>

<%@page import="com.model.Users"%>
<%@page import="com.model.Logs"%>
<%@page import="java.util.List"%>
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
        <title>Logs - CONSTRU SV</title>
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
    </head>
    <%
        Logs log = new Logs();
        Users user = new Users();
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

        <div class="w-full h-screen">
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
        <div class="flex justify-center mt-4">
            <a href="index.jsp" class="text-center font-bold text-lg text-blue-500 hover:underline">← Regresar</a>
        </div>
      
        <div class="text-white flex md:justify-center w-full md:w-auto h-full overflow-y-auto overflow-x-auto mt-4 p-8">

            <table>
                <thead>
                <th class="border-2 border-white border-dashed p-4 text-lg">ID</th>
                <th class="border-2 border-white border-dashed p-4 text-lg">Usuario</th>
                <th class="border-2 border-white border-dashed p-4 text-lg">Action</th>
                <th class="border-2 border-white border-dashed p-4 text-lg">En Tabla</th>
                <th class="border-2 border-white border-dashed p-4 text-lg">Fecha</th>
                <th class="border-2 border-white border-dashed p-4 text-lg">Descripción</th>
                </thead>
                <tbody>
                    <%
                        List<Logs> lst = log.showLogs();
                        for (Logs l : lst) {
                    %>
                    <tr>
                        <td class="border-2 border-white border-dashed p-4 text-center font-bold"><%= l.getId() %></td>
                        <td class="border-2 border-white border-dashed p-4"><%= user.getUsers(l.getUser_id()).getUser_name() %></td>
                        <td class="border-2 border-white border-dashed p-4"><%= l.getAction_id()%></td>
                        <td class="border-2 border-white border-dashed p-4"><%= l.getOn_field()%></td>
                        <td class="border-2 border-white border-dashed p-4"><%= l.getDate()%></td>
                        <td class="border-2 border-white border-dashed p-4"><%= l.getDescription() %></td>
                        
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <br>

        </div>
    </div>
    <!-- Navbar -->
    <script src="js/navbar.js"></script>
</body>
</html>

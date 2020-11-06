<%-- 
    Document   : index
    Created on : Oct 19, 2020, 4:22:14 PM
    Author     : demon
--%>
<%@page import="javax.swing.JOptionPane"%>
<%@page session="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
    HttpSession sesion = request.getSession();
    String rol;
    if (sesion.getAttribute("rolName") == null) {
        response.sendRedirect("loginController?nosession=y");
    }
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Dashboard - CONSTRU SV</title>
    <!-- Icon -->
    <link rel="icon" href="imgs/logos/Logo.png" type="image/png">
    <!-- Tailwind -->
    <link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet">
    <!-- CSS -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="bg-black">
        <div class="flex bg-white w-full">
            <div class="flex w-8/12 px-4 py-2">
                <div class="flex items-center justify-center mr-2">
                    <img src="imgs/<%= session.getAttribute("profPic")%>" height="40px" width="40px"> 
                </div>
                <div>
                    <div class="md:flex">
                        <label class="font-bold">Usuario: </label>
                        <label><%= session.getAttribute("usrOnSess")%></label>
                    </div>
                    <div>
                        <label class="font-bold">Rol: </label><label><%= session.getAttribute("rolName")%></label>
                    </div>
                </div>
            </div>
            <div class="flex justify-end w-4/12 px-4 py-2">
                <div class="flex items-center justify-center">
                    <a href="loginController?logout=y" class="bg-blue-500 hover:bg-blue-700 font-bold text-white p-2 rounded-lg">Cerrar Sesión</a><br>
                </div>
            </div>
        </div>
        <div class="flex items-center justify-center w-full p-4 sm:mt-4 lg:mt-16">
            <div class="flex w-full sm:w-1/2 md:w-1/3 lg:w-1/4">
                <div class="border-4 border-gray-500 divide-y divide-gray-400 bg-white rounded-lg w-full p-4">
                    <h1 class="font-bold text-2xl text-center">Gestionar:</h1>
                    <div class="py-1 text-center"><a class="font-bold text-lg text-blue-500 hover:underline" href="department.jsp">Departamentos</a></div>
                    <div class="py-1 text-center"><a class="font-bold text-lg text-blue-500 hover:underline" href="role.jsp">Roles</a></div>
                    <div class="py-1 text-center"><a class="font-bold text-lg text-blue-500 hover:underline" href="actions.jsp">Acciones</a></div>
                    <div class="py-1 text-center"><a class="font-bold text-lg text-blue-500 hover:underline" href="users.jsp">Usuarios</a></div>
                    <div class="py-1 text-center"><a class="font-bold text-lg text-blue-500 hover:underline" href="employees.jsp">Empleados</a></div>
                    <div class="py-1 text-center"><a class="font-bold text-lg text-blue-500 hover:underline" href="working.jsp">Personas en proyecto</a></div>
                    <div class="py-1 text-center"><a class="font-bold text-lg text-blue-500 hover:underline" href="client.jsp">Clientes</a></div>
                    <div class="py-1 text-center"><a class="font-bold text-lg text-blue-500 hover:underline" href="equipment.jsp">Inventario de equipo</a></div>
                    <div class="py-1 text-center"><a class="font-bold text-lg text-blue-500 hover:underline" href="project.jsp">Proyectos</a></div>
                    <div class="py-1 text-center"><a class="font-bold text-lg text-blue-500 hover:underline" href="inuse.jsp">Equipo en uso</a></div>
                    <div class="py-1 text-center"><a class="font-bold text-lg text-blue-500 hover:underline" href="maptest.jsp">Map Test</a></div>
                    <div class="py-1 text-center"><a class="font-bold text-lg text-blue-500 hover:underline" href="projectview.jsp">ProjectVIew</a></div>
                </div>
            </div>
        </div>
       
</body>
</html>

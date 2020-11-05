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
    <title>Dashboard - CONSTRU SV</title>
    <!-- Icon -->
    <link rel="icon" href="imgs/logos/Logo.png" type="image/png">
    <!-- Tailwind -->
    <link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet">
    <!-- CSS -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="flex w-full md:h-screen">
        <div class="bg-gray-500">
            <a href="loginController?logout=y">Log out</a>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

            <label>Rol: <%= session.getAttribute("rolName")%></label>
            <label>Usuario: <%= session.getAttribute("usrOnSess")%></label>
            <img src="imgs/<%= session.getAttribute("profPic")%>" height="40px" width="40px"> 
        </div>
        <div class="flex items-center justify-center w-full md:h-full">
            <div class="flex w-full md:w-1/4">
                <div class="border border-blue-500 border-8 divide-y divide-gray-400 bg-white rounded-lg w-full">
                    <h1 class="font-bold text-2xl text-center">Gestionar:</h1>
                    <div class="py-1 text-center"><a class="text-blue-500 underline" href="department.jsp">Departamentos</a></div>
                    <div class="py-1 text-center"><a class="text-blue-500 underline" href="role.jsp">Roles</a></div>
                    <div class="py-1 text-center"><a class="text-blue-500 underline" href="actions.jsp">Acciones</a></div>
                    <div class="py-1 text-center"><a class="text-blue-500 underline" href="users.jsp">Usuarios</a></div>
                    <div class="py-1 text-center"><a class="text-blue-500 underline" href="employees.jsp">Empleados</a></div>
                    <div class="py-1 text-center"><a class="text-blue-500 underline" href="working.jsp">Personas en proyecto</a></div>
                    <div class="py-1 text-center"><a class="text-blue-500 underline" href="client.jsp">Clientes</a></div>
                    <div class="py-1 text-center"><a class="text-blue-500 underline" href="equipment.jsp">Inventario de equipo</a></div>
                    <div class="py-1 text-center"><a class="text-blue-500 underline" href="project.jsp">Proyectos</a></div>
                    <div class="py-1 text-center"><a class="text-blue-500 underline" href="inuse.jsp">Equipo en uso</a></div>
                    <div class="py-1 text-center"><a class="text-blue-500 underline" href="maptest.jsp">Map Test</a></div>
                </div>
            </div>
        </div>
    </div>
       
</body>
</html>

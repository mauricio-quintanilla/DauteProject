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
        <!-- JQuery -->
        <script type="text/javascript" src="jquery.js"></script>
        <!-- SweetAlert2 -->
        <script type="text/javascript" src="js/sweetalert2.all.min.js"></script>
        
        <script>
            $(document).ready(function () {

                //update question
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
                            $('#log').append("<a id='home-link' href='loginController?logout=y'></a>");
                            document.getElementById("home-link").click();

                        }
                    });

                });
            });
        </script>
    </head>
    <body class="bg-black">
        <header>
            <%
                HttpSession sesion = request.getSession();
                String rol;
                response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
                response.setHeader("Pragma","no-cache");
                response.setDateHeader("Expires", 0);
                if (sesion.getAttribute("rolName") == null) {
                    response.sendRedirect("loginController?nosession=y");
                }else if(request.getSession().getAttribute("bandera2").equals(1)) {
            %>
            <script type="text/javascript">
                Swal.fire({
                    type: 'success',
                    title: 'Bienvenid@ <%= session.getAttribute("usrOnSess")%>',
                    text: 'Ingresó con éxito a Constru SV',
                    footer: '<a href></a>'
                })
            </script>
            <%
                request.getSession().setAttribute("bandera2", 2);
                 }
            %>

        </header>
        <div style="visibility: hidden;" id="log"></div>

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
                    <button id="btnLogout" class="bg-blue-500 hover:bg-blue-700 font-bold text-xs md:text-sm text-white p-2 rounded-lg">Cerrar Sesión</button><br>
                </div>
            </div>
        </div>
        <div class="flex items-center justify-center w-full p-4 sm:mt-4 lg:mt-16 flex-wrap h-full">
            <div class="flex w-full md:w-1/3 lg:w-1/4 h-full">
                <div class="border-4 border-black divide-y divide-gray-400 bg-white rounded-lg w-full p-4">
                    <h1 class="font-bold text-2xl text-center">Proyectos:</h1>
                    <div class="py-1 text-center"><a class="font-bold text-lg text-blue-500 hover:underline" href="project.jsp">Gestionar Proyectos</a></div>
                    <div class="py-1 text-center"><a class="font-bold text-lg text-blue-500 hover:underline" href="projectview.jsp">Detalle Proyectos</a></div>
                    <div class="py-1 text-center"><a class="font-bold text-lg text-blue-500 hover:underline" href="working.jsp">Recurso humano en proyecto</a></div>
                    <div class="py-1 text-center"><a class="font-bold text-lg text-blue-500 hover:underline" href="inuse.jsp">Equipo en uso</a></div>
                </div>
            </div>
            
            <div class="flex w-full md:w-1/3 lg:w-1/4">
                <div class="border-4 border-black divide-y divide-gray-400 bg-white rounded-lg w-full p-4">
                    <h1 class="font-bold text-2xl text-center">Usuarios:</h1>
                    <div class="py-1 text-center"><a class="font-bold text-lg text-blue-500 hover:underline" href="users.jsp">Gestionar Usuarios</a></div>
                    <div class="py-1 text-center"><a class="font-bold text-lg text-blue-500 hover:underline" href="client.jsp">Gestionar Clientes</a></div>
                    <div class="py-1 text-center"><a class="font-bold text-lg text-blue-500 hover:underline" href="logs.jsp">Logs Usuarios</a></div>
                </div>
            </div>

            <div class="flex w-full md:w-1/3 lg:w-1/4">
                <div class="border-4 border-black divide-y divide-gray-400 bg-white rounded-lg w-full p-4">
                    <h1 class="font-bold text-2xl text-center">Empresa:</h1>
                    <div class="py-1 text-center"><a class="font-bold text-lg text-blue-500 hover:underline" href="equipment.jsp">Inventario Equipo</a></div>
                    <div class="py-1 text-center"><a class="font-bold text-lg text-blue-500 hover:underline" href="employees.jsp">Gestionar Empleados</a></div>
                    <div class="py-1 text-center"><a class="font-bold text-lg text-blue-500 hover:underline" href="department.jsp">Gestionar Departamentos</a></div>
                    <div class="py-1 text-center"><a class="font-bold text-lg text-blue-500 hover:underline" href="position.jsp">Gestionar Posiciones</a></div>
                    <div class="py-1 text-center"><a class="font-bold text-lg text-blue-500 hover:underline" href="reptest.jsp">Gestionar Reportes</a></div>
                </div>
            </div>
        </div>

    </body>
</html>


<%-- 
    Document   : clientMenu
    Created on : 11-nov-2020, 15:37:38
    Author     : Ismael
--%>

<%@page import="java.util.List"%>
<%@page import="com.model.Client"%>
<%@page import="com.model.Project"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page session="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession();

    if ((Integer) session.getAttribute("rol") != 4) {
        response.sendRedirect("loginController?nosession=y");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Clientes Dashboard - CONSTRU SV</title>
        <!-- Icon -->
        <link rel="icon" href="../imgs/logos/Logo.png" type="image/png">
        <!-- Tailwind -->
        <link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet">
        <!-- CSS -->
        <link rel="stylesheet" href="../css/style.css">
        <!-- JQuery -->
        <script type="text/javascript" src="../jquery.js"></script>
        <!-- SweetAlert2 -->
        <script type="text/javascript" src="../js/sweetalert2.all.min.js"></script>
        <style>
            /* Tamaño del div del mapa. */
            #map {
                height: 50%;
                width: 80%;
                margin-left: 10%;
                margin-right: 10%;
                margin-top: 2%;
            }

            html, body {
                height: 100%;
                margin: 0;
                padding: 0;
            }


        </style>
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
                            $('#log').append("<a id='home-link' href='../loginController?logout=y'></a>");
                            document.getElementById("home-link").click();

                        }
                    });

                });
            });

            function myLoad(lat, lng) {
                $("#my_lat").val(lat);
                $("#my_lng").val(lng);
            }
        </script>
    </head>
    <%
        Project prj = new Project();
        Client cli = new Client();
    %>
    <body class="bg-black">
        <header>
            <%
                if (request.getSession().getAttribute("bandera2").equals(1)) {
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
        <input type="hidden" required placeholder="Latitud" name="my_lat"  id="my_lat">
        <input type="hidden" required placeholder="Longitud" name="my_lng" id="my_lng" >
        <div style="visibility: hidden;" id="log"></div>





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
                    <button id="btnLogout" class="bg-blue-500 hover:bg-blue-700 font-bold text-xs md:text-sm text-white p-2 rounded-lg">Cerrar Sesión</button><br>
                </div>
            </div>
        </div>

        <div id="map"></div>

        <div class="text-white flex justify-center mt-4">
            <h1 class="text-white text-4xl font-bold text-center">Proyectos</h1>
        </div>
        <div class="text-white w-full md:flex md:justify-center md:w-auto mt-4 px-4 overflow-x-auto">
            <table>
                <thead>
                <th class="border-2 border-white border-dashed p-2 text-lg">ID</th>
                <th class="border-2 border-white border-dashed p-2 text-lg">Nombre</th>
                <th class="border-2 border-white border-dashed p-2 text-lg">Descripción</th>
                <th class="border-2 border-white border-dashed p-2 text-lg">Fecha de Inicio</th>
                <th class="border-2 border-white border-dashed p-2 text-lg">Fecha de Finalización</th>
                <th class="border-2 border-white border-dashed p-2 text-lg">Dirección</th>

                <th class="border-2 border-white border-dashed p-2 text-lg">Compañía</th>
                <th class="border-2 border-white border-dashed p-2 text-lg">Estado</th>
                <th class="border-2 border-white border-dashed p-2 text-lg">Ubicación</th>
                </thead>
                <%
                    List<Project> lst2 = prj.showPrjByCli((Integer) session.getAttribute("Id"));
                    for (Project p : lst2) {
                %>
                <tr>
                    <td class="border-2 border-white border-dashed p-1 font-bold text-center"><%= p.getId()%></td>
                    <td class="border-2 border-white border-dashed p-1"><%= p.getName()%></td>
                    <td class="border-2 border-white border-dashed p-1"><%= p.getDescription()%></td>
                    <td class="border-2 border-white border-dashed p-1"><%= p.getStarted_date()%></td>
                    <td class="border-2 border-white border-dashed p-1"><%= p.getFinish_date()%></td>
                    <td class="border-2 border-white border-dashed p-1"><%= p.getAddress()%></td>

                    <td class="border-2 border-white border-dashed p-1"><%= cli.getClient((Integer) session.getAttribute("usrId")).getCompany_name()%></td>
                    <td class="border-2 border-white border-dashed p-1"><%= p.getStatus()%></td>
                    <td class="border-2 border-white border-dashed p-1">
                        <button  class="font-bold text-blue-500 hover:underline" onclick="myLoad('<%= p.getLat()%>', '<%= p.getLng()%>');ruta()">
                            Seleccionar
                        </button>
                    </td>
                </tr>
                <%
                    }
                %>
            </table>
        </div>
        <div class="flex justify-center mt-8">
            <a href="clientDetalles.jsp" class="text-center font-bold text-lg text-blue-500 hover:underline">Detalles de Proyectos →</a>
        </div>
        <br>

        <!--Archivo local Javascript Toda la programación en este archivo-->
        <script type="text/javascript" src="../js/googleMaps.js"></script>
        <!--Archivo de GoogleMaps-->
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCbUDtVGNnPGBMF4Acpf0CbJYmLspmq-Ps&callback=initMap" async defer></script>
    </body>
</html>

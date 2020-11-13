<%-- 
    Document   : project
    Created on : Oct 23, 2020, 12:20:58 AM
    Author     : Ismael
--%>

<%@page import="java.util.List"%>
<%@page import="com.model.Client"%>
<%@page import="com.model.Project"%>
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
        <title>Proyectos - CONSTRU SV</title>
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
        function myLoad(id, name, desc, start, finish, address, lat, lng, client, status) {
            $("#txtId").val(id);
            $("#txtName").val(name);
            $("#txtDesc").val(desc);
            $("#dapStart").val(start);
            $("#dapFinish").val(finish);
            $("#dsHidden").val(start);
            $("#dfHidden").val(finish);
            $("#txtAddress").val(address);
            $("#my_lat").val(lat);
            $("#my_lng").val(lng);
            $("#slctClient").val(client);
            $("#txtStatus").val(status);
            $("#idHidden").val(id);
            $("#nameHidden").val(name);
            $("#statusHidden").val(status);
            document.getElementById("edit-mark").disabled = false;
            document.getElementById("add-mark").disabled = true;
            document.getElementById("maquinaria").disabled = false;

            $('#btnUpdate').attr('disabled',false);
            $('#btnDelete').attr('disabled',false);
            $('#btnCreate').attr('disabled',true); 
        }

        function reset() {
            $("#txtId").val(0);
            $("#txtName").val("");
            $("#txtDesc").val("");
            $("#dapStart").val("");
            $("#dapFinish").val("");
            $("#txtAddress").val("");
            $("#my_lat").val("");
            $("#my_lng").val("");
            $("#slctClient").val("");
            $("#txtStatus").val("");
            document.getElementById("edit-mark").disabled = true;
            document.getElementById("maquinaria").disabled = true;

            $('#btnCreate').attr('disabled',false);
            $('#btnUpdate').attr('disabled',true);
            $('#btnDelete').attr('disabled',true);
        }

        function clean(){
            $('#btnCreate').attr('disabled',false);
            $('#btnUpdate').attr('disabled',true);
            $('#btnDelete').attr('disabled',true);
        }
        
        function disa(){
            document.getElementById("edit-mark").disabled = true;
        }


    </script>
    <script src="js/smooth-scroll.min.js"></script>

    <script>
        var scroll = new SmoothScroll('a[href*="#"]', {
            speed: 1000
        });
    </script>
</head>
<%
    Project prj = new Project();
    Client cli = new Client();
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
                    'Proyecto',
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
    <h1 class="text-white text-4xl font-bold text-center">Gestión de Proyectos</h1>
</div>
<div class="flex justify-center">
    <a href="index.jsp" class="text-center font-bold text-lg text-blue-500 hover:underline">← Regresar</a>
</div>


    <div id="map"></div>

<div class="text-white flex justify-center w-full md:w-auto mt-4">
    <div>
        <div class="md:flex md:justify-center w-full p-2">
            <input type="button" value="Add a Mark" id="add-mark" onclick="var param = 0; agregarPunto(param);" class="text-black bg-white font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400">

            <input type="button" value="Edit Mark" id="edit-mark" disabled="disabled" onclick="disa();initMap();var param = 0; agregarPunto(param);" class="text-black bg-white font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400">
        
            <form method="POST" action="projectController">
                <input type="submit" value="Recurso Humano y Maquinaria →" id="maquinaria" disabled="disabled" name="btnMaquinaria" class="text-black bg-white font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400">
                <input type="hidden" name="nameHidden" id="nameHidden">
                <input type="hidden" name="idHidden"  id="idHidden">
                <input type="hidden" name="statusHidden"  id="statusHidden">
                <input type="hidden" name="dsHidden"  id="dsHidden">
                <input type="hidden" name="dfHidden"  id="dfHidden">
            </form>
        </div>
                
                <br>
                    <form id="frmMain" action="projectController" method="POST">
                        <div id="question"></div>

                        <input type="hidden" name="txtId" id="txtId" class="text-black font-bold text-lg p-2 rounded" value="0"/>
                        <input type="hidden" id="latLng">      
                        <input type="hidden" id="oculto">
                        <input type="hidden" required placeholder="Latitud" name="my_lat"  id="my_lat">
                        <input type="hidden" required placeholder="Longitud" name="my_lng" id="my_lng" >
                        
                        <div class="flex flex-wrap w-full">
                            <div class="w-full md:w-1/2">
                                <label class="font-bold text-lg">Nombre de Proyecto: </label><br>
                                <input type="text" name="txtName" id="txtName" class="text-black font-bold text-lg p-2 rounded" required/><br>
                            
                                <label class="font-bold text-lg">Descripción: </label><br>
                                <textarea class="text-black font-bold text-lg p-2 rounded" name="txtDesc" id="txtDesc" required rows="3"></textarea><br>
        
                                <label class="font-bold text-lg">Fecha de Inicio: </label><br>
                                <input type="date" name="dapStart" id="dapStart" class="text-black font-bold text-lg p-2 rounded" min='2020-11-01' max='2021-12-31' required/><br>
                                
                                <label class="font-bold text-lg">Fecha de Finalización: </label><br>
                                <input type="date" name="dapFinish" id="dapFinish" class="text-black font-bold text-lg p-2 rounded" min='2020-11-01' max='2021-12-31' required/><br>
                            </div>
                            <div class="w-full md:w-1/2 md:pl-4">
                                <div id="ismael">
                                    
                                    <label class="font-bold text-lg">Dirección: </label><br>
                                    <textarea class="text-black font-bold text-lg p-2 rounded" name="txtAddress" id="txtAddress" required rows="3"></textarea><br>
                                
                                    <label class="font-bold text-lg">Compañía: </label><br>
                                    <select name="slctClient" id="slctClient" class="text-black font-bold text-lg p-2 rounded">
                                        <%
                                            List<Client> lst = cli.showClient();
                                            for (Client c : lst) {
                                        %>
                                        <option value="<%= c.getId()%>"><%= c.getCompany_name()%></option>
                                        <%
                                            }
                                        %>
                                    </select><br>
                                        
                                </div>
        
                                <label class="font-bold text-lg">Estado de Proyecto: </label><br>
                                <input type="text" name="txtStatus" id="txtStatus" class="text-black font-bold text-lg p-2 rounded" readonly/><br>
                                    
                            </div>
                        </div>

                        <div class="mt-8">
                            <div class="md:flex md:justify-center w-full p-2">
                            <button class="text-black bg-white font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"  onclick="disa();initMap();var param = 0; agregarPunto(param);reset();clean();" type="reset"  >Nuevo</button>
                            <input type="submit" name="btnCreate" id="btnCreate" disabled="disabled" value="Crear" class="text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                            <input type="button" name="btnUpdate" id="btnUpdate" disabled="disabled" value="Actualizar" class="text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                            <input type="button" name="btnDelete" id="btnDelete" disabled="disabled" value="Eliminar" class="text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                        </div>
                    </div>
                </form>
                </div>
        </div>
            <div class="text-white w-full md:w-auto mt-4 p-4">
                    <table>
                        <thead>
                            <th class="border-2 border-white border-dashed p-2 text-lg">ID</th>
                            <th class="border-2 border-white border-dashed p-2 text-lg">Nombre</th>
                            <th class="border-2 border-white border-dashed p-2 text-lg">Project description</th>
                            <th class="border-2 border-white border-dashed p-2 text-lg">Starts</th>
                            <th class="border-2 border-white border-dashed p-2 text-lg">Ends</th>
                            <th class="border-2 border-white border-dashed p-2 text-lg">address</th>
                            
                            <th class="border-2 border-white border-dashed p-2 text-lg">Company</th>
                            <th class="border-2 border-white border-dashed p-2 text-lg">Status</th>
                            <th class="border-2 border-white border-dashed p-2 text-lg">Action</th>

                        </thead>
                        <tbody>
                        <%
                            List<Project> lst2 = prj.showPrj();
                            for (Project p : lst2) {
                        %>
                        <tr>
                            <td class="border-2 border-white border-dashed p-1"><%= p.getId()%></td>
                            <td class="border-2 border-white border-dashed p-1"><%= p.getName()%></td>
                            <td class="border-2 border-white border-dashed p-1"><%= p.getDescription()%></td>
                            <td class="border-2 border-white border-dashed p-1"><%= p.getStarted_date()%></td>
                            <td class="border-2 border-white border-dashed p-1"><%= p.getFinish_date()%></td>
                            <td class="border-2 border-white border-dashed p-1"><%= p.getAddress()%></td>
                            
                            <td class="border-2 border-white border-dashed p-1"><%= cli.getClientPjct(p.getClient_id()).getCompany_name() %></td>
                            <td class="border-2 border-white border-dashed p-1"><%= p.getStatus()%></td>
                            <td class="border-2 border-white border-dashed p-1">
                                <a data-scroll href="#map" >
                                    <button  class="font-bold text-blue-500 hover:underline" onclick="myLoad('<%= p.getId()%>', '<%= p.getName()%>', '<%= p.getDescription()%>',
                                        '<%= p.getStarted_date()%>', '<%= p.getFinish_date()%>', '<%= p.getAddress()%>',
                                        '<%= p.getLat()%>', '<%= p.getLng()%>', '<%= p.getClient_id()%>','<%= p.getStatus()%>');ruta()">
                                        Seleccionar
                                    </button></a>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                    </table>
                </div>

                <!--Archivo local Javascript Toda la programación en este archivo-->
                <script type="text/javascript" src="js/googleMaps.js"></script>
                <!--Archivo de GoogleMaps-->
                <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCbUDtVGNnPGBMF4Acpf0CbJYmLspmq-Ps&callback=initMap" async defer></script>

                <!-- Navbar -->
                <script src="js/navbar.js"></script>
            </body>
    </html>

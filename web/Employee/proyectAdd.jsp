<%-- 
    Document   : proyectAdd
    Created on : 04-nov-2020, 21:39:51
    Author     : Ismael
--%>

<%@page import="com.model.Equipment"%>
<%@page import="com.model.InUse"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.model.Position"%>
<%@page import="com.model.Working"%>
<%@page import="com.model.Employees"%>
<%@page import="com.model.Project"%>
<%@page import="java.util.List"%>
<%@page session="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession();
    String rol;
    if (sesion.getAttribute("rolName") == null) {
        response.sendRedirect("../loginController?nosession=y");
    }
    Project prj = new Project();
    Employees emp = new Employees();
    Equipment equ = new Equipment();
    Working wrk = new Working();
    Position pos = new Position();
    InUse inu = new InUse();
    DecimalFormat df = new DecimalFormat("##.##");
%>
<!doctype html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Detalle de Proyectos - CONSTRU SV</title>
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
        </script>
        
    </head>
    <body class="bg-black">
        
        <div id="opciones" class="hidden p-4 bg-gray2 border-b-2 border-black text-white">
            <div class="flex items-center justify-center w-ful flex-wrap">
                <div class="flex w-full md:w-1/4 lg:w-1/5 my-1 md:mr-4">
                    <div class="border-2 border-white divide-y divide-gray-400 rounded-lg w-full p-2">
                        <h1 class="font-bold text-lg text-center">Gestionar:</h1>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="project.jsp">Gestionar Proyectos</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="users.jsp">Gestionar Usuarios</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="client.jsp">Gestionar Clientes</a></div>
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
            <h1 class="text-white text-4xl font-bold text-center">Detalles de Proyecto</h1>
        </div>
        <div class="text-white flex justify-center mt-2">
            <p class="text-white text-xl text-center">Detalles de Personal, Maquinaria y Costos de un Proyecto</p>
        </div>
        <div class="flex justify-center">
            <a href="project.jsp" class="text-center font-bold text-lg text-blue-500 hover:underline">← Regresar</a>
        </div>
        <div class="text-white flex justify-center mt-4">
            <div>
                <h2 class="text-white text-xl font-bold text-center"><%= session.getAttribute("name_attr")%></h2>
                <h2 class="text-white font-bold text-center">Fecha de Inicio: <%= session.getAttribute("dIni")%>        -       Fecha de Finalización: <%= session.getAttribute("dFin")%></h2>
                <h2 class="text-white font-bold text-center">Estado <span class="underline"><%= session.getAttribute("status_attr")%></span></h2>
            </div>
        </div>

        <div class="flex flex-wrap w-full px-4">
            <div class="w-full md:w-1/2 p-4">
                <div class="border border-white rounded text-white">
                <a href="#">
                    <img class="object-cover w-full h-64 object-left-bottom rounded-t" src="../imgs/personal.jpg" focusable="false" role="img"></img>
                </a>
                <div class="text-white flex justify-center mt-2">
                    <h3 class="text-2xl font-bold text-center">PERSONAL TRABAJANDO EN PROYECTO</h3>
                </div>
                <div class="w-full mt-2 overflow-x-auto">
                    <table class="w-full">
                        <thead>
                            <th class="border border-white p-1">Nombre</th>
                            <th class="border border-white p-1">Cargo</th>
                            <th class="border border-white p-1">Desde</th>
                            <th class="border border-white p-1">Hasta</th>
                            <th class="border border-white p-1">Días</th>
                            <th class="border border-white p-1">Costo diario en Proyecto</th>
                            <th class="border border-white p-1">Costo</th>
                        </thead>
                                        <%
                                            int idHere = (Integer) session.getAttribute("id_attr");

                                            List<Working> lst1 = wrk.showWorkingByPro(idHere);
                                            double total = 0;
                                            double totalF = 0;
                                            for (Working w : lst1) {
                                                String name = emp.getEmp(w.getEmployee_id()).getFirst_name()
                                                        + " " + emp.getEmp(w.getEmployee_id()).getLast_name();
                                        %>
                                        <tr>
                                            <td class="border border-white p-1"><%= name%></td>
                                            <td class="border border-white p-1"><%= pos.getPos((emp.getEmp(w.getEmployee_id()).getPosition_id())).getName()%></td>
                                            <td class="border border-white p-1"><%= w.getIn_pro_from()%></td>
                                            <td class="border border-white p-1"><%= w.getIn_pro_to()%></td>
                                            <td class="border border-white p-1"><%= w.daysIn(w.getIn_pro_from(), w.getIn_pro_to())%></td>
                                            <td class="border border-white p-1">$<%= df.format(w.getCost())%></td>
                                            <%
                                                total = (w.daysIn(w.getIn_pro_from(), w.getIn_pro_to())) * (w.getCost());
                                                totalF = totalF + total;


                                            %>
                                            <td class="border border-white p-1">$<%= df.format(total)%></td>
                                            <%
                                                }
                                            %>

                                        </tr>
                                        <tr>
                                            <th colspan="6" class="border border-white p-1 text-right">Total</th>
                                            <th class="border border-white p-1">$<%= df.format(totalF)%></th>
                                        </tr>
                                    </table>
                                </div>

                                <%
                                    if(!session.getAttribute("status_attr").equals("finalizado")){
                                %>
                                <div class="my-4">
                                    <div class="flex justify-center w-full p-2">
                                        <a class="text-black bg-white font-bold text-lg p-1 rounded boder-white border mr-2 cursor-pointer hover:bg-black hover:text-white" href="workingDetalle.jsp" role="button">IR a CRUD →</a>
                                    </div>
                                </div>
                                <%
                                    }
                                %>

                        </div>
                    </div>

                    <div class="w-full md:w-1/2 p-4">
                    <div class="border border-white rounded text-white">
                    <a href="#">
                        <img class="object-cover w-full h-64 object-center rounded-t" src="../imgs/maquinas.jpg" focusable="false" role="img"></img>
                    </a>
                    <div class="text-white flex justify-center mt-2">
                        <h3 class="text-2xl font-bold text-center">MAQUINARIA TRABAJANDO EN PROYECTO</h3>
                    </div>
                    <div class="w-full mt-2 overflow-x-auto">
                        <table class="w-full">
                            <thead>
                                <th class="border border-white p-1">Maquinaria</th>
                                <th class="border border-white p-1">Unidades</th>
                                <th class="border border-white p-1">Desde</th>
                                <th class="border border-white p-1">Hasta</th>
                                <th class="border border-white p-1">Días</th>
                                <th class="border border-white p-1">Costo Diario(Unitario)</th>
                                <th class="border border-white p-1">Costo</th>
                            </thead>
                                    <%
                                        idHere = (Integer) session.getAttribute("id_attr");

                                        List<InUse> lst3 = inu.showInUsebyPro(idHere);
                                        double totalM = 0;
                                        double totalFM = 0;
                                        for (InUse i : lst3) {
                                            String name = equ.getEqu(i.getEquipment_id()).getName() + " " + equ.getEqu(i.getEquipment_id()).getModel();
                                    %>
                                    <tr>
                                        <td class="border border-white p-1"><%= name%></td>
                                        <td class="border border-white p-1"><%= i.getEquipment_quantity()%></td>
                                        <td class="border border-white p-1"><%= i.getIn_pro_from()%></td>
                                        <td class="border border-white p-1"><%= i.getIn_pro_to()%></td>
                                        <td class="border border-white p-1"><%= wrk.daysIn(i.getIn_pro_from(), i.getIn_pro_to())%></td>
                                        <td class="border border-white p-1"><%= df.format(i.getCost())%></td>
                                        <%
                                            //here we need to calculate total cost per truck
                                            totalM = (i.daysInUse(i.getIn_pro_from(), i.getIn_pro_to())) * (i.getCost() * i.getEquipment_quantity());
                                            totalFM = totalFM + totalM;
                                        %>
                                        <td class="border border-white p-1">$<%= df.format(totalM)%></td>
                                        <%
                                            }
                                        %>

                                    </tr>
                                    <tr>
                                        <th colspan="6" class="border border-white p-1 text-right">Total</th>
                                        <th class="border border-white p-1">$<%= df.format(totalFM)%></th>
                                    </tr>
                                </table>
                                <%
                                    if(!session.getAttribute("status_attr").equals("finalizado")){
                                %>
                                <div class="my-4">
                                    <div class="flex justify-center w-full p-2">
                                        <a class="text-black bg-white font-bold text-lg p-1 rounded boder-white border mr-2 cursor-pointer hover:bg-black hover:text-white" href="inUseDetalle.jsp" role="button">IR a CRUD →</a>
                                    </div>
                                </div>
                               
                                <%
                                    }
                                %>
                        </div>
                        </div>
                    </div>
        <div class="text-white flex justify-center w-full my-4">
            <h1 class="text-white text-2xl font-bold text-center">Costo de Proyecto: $<%= df.format(totalFM+totalF) %></h1>
        </div>        
                

    <!-- Navbar -->
    <script src="../js/navbar.js"></script>
</body>
</html>

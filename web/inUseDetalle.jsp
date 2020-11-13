<%-- 
    Document   : inUseDetalle
    Created on : 07-nov-2020, 22:24:56
    Author     : ismael
--%>

<%@page import="com.model.Working"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.model.Equipment"%>
<%@page import="com.model.Project"%>
<%@page import="com.model.InUse"%>
<%@page session="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    DecimalFormat df = new DecimalFormat("##.##");
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
        <title>Maquinaria Proyecto - CONSTRU SV</title>
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
        function myLoad(id, equi, proj, df, dt, eqQ, cst, stock) {
            var textSelected = document.getElementById("slctEqId");
            var str = textSelected.options[textSelected.selectedIndex].text;
            var maxi = str.match(/\(([^)]+)\)/)[1];
            $("#numEqQu").attr('max', stock);
            $("#txtId").val(id);
            $("#slctEqId").val(equi);
            $("#slctProId").val(proj);
            $("#datFrom").val(df);
            $("#datTo").val(dt);
            $("#numEqQu").val(eqQ);
            $("#numCost").val(cst);
            $("#vliStock").val(eqQ);
            $('#btnUpdate').attr('disabled', false);
            $('#btnDelete').attr('disabled', false);
            $('#btnCreate').attr('disabled', true);
            $('#divAdd').hide();
            $('#divUpdDel').show();
        }
        
        function getMInMax(){
            var textSelected = document.getElementById("slctEqId");
            var str = textSelected.options[textSelected.selectedIndex].text;
            var maxi = str.match(/\(([^)]+)\)/)[1];
            $text = 'ignore everything except this {{ text1  }}';
            preg_match('#\{\{(.*?)\}\}#', $text, $match);
            $("#numEqQu").attr('max', maxi);
            $("#numEqQu").val(1);
        }

        function clean() {
            $('#divAdd').show();
            $('#divUpdDel').hide();
            $('#btnCreate').attr('disabled', false);
            $('#btnUpdate').attr('disabled', true);
            $('#btnDelete').attr('disabled', true);
        }

    </script>
</head>
<%
    InUse inu = new InUse();
    Project prj = new Project();
    Equipment equ = new Equipment();
    Working wrk = new Working();
    int idCustom = 0;

%>
<body class="bg-black">
    <header>
        <script>
            $(document).ready(function () {
                $('#divAdd').show();
                $('#divUpdDel').hide();
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
        <%
            if ((request.getSession().getAttribute("msj") != null)
                    && (request.getSession().getAttribute("conta").equals(1))) {
        %>
        <script type="text/javascript">

            Swal.fire(
                    'Project',
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
            <!-- <a href="loginController?logout=y" class="bg-blue-500 hover:bg-blue-700 font-bold text-xs md:text-sm text-white p-2 rounded-lg">Cerrar Sesión</a><br> -->
            <button id="btnLogout" class="bg-blue-500 hover:bg-blue-700 font-bold text-xs md:text-sm text-white p-2 rounded-lg">Cerrar Sesión</button>
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

    <div style="visibility: hidden;" id="log"></div>

    <!-- ---------------------------------------------------------------------- -->

    <div class="text-white flex justify-center mt-4">
        <h1 class="text-white text-4xl font-bold text-center">Maquinaria en Proyecto</h1>
    </div>
    <div class="flex justify-center">
        <a href="proyectAdd.jsp" class="text-center font-bold text-lg text-blue-500 hover:underline">← Regresar</a>
    </div>
    <div class="text-white flex justify-center mt-4">
        <h1 class="text-white text-xl font-bold text-center">Proyecto: <%= session.getAttribute("name_attr")%></h1>
    </div>

<div class="text-white flex justify-center w-full md:w-auto mt-4">
    <form id="frmMain" action="inUseDetController" method="POST">
        <div id="question"></div>
        <input type="hidden" name="slctProId" id="slctProId" value="<%= (Integer) session.getAttribute("id_attr")%>" class='form-control'>
        <input type="hidden" name="vliStock" id="vliStock">
            <input type="hidden" name="txtId" id="txtId" value="0"/>

            <div id="divUpdDel">
                <label>Equipo:</label><br>
                <select name="slctEqIdU" id="slctEqId" required="required" class="text-black font-bold text-lg p-2 rounded" onchange="getMInMax()">
                    <%
                        List<Equipment> lst = equ.showEqu();
                        for (Equipment e : lst) {
                            int inv = e.getInventory();
                            int quant = inu.getQuantInPro(e.getId(),(Integer) session.getAttribute("id_attr")).getEquipment_quantity();
                            int stockTrue = inv - quant;
                    %>
                    <option value="<%= e.getId()%>"><%= e.getName()%> <%= e.getModel()%>
                        En Stock (<%= stockTrue%>) *$[<%= e.getRentalPrice()%>]</option>
                    <%
                        }
                    %>
                </select><br>
            </div>
            <div id="divAdd">
                <label>Equipo:</label><br>
                <select name="slctEqIdA" id="slctEqId" required="required" class="text-black font-bold text-lg p-2 rounded" onchange="getMInMax()">
                    <%
                        List<Equipment> lstAdd = equ.showEquAvaila((Integer) session.getAttribute("id_attr"));
                        for (Equipment e : lstAdd) {
                            int inv = e.getInventory();
                            int quant = inu.getQuantInPro(e.getId(),(Integer) session.getAttribute("id_attr")).getEquipment_quantity();
                            int stockTrue = inv - quant;
                    %>
                    <option value="<%= e.getId()%>"><%= e.getName()%> <%= e.getModel()%>
                        En Stock (<%= stockTrue%>) *$[<%= e.getRentalPrice()%>]</option>
                    <%
                        }
                    %>
                </select><br>
            </div>
                

                <label>En Proyecto desde: </label><br>
                <input type="date" name="datFrom" id="datFrom" class="text-black font-bold text-lg p-2 rounded" 
                       value="<%= prj.getProyect((Integer) session.getAttribute("id_attr")).getStarted_date()%>"
                       min='<%= prj.getProyect((Integer) session.getAttribute("id_attr")).getStarted_date()%>' 
                       max='<%= prj.getProyect((Integer) session.getAttribute("id_attr")).getFinish_date()%>' 
                       required/> <br>
            
                <label>En proyecto hasta: </label> <br>
                <input type="date" name="datTo" id="datTo" class="text-black font-bold text-lg p-2 rounded"
                       value="<%= prj.getProyect((Integer) session.getAttribute("id_attr")).getFinish_date()%>"
                       min='<%= prj.getProyect((Integer) session.getAttribute("id_attr")).getStarted_date()%>' 
                       max='<%= prj.getProyect((Integer) session.getAttribute("id_attr")).getFinish_date()%>' 
                       required/> <br>


                <label>Número de unidades a asignar: </label> <br>

                <input type="number" name="numEqQu" id="numEqQu" max="" min="1"
                       step="1" class="text-black font-bold text-lg p-2 rounded" required/> <br>
                <label>Precio Unitario de alquiler: </label> <br>
                <input type="number" name="numCost" id="numCost" min="5" step="0.01" class="text-black font-bold text-lg p-2 rounded" required/> <br>



        <div class="mt-8">
            <div class="md:flex md:justify-center w-full p-2">
                <input type="reset" name="btnNew" value="Limpiar" onclick="clean();" class="text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                <input type="submit" name="btnCreate" id="btnCreate" disabled="disabled" value="Crear" class="text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                <input type="button" id="btnUpdate" value="Actualizar" disabled="disabled" class="text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                <input type="button" id="btnDelete" value="Eliminar" disabled="disabled"  class="text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
            </div>
        </div>
    </form>
</div>
    
<div class="text-white md:flex md:justify-center w-full md:w-auto mt-4 px-4 overflow-x-auto">
    <table>
        <thead>
            <th class="border-2 border-white border-dashed p-2"> Maquinaria</th>
            <th class="border-2 border-white border-dashed p-2"> Unidades en proyecto</th>
            <th class="border-2 border-white border-dashed p-2"> Unidades In Stock</th>
            <th class="border-2 border-white border-dashed p-2"> Desde</th>
            <th class="border-2 border-white border-dashed p-2"> Hasta</th>
            <th class="border-2 border-white border-dashed p-2"> Días en Proyecto</th>
            <th class="border-2 border-white border-dashed p-2"> Costo diario (unitario)</th>
            <th class="border-2 border-white border-dashed p-2"> Costo en Proyecto</th>
            <th class="border-2 border-white border-dashed p-2"> Acción</th>
        </thead>
        <%
            int id;
            id = (Integer) session.getAttribute("id_attr");

            List<InUse> lst3 = inu.showInUsebyPro(id);
            double totalM = 0.0;
            double totalFM = 0.0;
            for (InUse i : lst3) {
                String name = equ.getEqu(i.getEquipment_id()).getName() + " " + equ.getEqu(i.getEquipment_id()).getModel();
        %>
        <tr>
            <td class="border-2 border-white border-dashed p-2"><%= name%></td>
            <td class="border-2 border-white border-dashed p-2"><%= i.getEquipment_quantity()%></td> 
            <td class="border-2 border-white border-dashed p-2"><%= equ.getEqu(i.getEquipment_id()).getInventory()-i.getEquipment_quantity() %></td>
            <td class="border-2 border-white border-dashed p-2"><%= i.getIn_pro_from()%></td>
            <td class="border-2 border-white border-dashed p-2"><%= i.getIn_pro_to()%></td>
            <td class="border-2 border-white border-dashed p-2"><%= i.daysInUse(i.getIn_pro_from(), i.getIn_pro_to())%></td>
            <td class="border-2 border-white border-dashed p-2">$<%= df.format(i.getCost())%></td>
            <%
                //here we need to calculate total cost per truck daysInUse
                totalM = (i.daysInUse(i.getIn_pro_from(), i.getIn_pro_to())) * (i.getCost() * i.getEquipment_quantity());
                totalFM = totalFM + totalM;

            %>
            <td class="border-2 border-white border-dashed p-2">$<%= df.format(totalM)%></td>
            <td class="border-2 border-white border-dashed p-2">
                <a><button onclick="myLoad(<%= i.getId()%>,<%= i.getEquipment_id()%>,<%= i.getProject_id()%>, 
                   '<%= i.getIn_pro_from()%>', '<%= i.getIn_pro_to()%>', <%= i.getEquipment_quantity()%>, 
          <%= i.getCost()%>, <%= equ.getEqu(i.getEquipment_id()).getInventory()-i.getEquipment_quantity() %>)"
          class="font-bold text-blue-500 hover:underline">Seleccionar</button></a></td>
            </td>
            <%
                }
            %>

        </tr>
        <tr>
            <th colspan="7" class="border-2 border-white border-dashed p-2 text-right">Total</th>
            <th class="border-2 border-white border-dashed p-2">$<%= df.format(totalFM)%></th>

        </tr>
    </table>
</div>
    <br>
<!-- Navbar -->
<script src="js/navbar.js"></script>
</body>
</html>

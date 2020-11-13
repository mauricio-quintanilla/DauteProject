<%-- 
    Document   : equipment
    Created on : Oct 22, 2020, 10:45:53 PM
    Author     : demon
--%>

<%@page import="java.util.List"%>
<%@page import="com.model.Equipment"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
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
        <title>Inventario Equipo - CONSTRU SV</title>
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
            function myLoad(id, name, model, desc, brand, inv, type, rentalPrice, image) {
                $("#txtId").val(id);
                $("#txtName").val(name);
                $("#txtModel").val(model);
                $("#txtDesc").val(desc);
                $("#txtBrand").val(brand);
                $("#numInv").val(inv);
                $("#numType").val(type);
                $("#rentalPrice").val(rentalPrice);
                $("#fileImgBU").val(image);
                
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
    Equipment equ = new Equipment();
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
            <%//&& 
                if (request.getSession().getAttribute("msj") != null && request.getSession().getAttribute("conta").equals(1)) {
            %>
            <script type="text/javascript">

                Swal.fire(
                        'Department',
                        '<%= request.getSession().getAttribute("msj")%>',
                        'success'
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
                        <h1 class="font-bold text-lg text-center">Gestionar:</h1>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="project.jsp">Gestionar Proyectos</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="users.jsp">Gestionar Usuarios</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="client.jsp">Gestionar Clientes</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="equipment.jsp">Inventario Equipo</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="employees.jsp">Gestionar Empleados</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="department.jsp">Gestionar Departamentos</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="position.jsp">Gestionar Posiciones</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="reptest.jsp">Gestionar Reportes</a></div>
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
            <h1 class="text-white text-4xl font-bold text-center">Gestión Inventario Equipo</h1>
        </div>
        <div class="flex justify-center">
            <a href="index.jsp" class="text-center font-bold text-lg text-blue-500 hover:underline">← Regresar</a>
        </div>

        <div class="text-white flex justify-center w-full mt-4 px-4">
            <form id="frmMain" action="" method="POST" enctype="multipart/form-data">
                <div id="question"></div>
                    <input type="hidden" name="txtId" id="txtId" value="0"/>

                    <div class="flex flex-wrap w-full">
                        <div class="w-full md:w-1/2">
                            <label class="font-bold text-lg">Nombre de equipo: </label><br>
                            <input type="text" name="txtName" id="txtName" class='text-black font-bold text-lg p-2 rounded w-full' required/><br>

                            <label class="font-bold text-lg">Modelo: </label><br>
                            <input type="text" name="txtModel" id="txtModel" class='text-black font-bold text-lg p-2 rounded w-full' required/><br>

                            <label class="font-bold text-lg">Descripción: </label><br>
                            <textarea class="text-black font-bold text-lg p-2 rounded w-full" name="txtDesc" id="txtDesc" required rows="3"></textarea><br>

                            <label class="font-bold text-lg">Marca: </label><br>
                            <input type="text" name="txtBrand" id="txtBrand" class='text-black font-bold text-lg p-2 rounded w-full' required/><br>

                        </div>
                        <div class="w-full md:w-1/2 md:pl-4">
    
                            <label class="font-bold text-lg">Unidades en Inventario: </label><br>
                            <input type="number" name="numInv" id="numInv" class='text-black font-bold text-lg p-2 rounded w-full' min="1" step="1" required/><br>

                            <label class="font-bold text-lg">Tipo: </label><br>
                            <input type="number" name="numType" id="numType" class='text-black font-bold text-lg p-2 rounded w-full' min="1" step="1" required/><br>

                            <label class="font-bold text-lg">Precio de renta Diario (unitario): </label><br>
                            <input type="number" name="rentalPrice" id="rentalPrice" min='1' step="0.01" max="500000" class='text-black font-bold text-lg p-2 rounded w-full' required/><br>

                            <label class="font-bold text-lg">Imagen: </label><br>
                            <input type="file" class="bg-white text-black font-bold text-lg p-2 rounded w-full" name="fileImg" id="fileImg" value="Escoge un Archivo"><br>
                        </div>
                    </div>
                                        
                    <!-- this input allows us to temporarily store img value in case update is in process-->
                    <input type="hidden" name="fileImgBU" id="fileImgBU" value=""/>
                <div class="mt-8">
                    <div class="md:flex md:justify-center w-full p-2">
                        <input type="reset" onclick="clean()" name="btnNew" value="Limpiar" class="mt-2 md:mt-0 text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                        <input disabled formaction="../equipmentController?btnCreate=y" type="submit" name="btnCreate" id="btnCreate" value="Crear" class="mt-2 md:mt-0 text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                        <input disabled formaction="../equipmentController?btnUpdate=y" type="submit" name="btnUpdate" id="btnUpdate" value="Actualizar" class="mt-2 md:mt-0 text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                        <input disabled formaction="../equipmentController?btnDelete=y" type="submit" name="btnDelete" id="btnDelete" value="Eliminar" class="mt-2 md:mt-0 text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                    </div>    
                </div>
            </form>
        </div>


        <div class="text-white md:flex md:justify-center w-full md:w-auto mt-4 px-4 overflow-x-auto">
            <table>
                <thead>
                    <th class="border-2 border-white border-dashed p-4 text-lg">Id</th>
                    <th class="border-2 border-white border-dashed p-4 text-lg">Nombre</th>
                    <th class="border-2 border-white border-dashed p-4 text-lg">Modelo</th>
                    <th class="border-2 border-white border-dashed p-4 text-lg">Descripción</th>
                    <th class="border-2 border-white border-dashed p-4 text-lg">Marca</th>
                    <th class="border-2 border-white border-dashed p-4 text-lg">Inventario</th>
                    <th class="border-2 border-white border-dashed p-4 text-lg">Tipo</th>
                    <th class="border-2 border-white border-dashed p-4 text-lg">Precio de renta Diario (unitario)</th>
                    <th class="border-2 border-white border-dashed p-4 text-lg">Imagen</th>
                    <th class="border-2 border-white border-dashed p-4 text-lg">Seleccionar</th>
                </thead>
                <tbody>
                    <%
                        List<Equipment> lst = equ.showEqu();
                        for (Equipment e : lst) {
                    %>
                    <tr>
                        <td class="border-2 border-white border-dashed p-4"><%= e.getId()%></td>
                        <td class="border-2 border-white border-dashed p-4"><%= e.getName()%></td>
                        <td class="border-2 border-white border-dashed p-4"><%= e.getModel()%></td>
                        <td class="border-2 border-white border-dashed p-4"><%= e.getDescription()%></td>
                        <td class="border-2 border-white border-dashed p-4"><%= e.getBrand()%></td>
                        <td class="border-2 border-white border-dashed p-4"><%= e.getInventory()%> units</td>
                        <td class="border-2 border-white border-dashed p-4"><%= e.getType()%></td>
                        <td class="border-2 border-white border-dashed p-4">$<%= e.getRentalPrice()%></td>
                        <td class="border-2 border-white border-dashed p-4"><img src="../imgs/<%= e.getImage()%>" width="100px"></td>
                        <td class="border-2 border-white border-dashed p-4">
                            <a href="javascript:myLoad('<%= e.getId()%>','<%= e.getName()%>','<%= e.getModel()%>',
                               '<%= e.getDescription()%>','<%= e.getBrand()%>','<%= e.getInventory()%>',
                               '<%= e.getType()%>','<%= e.getRentalPrice()%>','<%= e.getImage()%>')"
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
    <script src="../js/navbar.js"></script>
    </body>
</html>
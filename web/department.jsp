<%-- 
    Document   : department
    Created on : Oct 19, 2020, 1:53:15 AM
    Author     : demon, ismael
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page session="true"%>
<%@page import="com.model.Department"%>
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
        <title>Departamentos - CONSTRU SV</title>
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
            function myLoad(id, name) {
                $("#txtDeptId").val(id);
                $("#txtDeptName").val(name);
                
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
        Department dpt = new Department();
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
                        <h1 class="font-bold text-lg text-center">Empresa:</h1>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="equipment.jsp">Inventario Equipo</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="employees.jsp">Gestionar Empleados</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="department.jsp">Gestionar Departamentos</a></div>
                    </div>
                </div>
                <div class="flex w-full md:w-1/4 lg:w-1/5 my-1">
                    <div class="border-2 border-white divide-y divide-gray-400 rounded-lg w-full p-2">
                        <h1 class="font-bold text-lg text-center">Proyectos:</h1>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="project.jsp">Gestionar Proyectos</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="working.jsp">Recurso humano en proyecto</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="inuse.jsp">Equipo en uso</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="projectview.jsp">ProjectVIew</a></div>
                    </div>
                </div>

                <div class="flex w-full md:w-1/4 lg:w-1/5 my-1 md:ml-4">
                    <div class="border-2 border-white divide-y divide-gray-400 rounded-lg w-full p-2">
                        <h1 class="font-bold text-lg text-center">Usuarios:</h1>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="users.jsp">Gestionar Usuarios</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="client.jsp">Gestionar Clientes</a></div>
                        <div class="py-1 text-center"><a class="font-bold text-blue-500 hover:underline" href="role.jsp">Gestionar Roles</a></div>

                    </div>
                </div>
            </div>
            <div class="flex items-center justify-center mt-4">
                <a href="loginController?logout=y" class="bg-blue-500 hover:bg-blue-700 font-bold text-xs md:text-sm text-white p-2 rounded-lg">Cerrar Sesión</a><br>
            </div>
        </div>



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
                    <button class="text-white p-1 border-2 boder-white rounded-lg focus:outline-none" onclick="menu()">Menú</button>
                </div>
            </div>
        </div>
        <div class="text-white flex justify-center mt-4">
            <h1 class="text-white text-4xl font-bold text-center">Gestión Departamentos</h1>
        </div>
        <div class="flex justify-center">
            <a href="index.jsp" class="text-center font-bold text-lg text-blue-500 hover:underline">← Regresar</a>
        </div>
        <div class="text-white flex justify-center w-full md:w-auto mt-4">
            <form id="frmMain" action="departmentController" method="POST">
                <div id="question"></div>
                <input type="hidden" name="txtDeptId" id="txtDeptId" value="0"/>
                <label class="font-bold text-lg">Nombre: </label>
                <input type="text" name="txtDeptName" id="txtDeptName" class="text-black font-bold text-lg p-2 rounded" required/>
                <div class="mt-8">
                    <input type="reset" name="btnNew" value="Limpiar" onclick="clean();" class="text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                    <input type="submit" name="btnCreate" id="btnCreate" disabled="disabled" value="Crear" class="text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                    <input type="button" id="btnUpdate" value="Actualizar" disabled="disabled" class="text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                    <input type="button" id="btnDelete" value="Eliminar" disabled="disabled"  class="text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                </div>
            </form>
        </div>
        <div class="text-white flex justify-center w-full md:w-auto mt-4">

            <table>
                <thead>
                <th class="border-2 border-white border-dashed p-4 text-lg">ID</th>
                <th class="border-2 border-white border-dashed p-4 text-lg">Nombre</th>
                <th class="border-2 border-white border-dashed p-4 text-lg">Seleccionar</th>
                </thead>
                <tbody>
                    <%
                        List<Department> lst = dpt.showDept();
                        for (Department d : lst) {
                    %>
                    <tr>
                        <td class="border-2 border-white border-dashed p-4 text-center font-bold"><%= d.getId()%></td>
                        <td class="border-2 border-white border-dashed p-4"><%= d.getName()%></td>
                        <td class="border-2 border-white border-dashed p-4">
                            <a href="javascript:myLoad('<%= d.getId()%>','<%= d.getName()%>')" class="font-bold text-blue-500 hover:underline">Seleccionar</a>
                        </td>
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
<%-- 
    Document   : department
    Created on : Oct 19, 2020, 1:53:15 AM
    Author     : demon
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
        <script>
            function myLoad(id, name) {
                $("#txtDeptId").val(id);
                $("#txtDeptName").val(name);
            }
        </script>
    </head>
    <%
        Department dpt = new Department();
    %>
    <body class="bg-black">
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
                    <a href="loginController?logout=y" class="bg-blue-500 hover:bg-blue-700 font-bold text-xs md:text-sm text-white p-2 rounded-lg">Cerrar Sesión</a><br>
                </div>
            </div>
        </div>
        <div class="text-white flex justify-center">
            <h1 class="text-white text-4xl font-bold text-center">Gestión Departamentos</h1>
        </div>
        <div class="flex justify-center">
            <a href="index.jsp" class="text-center font-bold text-lg text-blue-500 hover:underline">← Regresar</a>
        </div>
        <div class="text-white flex justify-center w-full md:w-auto mt-4">
                <form id="frmMain" action="departmentController" method="POST">
                    <input type="hidden" name="txtDeptId" id="txtDeptId" value="0"/>
                    <label class="font-bold text-lg">Nombre: </label>
                    <input type="text" name="txtDeptName" id="txtDeptName" class="text-black font-bold text-lg p-2 rounded" required/>
                    <div class="mt-4">
                        <input type="reset" name="btnNew" value="Limpiar" class="text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                        <input type="submit" name="btnCreate" id="btnCreate" value="Crear" class="text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                        <input type="submit" name="btnUpdate" id="btnUpdate" value="Actualizar" class="text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
                        <input type="submit" name="btnDelete" id="btnDelete" value="Eliminar" class="text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400"/>
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
    </body>
</html>
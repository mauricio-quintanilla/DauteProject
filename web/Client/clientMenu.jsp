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
<!DOCTYPE html>
<html>
    <%
        HttpSession sesion = request.getSession();

        if ((Integer) session.getAttribute("rol") != 4) {
            response.sendRedirect("loginController?nosession=y");
        }
    %>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard - Client</title>
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
        <%
            Project prj = new Project();
            Client cli = new Client();
        %>
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
    <body class="bg-white">
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
        <div style="visibility: hidden;" id="log"></div>

        <div class="flex bg-gray w-full px-4 md:px-16">
            <div class="flex w-8/12 py-2">
                <div class="flex items-center justify-center mr-2 w-10 p-1 rounded bg-white">
                    <!-- <img src='imgs/<%= session.getAttribute("profPic")%>' height="40px" width="40px" class="rounded">  -->
                    <img src='../imgs/logos/Logo-Fondo.jpg' class="object-contain"> 
                </div>
                <div class="flex items-center">
                    <label class="font-bold text-white text-xl"><%= session.getAttribute("usrOnSess")%> <%= request.getSession().getAttribute("Id")%> | <%= session.getAttribute("rolName")%></label>
                </div>
            </div>
            <div class="flex justify-end w-4/12 py-2">
                <div class="flex items-center justify-center">
                    <button id="btnLogout" class="bg-blue-500 hover:bg-blue-700 font-bold text-xs md:text-sm text-white p-2 rounded-lg">Cerrar Sesión</button><br>
                </div>
            </div>
        </div>


        <br>
        <table border="1" border="black"class=''>
            <tr>
                <th>Project id</th>
                <th>Project name</th>
                <th>Project description</th>
                <th>Starts</th>
                <th>Ends</th>
                <th>address</th>

                <th>Company</th>
                <th>Status</th>
                <th>Action</th>

            </tr>
            <%
                List<Project> lst2 = prj.showPrjByCli((Integer) session.getAttribute("Id"));
                for (Project p : lst2) {
            %>
            <tr>
                <td><%= p.getId()%></td>
                <td><%= p.getName()%></td>
                <td><%= p.getDescription()%></td>
                <td><%= p.getStarted_date()%></td>
                <td><%= p.getFinish_date()%></td>
                <td><%= p.getAddress()%></td>

                <td><%= cli.getClient((Integer) session.getAttribute("usrId")).getCompany_name()%></td>
                <td><%= p.getStatus()%></td>
                <td>
                    <a data-scroll href="#map" ><button  class="btn btn-outline-success" onclick="myLoad('<%= p.getId()%>', '<%= p.getName()%>', '<%= p.getDescription()%>',
                                            '<%= p.getStarted_date()%>', '<%= p.getFinish_date()%>', '<%= p.getAddress()%>',
                                            '<%= p.getLat()%>', '<%= p.getLng()%>', '<%= p.getClient_id()%>', '<%= p.getStatus()%>');
                                    ruta()">
                            *Select*
                        </button></a>
                </td>
            </tr>
            <%
                }
            %>
        </table>
        <br>
        <p>go back to <a href="clientDetalles.jsp">Ver el recurso humano y maquinaria asignada -></a></p>








    </body>
</html>

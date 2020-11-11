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
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

        <%
            HttpSession sesion = request.getSession();
            String rol;
            if (sesion.getAttribute("rolName") == null) {
                response.sendRedirect("loginController?nosession=y");
            }
        %>
    <label>Role: <%= session.getAttribute("rolName")%></label>
    <label> Logged as: <%= session.getAttribute("usrOnSess")%></label>
    <img src="imgs/<%= session.getAttribute("profPic")%>" height="40px" width="40px">
    <a href="loginController?logout=y">Log out</a>
    <%
        Project prj = new Project();
        Client cli = new Client();
    %>

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
    <title>Project</title>
    <script type="text/javascript" src="jquery.js"></script>
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
<body>
<center>
    <h1>Gestionar Proyectos</h1>
</center>

<div id="map"></div>

<br>
<div class="contaner">
    <div class="row">
        <div class="col-md-1"></div>
        <br>
        <div class="col-md-1">
            <input type="button" value="Add a Mark" id="add-mark" onclick="var param = 0; agregarPunto(param);" class="btn btn-success">
        </div>
        <div class="col-md-1">
            <input type="button" value="Edit Mark" id="edit-mark" disabled="disabled" onclick="disa();initMap();var param = 0; agregarPunto(param);" class="btn btn-warning">
        </div>
        <div class="col-md-5"></div>
        <div class="col-md-1">
            <form method="POST" action="projectController">
                <input type="submit" value="Recurso Humano y Maquinaria ->" id="maquinaria" disabled="disabled" name="btnMaquinaria" class="btn btn-outline-info">
                <input type="hidden" name="nameHidden" id="nameHidden">
                <input type="hidden" name="idHidden"  id="idHidden">
                <input type="hidden" name="statusHidden"  id="statusHidden">
                <input type="hidden" name="dsHidden"  id="dsHidden">
                <input type="hidden" name="dfHidden"  id="dfHidden">
            </form>
        </div>
                </div>

                </div>
                <br>
                <div class="container">
                    <form id="frmMain" action="projectController" method="POST">
                        <input type="hidden" name="txtId" id="txtId" class='form-control' value="0"/>


                        <input type="hidden" id="latLng">      
                        <input type="hidden" id="oculto">
                        <input type="hidden" required placeholder="Latitud" name="my_lat"  id="my_lat">
                        <input type="hidden" required placeholder="Longitud" name="my_lng" id="my_lng" >
                        <div class="row">
                            <div class="col-md-6">
                                <label>Project name</label>
                                <input type="text" name="txtName" id="txtName" class='form-control' required/>
                            </div>
                            <div class="col-md-6">
                                <label>Project description</label>
                                <textarea class="form-control" name="txtDesc" id="txtDesc" placeholder="Description" required rows="3"></textarea>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 col-ms-12">
                                <label>Project starts on</label>
                                <input type="date" name="dapStart" id="dapStart" class='form-control' min='2020-11-01' max='2021-12-31' required/>
                            </div>
                            <div class="col-md-6 col-ms-12">
                                <label>Project ends on</label>
                                <input type="date" name="dapFinish" id="dapFinish" class='form-control' min='2020-11-01' max='2021-12-31' required/>
                            </div>
                        </div>
                        <div class="row" id="ismael">
                            <div class="col-md-6 col-ms-12">
                                <label>Address</label>
                                <textarea class="form-control" name="txtAddress" id="txtAddress" placeholder="Address" required rows="3"></textarea>
                            </div>
                            <div class="col-md-6 col-ms-12">
                                <label>Company's project</label>
                                <select name="slctClient" id="slctClient" class='form-control'>
                                    <%
                                        List<Client> lst = cli.showClient();
                                        for (Client c : lst) {
                                    %>
                                    <option value="<%= c.getId()%>"><%= c.getCompany_name()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>    
                        </div>
                        <div class="row">
                            <div class="col-md-6 col-ms-12">
                                <label>Project State</label>
                                <input type="text" name="txtStatus" id="txtStatus" class='form-control' readonly/>
                            </div>
                        </div>


                        <br>


                        <input type="submit" name="btnCreate" id="btnCreate" value="Create" class="btn btn-outline-success"/>
                        <input type="submit" name="btnUpdate" id="btnUpdate" value="Update" class="btn btn-outline-warning"/>
                        <input type="submit" name="btnDelete" id="btnDelete" value="Delete" class="btn btn-outline-danger"/>
                    </form>
                    <button class="btn btn-outline-info"  onclick="disa();initMap();var param = 0; agregarPunto(param);reset()"  >New</button>
                    <br>
                    <table class='table table-hover table-dark'>
                        <tr>
                            <th>Project id</th>
                            <th>Project name</th>
                            <th>Project description</th>
                            <th>Starts</th>
                            <th>Ends</th>
                            <th>address</th>
                            <th>Lat</th>
                            <th>Lng</th>
                            <th>Company</th>
                            <th>Status</th>
                            <th>Action</th>

                        </tr>
                        <%
                            List<Project> lst2 = prj.showPrj();
                            for (Project p : lst2) {
                        %>
                        <tr>
                            <td><%= p.getId()%></td>
                            <td><%= p.getName()%></td>
                            <td><%= p.getDescription()%></td>
                            <td><%= p.getStarted_date()%></td>
                            <td><%= p.getFinish_date()%></td>
                            <td><%= p.getAddress()%></td>
                            <td><%= p.getLat()%></td>
                            <td><%= p.getLng()%></td>
                            <td><%= cli.getClient(p.getClient_id()).getCompany_name()%></td>
                            <td><%= p.getStatus()%></td>
                            <td>
                                <a data-scroll href="#map" ><button  class="btn btn-outline-success" onclick="myLoad('<%= p.getId()%>', '<%= p.getName()%>', '<%= p.getDescription()%>',
                                        '<%= p.getStarted_date()%>', '<%= p.getFinish_date()%>', '<%= p.getAddress()%>',
                                        '<%= p.getLat()%>', '<%= p.getLng()%>', '<%= p.getClient_id()%>','<%= p.getStatus()%>');ruta()">
                                        *Select*
                                    </button></a>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </table>
                    <br>
                    <p>go back to <a href="index.jsp">index</a></p>
                </div>
                <!--Archivo local Javascript Toda la programación en este archivo-->
                <script type="text/javascript" src="js/googleMaps.js"></script>
                <!--Archivo de GoogleMaps-->
                <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCbUDtVGNnPGBMF4Acpf0CbJYmLspmq-Ps&callback=initMap" async defer></script>

                <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
                </body>
                </html>

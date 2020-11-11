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
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title><%= session.getAttribute("name_attr")%></title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <style>
            .tr{
                color:red;
            }
        </style>
    </head>
    <body>
        <%
            HttpSession sesion = request.getSession();
            String rol;
            if (sesion.getAttribute("rolName") == null) {
                response.sendRedirect("loginController?nosession=y");
            }
            Project prj = new Project();
            Employees emp = new Employees();
            Equipment equ = new Equipment();
            Working wrk = new Working();
            Position pos = new Position();
            InUse inu = new InUse();
            DecimalFormat df = new DecimalFormat("##.##");
        %>
        <header>
            <div class="collapse bg-dark" id="navbarHeader">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-8 col-md-7 py-4">
                            <h4 class="text-white">Vista para cliente o admin</h4>
                            <p class="text-white">Detalles de costos de proyecto</p>
                        </div>
                        <div class="col-sm-4 offset-md-1 py-4">
                            <h4 class="text-white">CRUDS</h4>
                            <ul class="list-unstyled">
                                <li><a href="working.jsp" class="text-white">empleados en proyecto</a></li>
                                <li><a href="inuse.jsp" class="text-white">Maquinaria en proyecto</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="navbar navbar-dark bg-dark shadow-lg">
                <div class="container d-flex justify-content-between">
                    <a href="index.jsp" class="navbar-brand d-flex align-items-center">
                        <img class="bd-placeholder-img rounded border border-dark" src="imgs/logos/Logo.png" width="40" height="40" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" aria-hidden="true" class="mr-2" viewBox="0 0 24 24" focusable="false" role="img"></img>


                        <strong>&nbsp;<%= session.getAttribute("usrOnSess")%> || <%= session.getAttribute("rolName")%></strong>
                    </a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarHeader" aria-controls="navbarHeader" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                        <label>menu</label>
                    </button>
                </div>
            </div>
        </header>

        <main role="main">

            <section class="jumbotron text-center">
                <div class="container">
                    <h1>Detalles de proyecto</h1>
                    <p class="lead text-muted">Personal, maquinaria, costos y duracion</p>
                    <center>

                        <div class="col-5">
                            <h2><%= session.getAttribute("name_attr")%></h2>
                            <a>De (<%= session.getAttribute("dIni")%>) hasta (<%= session.getAttribute("dFin")%>)</a>
                            <h5 class="tr"><%= session.getAttribute("status_attr")%></h5>
                    </center>
                </div>
            </section>
            <div class="album py-5 bg-light">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-md-6">
                            <div class="card mb-6 shadow-lg">
                                <a href="#">
                                    <img class="bd-placeholder-img rounded border border-dark" width="100%" height="225" src="https://www.fminet.com/wp-content/uploads/2018/02/zurich-web.jpg" focusable="false" role="img"></img>
                                </a>
                                <div class="card-body rounded border border-dark">
                                    <h3><p class="text-center">PERSONAL</p></h3>
                                    <p class="card-text">Personal en este proyecto</p>


                                    <div  style="overflow-x: scroll;">
                                        <table   class='table table-hover'>
                                            <tr class="thead-dark">
                                                <th>Nombre</th>
                                                <th>Cargo</th>
                                                <th>desde</th>
                                                <th>hasta</th>
                                                <th>dias en project</th>
                                                <th>sal mensual en proj</th>
                                                <th>costo en project</th>
                                            </tr>
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
                                                <td><%= name%></td>
                                                <td><%= pos.getPos((emp.getEmp(w.getEmployee_id()).getPosition_id())).getName()%></td>
                                                <td><%= w.getIn_pro_from()%></td>
                                                <td><%= w.getIn_pro_to()%></td>
                                                <td><%= w.daysIn(w.getIn_pro_from(), w.getIn_pro_to())%></td>
                                                <td>$<%= df.format(w.getCost())%></td>
                                                <%
                                                    total = (w.daysIn(w.getIn_pro_from(), w.getIn_pro_to())) * (w.getCost() / 30);
                                                    totalF = totalF + total;


                                                %>
                                                <td>$<%= df.format(total)%></td>
                                                <%
                                                    }
                                                %>

                                            </tr>
                                            <tr>
                                                <th colspan="6">Total</th>
                                                <th>$<%= df.format(totalF)%></th>
                                            </tr>
                                        </table>
                                    </div>

                                    <%
                                        if(!session.getAttribute("status_attr").equals("finalizado")){
                                    %>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <p><a class="btn btn-sm btn-outline-secondary" href="workingDetalle.jsp" role="button">go to CRUD &raquo;</a></p>
                                        <small class="text-muted">CRUD</small>
                                    </div>
                                    <%
                                      }
                                    %>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card mb-6 shadow-lg justify-content-center">
                                <a href="inuse.jsp">
                                    <img class="bd-placeholder-img rounded border border-dark" width="100%" height="225" src="https://imcotecmaquinaria.cl/wp-content/uploads/2018/09/Que-maquinaria-pesada-es-mejor.jpg" focusable="false" role="img"></img>
                                </a>
                                <div class="card-body rounded border border-dark" style="overflow-x: scroll;">
                                    <h3><p class="text-center">MAQUINARIA</p></h3>
                                    <p class="card-text">equipo y maquinaria activa en project</p>
                                    <table class='table table-hover'>
                                        <tr class="thead-dark">
                                            <th>maquinaria</th>
                                            <th>Uni en proy</th>
                                            <th>desde</th>
                                            <th>hasta</th>
                                            <th>dias en project</th>
                                            <th>Costo diario (Unitario)</th>
                                            <th>costo en project</th>
                                        </tr>
                                        <%
                                            idHere = (Integer) session.getAttribute("id_attr");

                                            List<InUse> lst3 = inu.showInUsebyPro(idHere);
                                            double totalM = 0;
                                            double totalFM = 0;
                                            for (InUse i : lst3) {
                                                String name = equ.getEqu(i.getEquipment_id()).getName() + " " + equ.getEqu(i.getEquipment_id()).getModel();
                                        %>
                                        <tr>
                                            <td><%= name%></td>
                                            <td><%= i.getEquipment_quantity()%></td>
                                            <td><%= i.getIn_pro_from()%></td>
                                            <td><%= i.getIn_pro_to()%></td>
                                            <td><%= wrk.daysIn(i.getIn_pro_from(), i.getIn_pro_to())%></td>
                                            <td><%= df.format(i.getCost())%></td>
                                            <%
                                                //here we need to calculate total cost per truck
                                                totalM = (i.daysInUse(i.getIn_pro_from(), i.getIn_pro_to())) * (i.getCost() * i.getEquipment_quantity());
                                                totalFM = totalFM + totalM;
                                            %>
                                            <td>$<%= df.format(totalM)%></td>
                                            <%
                                                }
                                            %>

                                        </tr>
                                        <tr>
                                            <th colspan="6">Total</th>
                                            <th>$<%= df.format(totalFM)%></th>
                                        </tr>
                                    </table>
                                    <%
                                        if(!session.getAttribute("status_attr").equals("finalizado")){
                                    %>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <p><a class="btn btn-sm btn-outline-secondary" href="inUseDetalle.jsp" role="button">go to CRUD&raquo;</a></p>
                                        <small class="text-muted">CRUD</small>
                                    </div>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <hr class="featurette-divider">
        <footer class="container text-center">
            <p>&copy; Quintanilla Bernabe || daute project 2020 <a class="tr" href="project.jsp">Projects</a></p>
        </footer>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
    </body>
</html>

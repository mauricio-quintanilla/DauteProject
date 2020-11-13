<%-- 
    Document   : reptest
    Created on : Nov 8, 2020, 10:25:05 PM
    Author     : demon
--%>

<%@page import="com.model.Employees"%>
<%@page import="com.model.Finanzas"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.List"%>
<%@page import="com.model.Project"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Reportes - CONSTRU SV</title>
        <!-- Icon -->
        <link rel="icon" href="imgs/logos/Logo.png" type="image/png">
        <!-- Tailwind -->
        <link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet">
        <!-- CSS -->
        <link rel="stylesheet" href="css/style.css">
        <!-- JQuery -->
        <script type="text/javascript" src="jquery.js"></script>
        <!-- SweetAlert2 -->
        <script type="text/javascript" src="js/sweetalert2.all.min.js"></script>

        <script src="https://code.highcharts.com/highcharts.js"></script>
        <script src="https://code.highcharts.com/modules/xrange.js"></script>
        <script src="https://code.highcharts.com/modules/exporting.js"></script>
        <script src="https://code.highcharts.com/modules/accessibility.js"></script>
        <style>
            #container {
                height: 300px;
            }

            .highcharts-figure, .highcharts-data-table table {
                min-width: 320px; 
                max-width: 800px;
                margin: 1em auto;
            }

            .highcharts-data-table table {
                font-family: Verdana, sans-serif;
                border-collapse: collapse;
                border: 1px solid #EBEBEB;
                margin: 10px auto;
                text-align: center;
                width: 100%;
                max-width: 500px;
            }
            .highcharts-data-table caption {
                padding: 1em 0;
                font-size: 1.2em;
                color: #555;
            }
            .highcharts-data-table th {
                font-weight: 600;
                padding: 0.5em;
            }
            .highcharts-data-table td, .highcharts-data-table th, .highcharts-data-table caption {
                padding: 0.5em;
            }
            .highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even) {
                background: #f8f8f8;
            }
            .highcharts-data-table tr:hover {
                background: #f1f7ff;
            }
        </style>
        <script language="JavaScript" type="text/javascript">
            function checkDates() {
                var dateS = document.getElementById('datFrom').value;
                var dateE = document.getElementById('datTo').value;
                var dateSP = new Date(dateS);
                var dateEP = new Date(dateE);
                if ( dateEP < dateSP ) { 
                    alert('fecha fin debe ser mayor a fecha inicio');
                    return false;
                }
                else
                    return true;
            }
        </script>

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
                        $('#log').append("<a id='home-link' href='loginController?logout=y'></a>");
                        document.getElementById("home-link").click();

                    }
                });

            });
        });
        </script>


</head>
<%
    HttpSession sesion = request.getSession();
    response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader("Expires", 0);
    if (sesion.getAttribute("rolName") == null) {
        response.sendRedirect("loginController?nosession=y");
    }
    Project prj = new Project();
    Finanzas fnz = new Finanzas();
    Employees emp = new Employees();
    List<Project> lst2 = prj.showPrj();
    List<Finanzas> lstF = fnz.showFnzCost();
%>
    <body class="bg-black">

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
                <!-- <a href="loginController?logout=y" class="bg-blue-500 hover:bg-blue-700 font-bold text-xs md:text-sm text-white p-2 rounded-lg">Cerrar Sesión</a><br> -->
                <button id="btnLogout" class="bg-blue-500 hover:bg-blue-700 font-bold text-xs md:text-sm text-white p-2 rounded-lg">Cerrar Sesión</button><br>
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
            <h1 class="text-white text-4xl font-bold text-center">Reportes</h1>
        </div>
        <div class="flex justify-center">
            <a href="index.jsp" class="text-center font-bold text-lg text-blue-500 hover:underline">← Regresar</a>
        </div>

        <div class="text-white flex justify-center mt-4">
            <div>
                <div class="text-white flex justify-center mb-4">
                    <h2 class="text-white text-2xl font-bold text-center">Ver Reportes</h2>
                </div>
                <select name="sel" id="sel" class="text-black font-bold text-lg p-2 rounded" onChange="pagoOnChange(this)">
                    <option value="1">Historial de Proyectos</option>
                    <option value="2">Ganancias y Costos en Proyectos</option>
                    <option value="3">Proyectos Activos en un rango de Fechas</option>
                    <option value="4">Proyectos Finalizados en una rango de Fechas</option>
                    <option value="5">Boletas de Pago</option>
                </select>
            </div>
        </div>


        <div class="hidden" id="form">
        <div class="text-white flex justify-center w-full mt-4">
            <form method="POST" id="frmRep1" onsubmit="return checkDates()" target="_blank">

                <div class="flex flex-wrap">
                    <div class="flex justify-center w-full md:w-1/2 p-4">
                        <div>
                            <label>Fecha Inicio Rango: </label><br>
                            <input type="date" name="datFrom" id="datFrom" class="text-black font-bold text-lg p-2 rounded" min='' max='' required/><br>
                        </div>
                    </div>
                    <div class="flex justify-center w-full md:w-1/2 p-4">
                        <div>
                            <label>Fecha Finalización Rango: </label><br>
                            <input type="date" name="datTo" id="datTo" class="text-black font-bold text-lg p-2 rounded" min='' max=''required/> <br>
                        </div>

                    </div>
                </div>

                    <div class="mt-8">
                        <div class="flex justify-center w-full p-2">
                            <div id="activos">
                                <input formaction="rep11.jsp?active=y" type="submit" class="text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400" value="Generar Reporte Proyectos Activos"/>
                            </div>
                            <div class="hidden" id="finalizados">
                                <input formaction="rep11.jsp?fin=y" type="submit" class="text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400" value="Generar Reporte Proyectos Finalizados"/>
                            </div>
                        </div>
                    </div>
                </div>
                </form>
        </div>
    </div>


    <div id="historial">
        <div class="w-full flex justify-center mt-8">
            <div class="container tc bg-white p-1 md:p-4 rounded-lg w-full md:w-8/12">
                <figure class="highcharts-figure">
                    <div id="container"></div>
                    <p class="highcharts-description">
                        <hr color="black">
                    </p>
                </figure>
                <script>
                    Highcharts.chart('container', {chart: {type: 'xrange'},
                        title: {text: 'Nuestros proyectos a lo largo de la historia'},accessibility: 
                            {point: {descriptionFormatter: function (point) {
                                        var ix = point.index + 2,
                                        category = point.yCategory,
                                        from = new Date(point.x),
                                        to = new Date(point.x2);
                                        return ix + '. ' + category + ', ' + from.toDateString() +
                                            ' to ' + to.toDateString() + '.';
                                    }
                                }
                            },
                            xAxis: {type: 'datetime'},yAxis: {title: {text: ' proyectos'},categories: [
                                <%
                                    for (Project p : lst2) {
                                %>
                                    '<%= p.getName()%><br>-(<%= p.getStatus()%>)',
                                <%
                                    }
                                %>
                            ],reversed: true},
                            series: [{name: 'Historial de proyectos',borderColor: 'black',pointWidth: 25,
                                data: [
                                <%
                                    int ixta = 0;
                                    for (Project p : lst2) {
                                        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                                        Date rdIni = new SimpleDateFormat("yyyy-MM-dd").parse(p.getStarted_date());
                                        Date rdFin = new SimpleDateFormat("yyyy-MM-dd").parse(p.getFinish_date());
                                        Calendar i = Calendar.getInstance(); 
                                        Calendar f = Calendar.getInstance(); 
                                        i.setTime(rdIni);                
                                        f.setTime(rdFin);
                                        i.add(Calendar.MONTH, -1);
                                        f.add(Calendar.MONTH, -1);
                                %>
                                        {x: Date.UTC(<%= df.format(i.getTime()).replaceAll("-", ", ") %>),
                                         x2: Date.UTC(<%= df.format(f.getTime()).replaceAll("-", ", ") %>),
                                         y: <%= ixta%>,
                                         partialFill: <%= p.prcntCalc(p.getStarted_date(), p.getFinish_date()) %>},
                                <%
                                        ixta++;
                                    };
                                %>
                                    ],
                                    dataLabels: {enabled: true}
                            }]
                    });
                </script>   
            </div>
        </div>
    </div>
    <div class="hidden" id="ganancias">
        <div class="w-full flex justify-center mt-8">
            <div class="container tc bg-white p-1 md:p-4 rounded-lg w-full md:w-8/12">
                <figure class="highcharts-figure">
                    <div id="container2"></div>
                    <p class="highcharts-description">
                       <hr color="black">
                    </p>
                </figure>
                <script>
                    Highcharts.chart('container2', {
                        chart: {
                          type: 'column'
                        },
                        title: {
                          text: 'Inversion, Costos y Ganancias en Proyectos'
                        },
                        subtitle: {
                          text: 'Reporte de departamento de finanza Constru SV'
                        },
                        xAxis: {
                          categories: [
                            <%
                                for (Finanzas f : lstF) {
                            %>
                                '<%= f.getName()%>',
                            <%
                                }
                            %>
                          ],
                          crosshair: true
                        },
                        yAxis: {
                          min: 0.01,
                          title: {
                            text: 'moneda (USD)'
                          }
                        },
                        tooltip: {
                          headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                          pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                            '<td style="padding:0"><b>\\${point.y:.1f}</b></td></tr>',
                          footerFormat: '</table>',
                          shared: true,
                          useHTML: true
                        },
                        plotOptions: {
                          column: {
                            pointPadding: 0.2,
                            borderWidth: 0
                          }
                        },
                        series: [{
                          name: 'Ganancias',
                          data: [
                                    <%
                                        for (Finanzas f : lstF) {
                                    %>
                                        <%= f.getProfit()%>,
                                    <%
                                        }
                                    %>
                                ]
                        }, {
                          name: 'Costo(RH) ConstruSV',
                          data: [
                                    <%
                                        for (Finanzas f : lstF) {
                                    %>
                                    <%= f.getInv_per()%>,
                                    <%
                                        }
                                    %>
                                ]

                        }, {
                          name: 'Costo(Maq) ConstruSV',
                          data: [
                                    <%
                                        for (Finanzas f : lstF) {
                                    %>
                                    <%= f.getInv_maq()%>,
                                    <%
                                        }
                                    %>
                                ]

                        },{
                          name: 'Costo Ttl ConstruSV',
                          data: [
                                    <%
                                        for (Finanzas f : lstF) {
                                    %>
                                    <%= f.getInv_maq() + f.getInv_per() %>,
                                    <%
                                        }
                                    %>
                                ]

                        },{
                          name: 'Costo(RH) Cliente',
                          data: [
                                    <%
                                        for (Finanzas f : lstF) {
                                    %>
                                    <%= f.getCosto_per()%>,
                                    <%
                                        }
                                    %>
                                ]

                        }, {
                          name: 'Costo(Maq) Cliente',
                          data: [
                                    <%
                                        for (Finanzas f : lstF) {
                                    %>
                                    <%= f.getCosto_maq()%>,
                                    <%
                                        }
                                    %>
                                ]

                        }, {
                          name: 'Costo Ttl Cliente',
                          data: [
                                    <%
                                        for (Finanzas f : lstF) {
                                    %>
                                    <%= f.getCosto_per() + f.getCosto_maq()%>,
                                    <%
                                        }
                                    %>
                                ]

                        }]
                      });
                </script>
            </div> 
        </div>
    </div>

    <div class="hidden" id="boleta">
        <div class="text-white flex justify-center w-full md:w-auto mt-4">
        <form action="repBoleta.jsp" method="GET">
            <label for="" class="text-2xl font-bold">Generar Boleta de Pago de Empleado:</label><br>
            <select name="selectB" id="selectB" class="text-black font-bold text-lg p-2 rounded w-full">
                <%
                    List<Employees> lst = emp.showEmp();
                    for (Employees e: lst) {
                %>
                <option value="<%= e.getId()%>"><%= e.getFirst_name()+" "+e.getLast_name() %></option>
                <%
                    }
                %>

            </select>
            <div class="mt-4">
                <div class="md:flex md:justify-center w-full p-2">
                    <input type="submit" class="text-black font-bold text-lg p-1 rounded mr-2 cursor-pointer hover:bg-gray-400" value="Generar"/>
                </div>
            </div>
        </form>
        </div>
    </div> 
    
                
            

        <!-- Navbar -->
    <script src="js/navbar.js"></script>

    <script>
        function pagoOnChange(sel) {
            
            if (sel.value==1){
                $('#form').addClass('hidden');
                $('#ganancias').addClass('hidden');
                $('#boleta').addClass('hidden');
                $('#historial').removeClass('hidden');
    
            }
            if (sel.value==2){
                $('#historial').addClass('hidden');
                $('#form').addClass('hidden');
                $('#boleta').addClass('hidden');
                $('#ganancias').removeClass('hidden');
    
            }
            if (sel.value==3){
                $('#ganancias').addClass('hidden');
                $('#historial').addClass('hidden');
                $('#finalizados').addClass('hidden');
                $('#boleta').addClass('hidden');
                $('#activos').removeClass('hidden');
                $('#form').removeClass('hidden');
            }
            if (sel.value==4){
                $('#ganancias').addClass('hidden');
                $('#historial').addClass('hidden');
                $('#activos').addClass('hidden');
                $('#boleta').addClass('hidden');
                $('#finalizados').removeClass('hidden');
                $('#form').removeClass('hidden');
            }
            if (sel.value==5){
                $('#historial').addClass('hidden');
                $('#form').addClass('hidden');
                $('#ganancias').addClass('hidden');
                $('#boleta').removeClass('hidden');
            }
            
        }
    </script>
    </body>
</html>

<%-- 
    Document   : reptest
    Created on : Nov 8, 2020, 10:25:05 PM
    Author     : demon
--%>

<%@page import="java.util.List"%>
<%@page import="com.model.Project"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE>
<html lang="es">
    <head>
        <title>R E P O R T S</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1">
        <link rel="stylesheet" href="">

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript" src="sweetalert2.all.min.js"></script>
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
        <%
            Project prj = new Project();
            List<Project> lst2 = prj.showPrj();
        %>
    </head>

    <body>
        <section>
            <div class="container">
                <div class="jumbotron jumbotron-fluid">
                    <div class="container tc">
                        <div>
                            <h1 class="display-4">Reports</h1>
                        </div>
                        <div>
                            <p>Reports</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="container tc">
                <label>ver proyectos entre un rango de fechas</label>
                <form action="" method="POST" id="frmRep1">
                <div class="form-row">
                    <div class="col-6">
                        <label>desde</label>
                        <input type="date" name="datFrom" id="datFrom" class='form-control' min='' max=''/>
                        <label>hasta</label>
                        <input type="date" name="datTo" id="datTo" class='form-control' min='' max=''/>
                        <br>
                        <input formaction="rep11.jsp" type="submit" name="btnRep1" id="btnRep1" class='btn btn-outline-info' value="ver reporte 1"/>
                    </div>
                </div>
                </form>
            </div>
            <div class="container tc">
                <figure class="highcharts-figure">
                    <div id="container"></div>
                    <p class="highcharts-description">
                        some other description
                    </p>
                </figure>
                <script>
                    Highcharts.chart('container', {
                    chart: {
                    type: 'xrange'
                    },
                            title: {
                            text: 'Proyectos en linea de tiempo'
                            },
                            accessibility: {
                            point: {
                            descriptionFormatter: function (point) {
                            var ix = point.index + 1,
                                    category = point.yCategory,
                                    from = new Date(point.x),
                                    to = new Date(point.x2);
                            return ix + '. ' + category + ', ' + from.toDateString() +
                                    ' to ' + to.toDateString() + '.';
                            }
                            }
                            },
                            xAxis: {
                            type: 'datetime'
                            },
                            yAxis: {
                            title: {
                            text: ' proyectos'
                            },
                                    categories: [
                    <%
                                    for (Project p : lst2) {
                    %>
                                    '<%= p.getName()%>',
                    <%
                                    }
                    %>
                                    //categories: ['proyecto 1', 'proyecto 2', 'proyecto 3',
                                    ],
                                    reversed: true
                            },
                            series: [{
                            name: 'Historial de proyectos',
                                    // pointPadding: 0,
                                    // groupPadding: 0,
                                    borderColor: 'black',
                                    pointWidth: 25,
                                    data: [
                    <%
                                                int ixa = 0;
                                                for (Project p : lst2) {
                    %>
                                    {x: Date.UTC(<%= p.getStarted_date().replaceAll("-", ", ")%>),
                                            x2: Date.UTC(<%= p.getFinish_date().replaceAll("-", ", ")%>),
                                            y: <%= ixa%>},
                    <%
                                                    ixa++;
                                                };
                    %>
                                    ],
                                    dataLabels: {
                                    enabled: true
                                    }
                            }]


                    });
                </script>

            </div>
            <div class="container tc">
                <blockquote>
                    <footer class="blockquote-footer">mauricio quintanilla
                        <cite title="Source Title">2020</cite>
                        <p>go back to <a href="index.jsp">index</a></p>
                    </footer>
                </blockquote>
            </div>
        </section>
    </body>
</html>
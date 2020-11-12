<%-- 
    Document   : reptest
    Created on : Nov 8, 2020, 10:25:05 PM
    Author     : demon
--%>

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
        <%
            Project prj = new Project();
            Finanzas fnz = new Finanzas();
            List<Project> lst2 = prj.showPrj();
            List<Finanzas> lstF = fnz.showFnzCost();
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
                <form method="POST" id="frmRep1" onsubmit="return checkDates()" target="_blank">
                <div class="form-row justify-content-center">
                    <div class="col-3">
                        <label>desde</label>
                        <input type="date" name="datFrom" id="datFrom" class='form-control' min='' max='' required/>
                    </div>    
                    <div class="col-3">
                        <label>hasta</label>
                        <input type="date" name="datTo" id="datTo" class='form-control' min='' max=''required/>
                    </div>
                </div>
                    <br>
                <div class="form-row justify-content-center">
                    <div class="col-8">
                        <input formaction="rep11.jsp?active=y" type="submit" class='btn btn-outline-success' value="ver projectos activos en rango de fechas"/>
                        <input formaction="rep11.jsp?fin=y" type="submit" class='btn btn-outline-warning' value="ver projectos finalizados en rango de fechas"/>
                    </div>
                </div>
                </form>
            </div>
            
            <div class="container tc">
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
            <div class="container tc">
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

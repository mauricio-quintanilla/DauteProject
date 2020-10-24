<%-- 
    Document   : inuse
    Created on : Oct 23, 2020, 2:54:38 AM
    Author     : demon
--%>

<%@page import="java.util.List"%>
<%@page import="com.model.Equipment"%>
<%@page import="com.model.Project"%>
<%@page import="com.model.InUse"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

        <%
            InUse inu = new InUse();
            Project prj = new Project();
            Equipment equ = new Equipment();
        %>
        <title>Eq in use</title>
        <script type="text/javascript" src="jquery.js"></script>
        <script>
            function myLoad(id, equi, proj, eqQ) {
                $("#txtId").val(id);
                $("#slctEqId").val(equi);
                $("#slctProId").val(proj);
                $("#numEqQu").val(eqQ);
            }
        </script>
    </head>
    <body>
        <h1>Equipment in use CRUD</h1>
        <div class="container">
            <form id="frmMain" action="inUseController" method="POST">
                <div class='col-6'>
                    <input type="hidden" name="txtId" id="txtId" class='form-control' value="0"/>
                    <label>Equipment</label>
                    <select name="slctEqId" id="slctEqId" class='form-control'>
                        <%
                            List<Equipment> lst = equ.showEqu();
                            for (Equipment e : lst) {
                        %>
                        <option value="<%= e.getId()%>"><%= e.getName()%> <%= e.getModel()%></option>
                        <%
                            }
                        %>
                    </select>
                    <label>Project</label>
                    <select name="slctProId" id="slctProId" class='form-control'>
                        <%
                            List<Project> lst2 = prj.showPrj();
                            for (Project p : lst2) {
                        %>
                        <option value="<%= p.getId()%>"><%= p.getName()%></option>
                        <%
                            }
                        %>
                    </select>
                    <label>Num of units to assign </label>
                    <input type="number" name="numEqQu" id="numEqQu" min="1" step="1" class='form-control' required/>
                </div>
                <br>
                <input type="reset" name="btnNew" value="Add/Clear" class="btn btn-outline-info"/>
                <input type="submit" name="btnCreate" id="btnCreate" value="Create" class="btn btn-outline-success"/>
                <input type="submit" name="btnUpdate" id="btnUpdate" value="Update" class="btn btn-outline-warning"/>
                <input type="submit" name="btnDelete" id="btnDelete" value="Delete" class="btn btn-outline-danger"/>
            </form>

            <table border="1" class=''>
                <tr>
                    <th>Record Id</th>
                    <th>Equipment</th>
                    <th>on Project</th>
                    <th>Assigned</th>
                    <th>In Stock</th>
                    <th>action</th>
                </tr>
                <%
                    List<InUse> lst3 = inu.showInUse();
                    for (InUse i : lst3) {
                %>
                <tr>
                    <td><%= i.getId()%></td>
                    <td><%= equ.getEqu(i.getEquipment_id()).getName()%> <%= equ.getEqu(i.getEquipment_id()).getModel()%></td>
                    <td><%= prj.getProyect(i.getProject_id()).getName()%></td>
                    <td><%= i.getEquipment_quantity()%> units</td>
                    <td><%= equ.getEqu(i.getEquipment_id()).getStock()%> units</td>
                    <td><a href="javascript:myLoad('<%= i.getId()%>','<%= i.getEquipment_id()%>',
                           '<%= i.getProject_id()%>','<%= i.getEquipment_quantity()%>')">Select</a></td>
                </tr>
                <%
                    }
                %>
            </table>
            <br>
            <p>go back to <a href="index.jsp">index</a></p>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
    </body>
</html>
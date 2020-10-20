<%-- 
    Document   : position
    Created on : Oct 19, 2020, 11:57:28 PM
    Author     : demon
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="com.model.Position"%>
<%@page import="com.model.Department"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

        <%
            Position pos = new Position();
            Department dpt = new Department();
        %>
        <title>Positions</title>
        <script type="text/javascript" src="jquery.js"></script>
        <script>
            function myLoad(id, name, dptId) {
                $("#txtPosId").val(id);
                $("#txtPosName").val(name);
                $("#slctDept").val(dptId);
            }
        </script>
    </head>
    <body>
        <h1>Positions CRUD</h1>
        <div class="container">
            <form id="frmMain" action="positionController" method="POST">
                <div class='col-6'>
                    <input type="hidden" name="txtPosId" id="txtPosId" class='form-control' value="0"/>
                    <label>Position name</label>
                    <input type="text" name="txtPosName" id="txtPosName" class='form-control' required/>
                    <label>Department</label>
                    <select name="slctDept" id="slctDept" class='form-control'>
                        <%
                            List<Department> lst = dpt.showDept();
                            for (Department d : lst) {
                        %>
                        <option value="<%= d.getId()%>"><%= d.getName()%></option>
                        <%
                            }
                        %>
                    </select>
                </div>
                <br>
                <input type="reset" name="btnNew" value="Add/Clear" class="btn btn-outline-info"/>
                <input type="submit" name="btnCreate" id="btnCreate" value="Create" class="btn btn-outline-success"/>
                <input type="submit" name="btnUpdate" id="btnUpdate" value="Update" class="btn btn-outline-warning"/>
                <input type="submit" name="btnDelete" id="btnDelete" value="Delete" class="btn btn-outline-danger"/>
            </form>

            <table border="1" class=''>
                <tr>
                    <th>id_position</th>
                    <th>name</th>
                    <th>Department</th>
                    <th>Action</th>
                </tr>
                <%
                    List<Position> lst2 = pos.showPos();
                    for (Position p : lst2) {
                %>
                <tr>
                    <td><%= p.getId()%></td>
                    <td><%= p.getName()%></td>
                    <td><%= dpt.getDept(p.getDepartment_id()).getName()%></td>
                    <td><a href="javascript:myLoad('<%= p.getId()%>','<%= p.getName()%>','<%= p.getDepartment_id()%>')">Select</a></td>
                </tr>
                <%
                    }
                %>
            </table>
            <br>
            <p>go back to <a href="index.jsp">index</a></p>
        </div>
        <!-- Option 1: jQuery and Bootstrap Bundle (includes Popper) -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
    </body>
</html>

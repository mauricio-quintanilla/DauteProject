<%-- 
    Document   : department
    Created on : Oct 19, 2020, 1:53:15 AM
    Author     : demon
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
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
            Department dpt = new Department();
        %>
        <title>Department</title>
        <script type="text/javascript" src="jquery.js"></script>
        <script>
            function myLoad(id, name) {
                $("#txtDeptId").val(id);
                $("#txtDeptName").val(name);
            }
            $(document).ready(function () {
                $("#btnNew").on('click', function () {
                    $("#txtDeptName").val("");
                    $("#btnUpdate").attr('disabled', true);
                    $("#btnDelete").attr('disabled', true);
                });
            });
        </script>
    </head>
    <body>
        <h1>Department CRUD</h1>
        <div class="container">
            <form id="frmMain" action="departmentController" method="POST">
                <div class='col-6'>
                    <label id='l1'>Department id</label>
                    <input type="hidden" name="txtDeptId" id="txtDeptId" class='form-control' value="0"/>
                    <label>Department name</label>
                    <input type="text" name="txtDeptName" id="txtDeptName" class='form-control' required/>
                </div>
                <br>
                <input type="reset" name="btnNew" value="Add/Clear" class="btn btn-outline-info"/>
                <input type="submit" name="btnCreate" id="btnCreate" value="Create" class="btn btn-outline-success"/>
                <input type="submit" name="btnUpdate" id="btnUpdate" value="Update" class="btn btn-outline-warning"/>
                <input type="submit" name="btnDelete" id="btnDelete" value="Delete" class="btn btn-outline-danger"/>
            </form>

            <table border="1" class=''>
                <tr>
                    <th>id_department</th>
                    <th>name</th>
                    <th>Action</th>
                </tr>
                <%
                    List<Department> lst = dpt.showDept();
                    for (Department d : lst) {
                %>
                <tr>
                    <td><%= d.getId()%></td>
                    <td><%= d.getName()%></td>
                    <td><a href="javascript:myLoad('<%= d.getId()%>','<%= d.getName()%>')" onclick="$('#btnCreate').attr('disabled', true);">Select</a></td>
                </tr>
                <%
                    }
                %>
            </table>
        </div>
        <!-- Option 1: jQuery and Bootstrap Bundle (includes Popper) -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

        <!-- Option 2: jQuery, Popper.js, and Bootstrap JS
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
        -->
    </body>
</html>

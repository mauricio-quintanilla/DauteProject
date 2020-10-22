<%-- 
    Document   : role
    Created on : Oct 21, 2020, 10:55:47 PM
    Author     : demon
--%>

<%@page import="java.util.List"%>
<%@page import="com.model.Role"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <%
            Role rol = new Role();
        %>
        <title>Role</title>
        <script type="text/javascript" src="jquery.js"></script>
        <script>
            function myLoad(id, name) {
                $("#txtRoleId").val(id);
                $("#txtRoleName").val(name);
            }
        </script>
    </head>
    <body>
        <h1>Role CRUD</h1>
        <div class="container">
            <form id="frmMain" action="roleController" method="POST">
                <div class='col-6'>
                    <input type="hidden" name="txtRoleId" id="txtRoleId" class='form-control' value="0"/>
                    <label>Role name</label>
                    <input type="text" name="txtRoleName" id="txtRoleName" class='form-control' required/>
                </div>
                <br>
                <input type="reset" name="btnNew" value="Add/Clear" class="btn btn-outline-info"/>
                <input type="submit" name="btnCreate" id="btnCreate" value="Create" class="btn btn-outline-success"/>
                <input type="submit" name="btnUpdate" id="btnUpdate" value="Update" class="btn btn-outline-warning"/>
                <input type="submit" name="btnDelete" id="btnDelete" value="Delete" class="btn btn-outline-danger"/>
            </form>

            <table border="1" class=''>
                <tr>
                    <th>id_role</th>
                    <th>name</th>
                    <th>Select</th>
                </tr>
                <%
                    List<Role> lst = rol.showRole();
                    for (Role r : lst) {
                %>
                <tr>
                    <td><%= r.getId()%></td>
                    <td><%= r.getName()%></td>
                    <td><a href="javascript:myLoad('<%= r.getId()%>','<%= r.getName()%>')">Select</a></td>
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
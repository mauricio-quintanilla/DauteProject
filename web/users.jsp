<%-- 
    Document   : users
    Created on : Oct 22, 2020, 1:45:17 AM
    Author     : demon
--%>

<%@page import="java.util.List"%>
<%@page import="com.model.Role"%>
<%@page import="com.model.Users"%>
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
            Users usr = new Users();
            Role roll = new Role();
        %>
        <title>Users</title>
        <script type="text/javascript" src="jquery.js"></script>
        <script>
            function myLoad(id, user_name, email, password, role) {
                $("#txtUsrId").val(id);
                $("#txtUsrName").val(user_name);
                $("#txtUsrEmail").val(email);
                $("#pwdPassword").val(password);
                $("#slctRol").val(role);
            }
        </script>
    </head>
    <body>
        <h1>Users CRUD</h1>
        <div class="container">
            <form id="frmMain" action="usersController" method="POST">
                <div class='col-6'>
                    <input type="hidden" name="txtUsrId" id="txtUsrId" class='form-control' value="0"/>
                    <label>User name</label>
                    <input type="text" name="txtUsrName" id="txtUsrName" class='form-control' required/>
                    <label>User Email</label>
                    <input type="email" name="txtUsrEmail" id="txtUsrEmail" class='form-control' required/>
                    <label>User Password</label>
                    <input type="password" name="pwdPassword" id="pwdPassword" class='form-control' required/>
                    <label>Role</label>
                    <select name="slctRol" id="slctRol" class='form-control'>
                        <%
                            List<Role> lst = roll.showRole();
                            for (Role r : lst) {
                        %>
                        <option value="<%= r.getId()%>"><%= r.getName()%></option>
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
                    <th>user id</th>
                    <th>user name</th>
                    <th>email</th>
                    <th>password</th>
                    <th>role</th>
                    <th>action</th>
                </tr>
                <%
                    List<Users> lst2 = usr.showUsers();
                    for (Users u : lst2) {
                %>
                <tr>
                    <td><%= u.getId()%></td>
                    <td><%= u.getUser_name()%></td>
                    <td><%= u.getEmail()%></td>
                    <td><%= u.getPassword()%></td>
                    <td><%= roll.getRole(u.getRole_id()).getName()%></td>
                    <td><a href="javascript:myLoad('<%= u.getId()%>','<%= u.getUser_name()%>',
                           '<%= u.getEmail()%>','<%= u.getPassword()%>','<%= u.getRole_id()%>')">Select</a></td>
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
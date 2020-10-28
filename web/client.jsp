<%-- 
    Document   : client
    Created on : Oct 22, 2020, 9:03:34 PM
    Author     : demon
--%>

<%@page import="java.util.List"%>
<%@page import="com.model.Client"%>
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
            Client cli = new Client();
        %>
        <title>Client</title>
        <script type="text/javascript" src="jquery.js"></script>
        <script>
            function myLoad(id, name, email, phone, nit, comName, comAdd) {
                $("#txtId").val(id);
                $("#txtName").val(name);
                $("#txtEmail").val(email);
                $("#txtPhone").val(phone);
                $("#txtNit").val(nit);
                $("#txtComName").val(comName);
                $("#txtComAdd").val(comAdd);
            }
        </script>
    </head>
    <body>
        <h1>Client CRUD</h1>
        <div class="container">
            <form id="frmMain" action="clientController" method="POST">
                <div class='col-6'>
                    <input type="hidden" name="txtId" id="txtId" class='form-control' value="0"/>
                    <label>Client Name</label>
                    <input type="text" name="txtName" id="txtName" class='form-control' required/>
                    <label>Client Email</label>
                    <input type="email" name="txtEmail" id="txtEmail" class='form-control' required/>
                    <label>Client Phone Number</label>
                    <input type="text" name="txtPhone" id="txtPhone" class='form-control' required/>
                    <label>NIT</label>
                    <input type="text" name="txtNit" id="txtNit" class='form-control' required/>
                    <label>Company Name</label>
                    <input type="text" name="txtComName" id="txtComName" class='form-control' required/>
                    <label>Company Address</label>
                    <textarea class="form-control" name="txtComAdd" id="txtComAdd" placeholder="Address" required rows="3"></textarea>
                </div>
                <br>
                <input type="reset" name="btnNew" value="Add/Clear" class="btn btn-outline-info"/>
                <input type="submit" name="btnCreate" id="btnCreate" value="Create" class="btn btn-outline-success"/>
                <input type="submit" name="btnUpdate" id="btnUpdate" value="Update" class="btn btn-outline-warning"/>
                <input type="submit" name="btnDelete" id="btnDelete" value="Delete" class="btn btn-outline-danger"/>
            </form>

            <table border="1" class=''>
                <tr>
                    <th>Client Id</th>
                    <th>Client name</th>
                    <th>email</th>
                    <th>phone #</th>
                    <th>NIT</th>
                    <th>Company name</th>
                    <th>Company address</th>
                    <th>Action</th>
                </tr>
                <%
                    List<Client> lst = cli.showClient();
                    for (Client c : lst) {
                %>
                <tr>
                    <td><%= c.getId()%></td>
                    <td><%= c.getName()%></td>
                    <td><%= c.getEmail()%></td>
                    <td><%= c.getPhone_number()%></td>
                    <td><%= c.getNit()%></td>
                    <td><%= c.getCompany_name()%></td>
                    <td><%= c.getCompany_address()%></td>
                    <td><a href="javascript:myLoad('<%= c.getId()%>','<%= c.getName()%>','<%= c.getEmail()%>',
                           '<%= c.getPhone_number()%>','<%= c.getNit()%>','<%= c.getCompany_name()%>','<%= c.getCompany_address()%>')">Select</a></td>
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
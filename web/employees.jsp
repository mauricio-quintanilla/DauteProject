<%-- 
    Document   : employees
    Created on : Oct 21, 2020, 10:54:02 PM
    Author     : demon
--%>

<%@page import="java.util.List"%>
<%@page import="com.model.Employees"%>
<%@page import="com.model.Position"%>
<%@page import="com.model.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

        <%
            Position pos = new Position();
            Employees emp = new Employees();
            Users usr = new Users();
        %>
        <title>Positions</title>
        <script type="text/javascript" src="jquery.js"></script>
        <script>
            function myLoad(id, first, last, dob, address, phone, dui, nit, salary, position, user) {
                $("#txtId").val(id);
                $("#txtName").val(first);
                $("#txtLast").val(last);
                $("#dapDob").val(dob);
                $("#txtAddress").val(address);
                $("#txtPhone").val(phone);
                $("#txtDui").val(dui);
                $("#txtNit").val(nit);
                $("#numSalary").val(salary);
                $("#slctPos").val(position);
                $("#slctUser").val(user);
            }
        </script>
    </head>
    <body>
        <h1>Employees CRUD</h1>
        <div class="container">
            <form id="frmMain" action="employeesController" method="POST">
                <div class='col-6'>
                    <input type="hidden" name="txtId" id="txtId" class='form-control' value="0"/>
                    <label>First name</label>
                    <input type="text" name="txtName" id="txtName" class='form-control' required/>
                    <label>Last name</label>
                    <input type="text" name="txtLast" id="txtLast" class='form-control' required/>
                    <label>Date of Birth</label>
                    <input type="date" name="dapDob" id="dapDob" class='form-control' min='1980-01-01' max='2002-12-31' required/>
                    <label>Address</label>
                    <textarea class="form-control" name="txtAddress" id="txtAddress" placeholder="Address" required rows="3"></textarea>
                    <label>phone</label>
                    <input type="text" name="txtPhone" id="txtPhone" class='form-control' required/>
                    <label>DUI</label>
                    <input type="text" name="txtDui" id="txtDui" class='form-control' required/>
                    <label>NIT</label>
                    <input type="text" name="txtNit" id="txtNit" class='form-control' required/>
                    <label>Salary</label>
                    <input type="number" name="numSalary" id="numSalary" min='0.01' step="0.01" class='form-control' required/>
                    <label>Position</label>
                    <div class="input-group mb-3">
                        <div class="custom-file">
                          <input type="file" class="custom-file-input" name="fileImg" id="fileImg" aria-describedby="inputGroupFileAddon03">
                          <label class="custom-file-label" for="inputGroupFile03">Choose file</label>
                        </div>
                    </div>
                    <select name="slctPos" id="slctPos" class='form-control'>
                        <%
                            List<Position> lst = pos.showPos();
                            for (Position p : lst) {
                        %>
                        <option value="<%= p.getId()%>"><%= p.getName()%></option>
                        <%
                            }
                        %>
                    </select>
                    <label>User</label>
                    <select name="slctUser" id="slctUser" class='form-control'>
                        <%
                            List<Users> lst2 = usr.showUsers();
                            for (Users u : lst2) {
                        %>
                        <option value="<%= u.getId()%>"><%= u.getUser_name()%></option>
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
                    <th>employee_id</th>
                    <th>first name</th>
                    <th>last name</th>
                    <th>date of birth</th>
                    <th>address</th>
                    <th>phone #</th>
                    <th>DUI</th>
                    <th>NIT</th>
                    <th>Salary</th>
                    <th>Position</th>
                    <th>User</th>
                    <th>picture</th>
                    <th>Action</th>
                </tr>
                <%
                    List<Employees> lst3 = emp.showEmp();
                    for (Employees e : lst3) {
                %>
                <tr>
                    <td><%= e.getId()%></td>
                    <td><%= e.getFirst_name()%></td>
                    <td><%= e.getLast_name()%></td>
                    <td><%= e.getDob()%></td>
                    <td><%= e.getAddress()%></td>
                    <td><%= e.getPhone_number()%></td>
                    <td><%= e.getDui()%></td>
                    <td><%= e.getNit()%></td>
                    <td>$<%= e.getSalary()%></td>
                    <td><%= pos.getPos(e.getPosition_id()).getName()%></td>
                    <td><%= usr.getUsers(e.getUser_id()).getUser_name()%></td>
                    <td><%= e.getImage()%></td>
                    <td><a href="javascript:myLoad('<%= e.getId()%>','<%= e.getFirst_name()%>','<%= e.getLast_name()%>',
                           '<%= e.getDob()%>','<%= e.getAddress()%>','<%= e.getPhone_number()%>','<%= e.getDui()%>',
                           '<%= e.getNit()%>','<%= e.getSalary()%>','<%= e.getPosition_id()%>','<%= e.getUser_id()%>','<%= e.getImage()%>')">Select</a></td>
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
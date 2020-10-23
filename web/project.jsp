<%-- 
    Document   : project
    Created on : Oct 23, 2020, 12:20:58 AM
    Author     : demon
--%>

<%@page import="java.util.List"%>
<%@page import="com.model.Client"%>
<%@page import="com.model.Project"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

        <%
            Project prj = new Project();
            Client cli = new Client();
        %>
        <title>Project</title>
        <script type="text/javascript" src="jquery.js"></script>
        <script>
            function myLoad(id, name, desc, start, finish, address, location, client) {
                $("#txtId").val(id);
                $("#txtName").val(name);
                $("#txtDesc").val(desc);
                $("#dapStart").val(start);
                $("#dapFinish").val(finish);
                $("#txtAddress").val(address);
                $("#location").val(location); //check if isma has any maps api key availa
                $("#slctClient").val(client);
            }
        </script>
    </head>
    <body>
        <h1>Project CRUD</h1>
        <div class="container">
            <form id="frmMain" action="projectController" method="POST">
                <div class='col-6'>
                    <input type="hidden" name="txtId" id="txtId" class='form-control' value="0"/>
                    <label>Project name</label>
                    <input type="text" name="txtName" id="txtName" class='form-control' required/>
                    <label>Project description</label>
                    <textarea class="form-control" name="txtDesc" id="txtDesc" placeholder="Description" required rows="3"></textarea>
                    <label>Project starts on</label>
                    <input type="date" name="dapStart" id="dapStart" class='form-control' min='2020-11-01' max='2021-12-31' required/>
                    <label>Project ends on</label>
                    <input type="date" name="dapFinish" id="dapFinish" class='form-control' min='2020-11-01' max='2021-12-31' required/>
                    <label>Address</label>
                    <textarea class="form-control" name="txtAddress" id="txtAddress" placeholder="Address" required rows="3"></textarea>
                    <label>Location</label>
                    <input type="text" name="location" id="location" class='form-control' required/>
                    <label>Company's project</label>
                    <select name="slctClient" id="slctClient" class='form-control'>
                        <%
                            List<Client> lst = cli.showClient();
                            for (Client c : lst) {
                        %>
                        <option value="<%= c.getId()%>"><%= c.getCompany_name()%></option>
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
                    <th>Project id</th>
                    <th>Project name</th>
                    <th>Project description</th>
                    <th>Starts</th>
                    <th>Ends</th>
                    <th>address</th>
                    <th>LatLng</th>
                    <th>Company</th>
                    <th>Action</th>
                </tr>
                <%
                    List<Project> lst2 = prj.showPrj();
                    for (Project p : lst2) {
                %>
                <tr>
                    <td><%= p.getId()%></td>
                    <td><%= p.getName()%></td>
                    <td><%= p.getDescription()%></td>
                    <td><%= p.getStarted_date()%></td>
                    <td><%= p.getFinish_date()%></td>
                    <td><%= p.getAddress()%></td>
                    <td><%= p.getLocation()%></td>
                    <td><%= cli.getClient(p.getClient_id()).getCompany_name()%></td>
                    <td><a href="javascript:myLoad('<%= p.getId()%>','<%= p.getName()%>','<%= p.getDescription()%>',
                           '<%= p.getStarted_date()%>','<%= p.getFinish_date()%>','<%= p.getAddress()%>',
                           '<%= p.getLocation()%>','<%= p.getClient_id()%>')">Select</a></td>
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
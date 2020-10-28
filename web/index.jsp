<%-- 
    Document   : index
    Created on : Oct 19, 2020, 4:22:14 PM
    Author     : demon
--%>
<%@page import="javax.swing.JOptionPane"%>
<%@page session="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <a href="loginController?logout=y">Log out</a>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        <title>Index</title>
    </head>
    <body>
        <h1>go to <a href="department.jsp">department</a> table CRUD</h1>
        <h1>go to <a href="position.jsp">position</a> table CRUD</h1>
        <h1>go to <a href="role.jsp">role</a> table CRUD</h1>
        <h1>go to (TBD) <a href="actions.jsp">actions</a> table CRUD</h1>
        <h1>go to <a href="logs.jsp">logs</a> table CRUD</h1>
        <h1>go to <a href="users.jsp">users</a> table CRUD</h1>
        <h1>go to <a href="employees.jsp">employees</a> table CRUD</h1>
        <h1>go to <a href="working.jsp">Project staff</a> table CRUD</h1>
        <h1>go to <a href="client.jsp">clients</a> table CRUD</h1>
        <h1>go to <a href="equipment.jsp">equipment inventory</a> table CRUD</h1>
        <h1>go to <a href="project.jsp">projects</a> table CRUD</h1>
        <h1>go to <a href="inuse.jsp">equipment in use</a> table CRUD</h1>
        <h1>go to <a href="maptest.jsp">map test</a> table CRUD</h1>
        <h1>HELLOUDA</h1>
    </body>
</html>

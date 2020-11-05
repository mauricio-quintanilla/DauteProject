<%-- 
    Document   : error
    Created on : 04-nov-2020, 17:04:08
    Author     : abc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error</title>
    </head>
    <body>
        <label> <%= session.getAttribute("error")%></label>
    </body>
</html>

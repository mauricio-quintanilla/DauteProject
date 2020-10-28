<%-- 
    Document   : login
    Created on : Oct 27, 2020, 12:51:54 PM
    Author     : demon
--%>
<%@page session="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <title>LogIn</title>
    </head>
    <body>
        <h1>Sign in</h1>
        <div class="container">
            <form id="frmMain" action="loginController" method="POST">
                <div class='col-6'>
                    
                    <label>User</label>
                    <input type="text" name="txtUser" id="txtUser" class='form-control' required/>
                    <label>Password</label>
                    <input type="password" name="pwdPwd" id="pwdPwd" class='form-control' required/>

                <input type="submit" name="btnLogIn" id="btnLogIn" value="LogIn" class="btn btn-outline-success"/>
            </form>
            <br>
            <%
                
            %>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
    </body>
</html>
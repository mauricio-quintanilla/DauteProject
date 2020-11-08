<%-- 
    Document   : login
    Created on : Oct 27, 2020, 12:51:54 PM
    Author     : demon
--%>
<%@page session="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión - CONSTRU SV</title>
    <!-- Icon -->
    <link rel="icon" href="imgs/logos/Logo.png" type="image/png">
    <!-- Tailwind -->
    <link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet">
    <!-- CSS -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="bg-white">
    <div class="flex flex-col-reverse md:flex-row h-screen">
        <div class="w-full md:w-2/5 h-auto md:h-screen bg-white">
            <div class="w-full h-32 sm:h-40 md:h-screen bg-img bg-no-repeat bg-center bg-contain">
            </div>
        </div>
        <divB class="w-full md:w-3/5 h-3/4 flex-grow md:h-screen flex md:rounded-l-xl bg-gray" >
            <div class="flex items-center justify-center w-full h-full">
                <div class="p-4">
                    <span class="text-white text-5xl font-bold">Bienvenido/a</span>
                    <p class="text-white text-xl">Inicia Sesión en tu cuenta</p>
                    <form id="frmMain" action="loginController" method="POST">                        
                        <input type="text" placeholder="Usuario" name="txtUser" class=" mt-4 p-4 rounded-lg w-full" required><br>
                        <input type="password" placeholder="Contraseña" name="pwdPwd" class="mt-4 p-4 rounded-lg w-full" required>
                        <div class="flex justify-center mt-4">
                            <input type="submit" name="btnLogIn" id="btnLogIn" value="Iniciar Sersión" class="px-8 py-4 rounded-full outline-none"/>
                        </div>
                    </form>
                </div>
            </div>
        </divB>
    </div>
</body>
</html>
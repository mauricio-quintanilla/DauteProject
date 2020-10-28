<%-- 
    Document   : maptest
    Created on : Oct 23, 2020, 1:01:45 AM
    Author     : demon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>Simple Map</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css">
    <script type="text/javascript" src="jquery.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap.js"></script>
    <meta charset="utf-8">
    <style>
      /* Tamaño del div del mapa. */
      #map {
        height: 50%;
        width: 50%;
        margin-left: 10%;
        margin-right: 10%;
        margin-top: 2%;
      }
      
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }


    </style>
  </head>
  <body>

      <div class="container">
        <div class="row">
          <div class="col-md-4">
            <input type="button" value="Obtener mi hubicación - A" onclick="get_my_location();" class="btn btn-success">
          </div>
        </div>
      </div>
      
      <div id="map"></div>

     <br>
      <div class="container">
        <div class="row">
          <div class="col-md-2"></div>
          <div class="col-md-2">Punto de Partida</div>
          
          <div class="col-md-2">Punto de Llegada</div>
        </div>


        <div class="row">

          <div class="col-md-2">
             <input type="button" value="Agregar Punto partida" onclick="var param=0; agregarPunto(param);" class="btn btn-success">
          </div>

          <div class="col-md-2">
            <input type="text" placeholder="Latitud" id="my_lat" class="form-control" readonly="true">
          </div>


          <div class="col-md-2">
            <input type="text"  class="form-control" id="your_lat" placeholder="Latitud"readonly>
          </div>

        </div>

        <div class="row">
          <div class="col-md-2">
          </div>
          <div class="col-md-2">
            <input type="text" placeholder="Longitud" id="my_lng" class="form-control" readonly>
          </div>
          <!--<div class="col-md-2" ></div>-->
          <div class="col-md-2">
            <input type="text" class="form-control" id="your_lng" placeholder="Longitud" readonly>
          </div>
        </div>
      </div>

      <div class="row">
        <div class="col-md-2">
             <input type="button" value="Ruta" onclick="ruta();" class="btn btn-success">
        </div>
      </div>
      

       

       <input type="text" placeholder="Latitud-Longitud" id="latLng" class="form-controll" readonly>
       
       
       <input type="hidden" id="oculto">


   
    <script src="googleMaps.js"></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCbUDtVGNnPGBMF4Acpf0CbJYmLspmq-Ps&callback=initMap"
    async defer></script>
    <!--
        https://www.google.com/maps/embed/v1/place?key=AIzaSyCbUDtVGNnPGBMF4Acpf0CbJYmLspmq-Ps&q=Space+Needle,Seattle+WA
        
  
    -->

   
  </body>
</html>
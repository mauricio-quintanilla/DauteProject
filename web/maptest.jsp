<%-- 
    Document   : maptest
    Created on : Oct 23, 2020, 1:01:45 AM
    Author     : demon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>Simple Markers</title>
    <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
      <script async defer src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&callback=initMap"
  type="text/javascript"></script>
<!-- this api doesnt work let's ask isma if he has any api from previous projects
     from this point we can get lat and lon and redirect coord to maps 
    <script
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDyubG4Y8TeqHan6blJyPz5EKSfkw8kWh8&callback=initMap&libraries=&v=weekly"
      defer
    ></script>--> 
    <style type="text/css">
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }

      /* Optional: Makes the sample page fill the window. */
      html,
      body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
    </style>
    <script>
      function initMap() {
        const myLatLng = { lat: -25.363, lng: 131.044 };
        const map = new google.maps.Map(document.getElementById("map"), {
          zoom: 4,
          center: myLatLng,
        });
        new google.maps.Marker({
          position: myLatLng,
          map,
          title: "Hello World!",
        });
      }
    </script>
  </head>
  <body>
    <div id="map"></div>
  </body>
</html>
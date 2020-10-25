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
      <iframe
  width="600"
  height="450"
  frameborder="0" style="border:0"
  src="https://www.google.com/maps/embed/v1/place?key=AIzaSyCbUDtVGNnPGBMF4Acpf0CbJYmLspmq-Ps&q=Space+Needle,Seattle+WA" allowfullscreen>
</iframe>
    <div id="map"></div>
  </body>
</html>
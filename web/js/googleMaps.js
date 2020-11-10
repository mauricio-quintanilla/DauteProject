var map;
      var contador=0;
      var contadora = 0;
      var markers = [];
      var marcadores = [];
      var banderaPa = 1;
      var banderaPb = 1;

      function initMap() {
          map = new google.maps.Map(document.getElementById('map'), {
            center: {lat: 13.698473140684895, lng:-89.20124182969334},
            zoom: 10
          });

      } //Fin de el Init MAp>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

      function ruta(){
        var my_lat = $("#my_lat").val(); 
        var my_lng = $('#my_lng').val();
        

        var myLatlng = new google.maps.LatLng(my_lat,my_lng);
        var mapOptions = {
          zoom: 15,
          center: myLatlng
        }
        var map = new google.maps.Map(document.getElementById("map"), mapOptions);

        var marker = new google.maps.Marker({
            position: myLatlng,
            title:"Hello World!"
        });

        // To add the marker to the map, call setMap();
        marker.setMap(map);
        }
        



      function agregarPunto(banderaPa){
           
            if(banderaPa==0){
              
                map.addListener('click', function(e) {
                  
                    if(contador==0){
                      deleteMarkers();
                    
                      $('#oculto').val(e.latLng);//Impreme la latitud y la logitud en formato: (lat, lang)
                      var cadenita = $('#oculto').val();

                      var latIncompleta = (cadenita.split(" "));//Separamos la logitud y la latitud

                      var final = (latIncompleta[0].length)-1;//Encontramos la logitud del el string guardado en [0] y le restamos 1 porque termina en coma ","
                      var end = (latIncompleta[1].length-1)

                      var latitud = latIncompleta[0].substring(1,final);
                      var longitud = latIncompleta[1].substring(0,end);

                      $("#my_lat").val(latitud);
                      $('#my_lng').val(longitud);
                      $("#your_lat").val("");
                      $('#your_lng').val("");
                      $('#latLng').val(e.latLng);

                      placeMarkerAndPanTo(e.latLng, map); 
                    } else {
                      



                      $('#oculto').val(e.latLng);//Impreme la latitud y la logitud en formato: (lat, lang)
                      var cadenita = $('#oculto').val();

                      var latIncompleta = (cadenita.split(" "));//Separamos la logitud y la latitud

                      var final = (latIncompleta[0].length)-1;//Encontramos la logitud del el string guardado en [0] y le restamos 1 porque termina en coma ","
                      var end = (latIncompleta[1].length-1)


                      var latitud = latIncompleta[0].substring(1,final);
                      var longitud = latIncompleta[1].substring(0,end);

                      $("#your_lat").val(latitud);
                      $('#your_lng').val(longitud)
                      $('#latLng').val(e.latLng);           
                      placeMarkerAndPanTob(e.latLng, map);
                    }
              });
            }
      }

      
        
          function placeMarkerAndPanTo(latLng, map) {
           
            var posicionA = new google.maps.Marker({
              position: latLng,
              label: "A",
              map: map,
              title:"Posición A"+contador,
              animation: google.maps.Animation.DROP
            });
            markers.push(posicionA);
          //map.panTo(latLng);
          }

          //Marcador secundario adiconal evalua si se colocó otro marcador para eliminar el anterior :)
          function placeMarkerAndPanTob(latLng, map) {
            contador=0;
            var posicionA = new google.maps.Marker({
              position: latLng,
              label: "B",
              map: map,
              title:"Pocisión B"+contador,
              animation: google.maps.Animation.DROP
            });
            markers.push(posicionA);
          //map.panTo(latLng);
          }

          function setMapOnAll(map) {
            for (var i = 0; i < markers.length; i++) {
              markers[i].setMap(map);
            }
          }

          // Removes the markers from the map, but keeps them in the array.
          function clearMarkers() {
            setMapOnAll(null);
          }

          // Shows any markers currently in the array.
          function showMarkers() {
            setMapOnAll(map);
          }

          // Deletes all markers in the array by removing references to them.
          function deleteMarkers() {
            clearMarkers();
            markers = [];
          }

       


      //Geolocalización---Ismael Castillo Martínez---------------------
      function get_my_location() {
        var infoWindow;
          
          infoWindow = new google.maps.InfoWindow;
         
          if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
              var pos = {
                lat: position.coords.latitude,
                lng: position.coords.longitude
              };

              infoWindow.setPosition(pos);
              infoWindow.setContent('Hubicación encontrada.');
              infoWindow.open(map);
              map.setCenter(pos);
            }, function() {
              handleLocationError(true, infoWindow, map.getCenter());
            });
          } else {
            // Browser doesn't support Geolocation
            handleLocationError(false, infoWindow, map.getCenter());
          }
        }
        //-----------------------------------------------------------------


        //Mensaje de error cuando no le permitimos la geolocalización--------------------
        function handleLocationError(browserHasGeolocation, infoWindow, pos) {
        infoWindow.setPosition(pos);
        infoWindow.setContent(browserHasGeolocation ?
                              'Error: El servicio de geolocalización falló.' :
                              'Error: Tu navegador no soporta geolocalización.');
        infoWindow.open(map);
        }




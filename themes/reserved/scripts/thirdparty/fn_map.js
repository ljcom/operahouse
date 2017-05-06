function initialize() { }

function loadMyLocation(field, isDraggable) {
    if (field) {
        var useragent = navigator.userAgent;
        if (useragent.indexOf('iPhone') != -1 || useragent.indexOf('Android') != -1 || useragent.indexOf('Mobile') != -1) {
            loadMapScript("true");
            getPosition(field, isDraggable);
        }
        else {
            loadMapScript("false");
            getPosition(field, isDraggable);
            if (document.getElementById(field.id + "_button")) document.getElementById(field.id + "_button").style.display = "none";
        }
    }
}

function loadMapScript(sensorFlag) {
    var script = document.createElement("script");
    script.type = "text/javascript";
    script.src = "http://maps.googleapis.com/maps/api/js?key=AIzaSyA3_aq-3bRnGrPDMbkO6EQF0oxbyaakUDc&sensor=" + sensorFlag + "&callback=initialize";
    document.body.appendChild(script);
    //srcc="http://maps.googleapis.com/maps/api/js?v=3.4&key=AIzaSyA3_aq-3bRnGrPDMbkO6EQF0oxbyaakUDc&sensor=true"
}

function getPosition(fieldx, isDraggable) {
    var latc, longc;
    if (typeof (navigator.geolocation) != 'undefined') {
        navigator.geolocation.getCurrentPosition(

            function(position) {
                var lat = position.coords.latitude;
                var lng = position.coords.longitude;
                //alert(lat);
                if (typeof (google) != 'undefined') {
                    var myOptions = {
                        center: new google.maps.LatLng(lat, lng), zoom: 12,
                        mapTypeId: google.maps.MapTypeId.ROADMAP
                    };
                    var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
                    var infowindow = new google.maps.InfoWindow();
                    var marker, i;
                    for (i = 0; i < 1; i++) {
                        marker = new google.maps.Marker({ position: new google.maps.LatLng(lat, lng),
                            draggable: isDraggable, map: map
                        });
                        google.maps.event.addListener(marker, 'click', (function(marker, i) {
                            return function() {
                                infowindow.setContent("You are here. Press reload if you have moved or your GPS is not updated yet.");
                                infowindow.open(map, marker);
                            }
                        })(marker, i));
                    }
                    fieldx.value = lat + ';' + lng;
                }
            }
        );
    }
    else {
        var f = fieldx.value.split(";");
        var lat = f[0];
        var lng = f[1];
        if (lng == undefined) lng = "";
        //alert(lat);
        if (typeof (google) != 'undefined') {
            var myOptions = {
                center: new google.maps.LatLng(lat, lng),
                zoom: 12, mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
            var infowindow = new google.maps.InfoWindow();
            var marker, i;
            for (i = 0; i < 1; i++) {
                marker = new google.maps.Marker({ position:
                    new google.maps.LatLng(lat, lng), draggable: isDraggable, map: map
                });
                // google.maps.event.addListener(marker, 'click', (function(marker, i) {
                // return function() {
                // infowindow.setContent("You are here. Press reload if you have moved or your GPS is not updated yet.");
                // infowindow.open(map, marker);
                // }
                // })(marker, i));
            }
        }
    }
}

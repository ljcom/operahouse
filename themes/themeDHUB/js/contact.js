(function ($) {
    "use strict";

    $(document).ready(function () {
        var pageContactMap = L.map('page-contact-map').setView([51.505, -0.09], 13);
        L.tileLayer('http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',{
            maxZoom: 20,
            subdomains:['mt0','mt1','mt2','mt3']
        }).addTo(pageContactMap);
        pageContactMap.scrollWheelZoom.disable();

        /*var contactIcon = L.icon({
            iconUrl: 'images/map/popup-point.png',
            iconSize: [370, 140]
        });*/

        var contactIcon = new L.HtmlIcon({
            html : '<div class="page-contact__map-point"><div class="page-contact__map-point-title">Arlic New York Pizza Bar</div><div>4.2 (39) <span class="page-contact__map-point-rating"><img src="images/map/star.png" alt=""><img src="images/map/star.png" alt=""><img src="images/map/star.png" alt=""><img src="images/map/star.png" alt=""><img src="images/map/half-star.png" alt=""></span></div><div>$ · Italian · 2nd Ave</div> <div>Open from 11:00</div></div>',
            iconSize: [370, 140]
        });

        var marker = L.marker([51.50, -0.10], {icon: contactIcon}).addTo(pageContactMap).bindPopup("I am a green leaf.");
        marker.off('click');
    });
})(jQuery);
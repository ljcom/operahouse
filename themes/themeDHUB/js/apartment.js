(function ($) {
    "use strict";

    $(document).ready(function () {
        $('#apartment-image-slider').lightSlider({
            gallery: true,
            item: 1,
            loop: true,
            slideMargin: 0,
            thumbItem: 9
        });

        var apartmentMap = L.map('apartment-map').setView([51.505, -0.09], 13);
        L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
            attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(apartmentMap);
        apartmentMap.scrollWheelZoom.disable();
    });
})(jQuery);
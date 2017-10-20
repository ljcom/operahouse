(function () {
    "use strict";

    function init() {
        if ($(window).width() > 998) {
            var headerHeight = $('.header-default').height();
            var listingsBlockHeight = $(window).height() - headerHeight;

            $('.listings-list-map__listings-wrap').height(listingsBlockHeight);
            $('.listings-list-map__map').height(listingsBlockHeight);
        } else {
            $('.listings-list-map__listings-wrap').css('height', 'auto');
        }
    }

    noUiSlider.create($('.listings-list-map__filter-price-range-slider').get(0), {
        connect: true,
        behaviour: 'tap',
        start: [50000, 270000],
        orientation: 'horizontal',
        range: {
            'min': [ 0 ],
            'max': [ 300000 ]
        }
    });

    init();

    $('.selectable').each(function () {
        var select = $(this);

        if (select.data('selectable-no-search')) {
            select.select2({
                minimumResultsForSearch: -1
            });
        } else {
            select.select2();
        }
    });

    var buildingIcon = L.icon({
        iconUrl: 'images/map/building-point.png',
        iconSize:     [42, 60],
        iconAnchor:   [22, 94],
        shadowAnchor: [4, 62],
        popupAnchor:  [-1, -93]
    });

    var pizzaIcon = L.icon({
        iconUrl: 'images/map/pizza-point.png',
        iconSize:     [42, 60],
        iconAnchor:   [22, 94],
        shadowAnchor: [4, 62],
        popupAnchor:  [-1, -93]
    });

    var doorIcon = L.icon({
        iconUrl: 'images/map/door-point.png',
        iconSize:     [42, 60],
        iconAnchor:   [22, 94],
        shadowAnchor: [4, 62],
        popupAnchor:  [-1, -93]
    });

    var vineIcon = L.icon({
        iconUrl: 'images/map/vine-point.png',
        iconSize:     [42, 60],
        iconAnchor:   [22, 94],
        shadowAnchor: [4, 62],
        popupAnchor:  [-1, -93]
    });

    var dishIcon = L.icon({
        iconUrl: 'images/map/dish-point.png',
        iconSize:     [42, 60],
        iconAnchor:   [22, 94],
        shadowAnchor: [4, 62],
        popupAnchor:  [-1, -93]
    });

    var foodIcon = L.icon({
        iconUrl: 'images/map/food-point.png',
        iconSize:     [42, 60],
        iconAnchor:   [22, 94],
        shadowAnchor: [4, 62],
        popupAnchor:  [-1, -93]
    });

    var map = L.map('listings-list-map-map').setView([51.505, -0.09], 13);
    L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);
    map.scrollWheelZoom.disable();

    L.marker([51.5, -0.09], {icon: buildingIcon}).addTo(map).bindPopup("I am a green leaf.");
    L.marker([51.51, -0.065], {icon: pizzaIcon}).addTo(map).bindPopup("I am a green leaf.");
    L.marker([51.52, -0.12], {icon: doorIcon}).addTo(map).bindPopup("I am a green leaf.");
    L.marker([51.50, -0.045], {icon: vineIcon}).addTo(map).bindPopup("I am a green leaf.");
    L.marker([51.48, -0.12], {icon: dishIcon}).addTo(map).bindPopup("I am a green leaf.");
    L.marker([51.48, -0.08], {icon: foodIcon}).addTo(map).bindPopup("I am a green leaf.");

    $(window).on('resize', function () {
        init();
    });
})(jQuery);
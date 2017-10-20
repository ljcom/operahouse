(function () {
    "use strict";

    $(".hero-booking-places-form-check-in .form-control").flatpickr();
    $(".hero-booking-places-form-check-out .form-control").flatpickr();

    $('.flexdatalist').on('change:flexdatalist', function (e, value) {
        if (value) {
            $('.hero-booking-places-form').addClass('hero-booking-places-form--location-opened');
        } else {
            $('.hero-booking-places-form').removeClass('hero-booking-places-form--location-opened');
        }
    }).on('select:flexdatalist', function (e, value) {
        $('.hero-booking-places-form').removeClass('hero-booking-places-form--location-opened');
    });

    $('.flexdatalist').on('show:flexdatalist.results', function () {
        $('.hero-booking-places-form').addClass('hero-booking-places-form--location-opened');
    });

    $(document).on('click', function (e) {
        if (!$(e.target).hasClass('flexdatalist') && $(e.target).closest('.flexdatalist-results').length == 0) {
            $('.hero-booking-places-form').removeClass('hero-booking-places-form--location-opened');
        }
    });
})(jQuery);
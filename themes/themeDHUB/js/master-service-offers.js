(function ($) {
    "use strict";

    $(document).ready(function () {
        $('.listing-offers-with-filter__work-examples-carousel').owlCarousel({
            loop: false,
            margin: 10,
            center: false,
            items: 6,
            autoplay: false,
            autoplayHoverPause: true,
            dots: false,
            navigation: false,
            responsive:{
                0:{
                    items: 2
                },
                400:{
                    items: 3
                },
                768:{
                    items: 4
                },
                998:{
                    items: 6
                }
            }
        });
    });
})(jQuery);
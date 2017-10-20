(function ($) {
    "use strict";

    $(document).ready(function () {
        $('.master-profile-work-examples__carousel').owlCarousel({
            loop: false,
            margin: 14,
            center: false,
            items: 5,
            autoplay: false,
            autoplayHoverPause: true,
            dots: false,
            navigation: false,
            responsive:{
                0:{
                    items:1
                },
                400:{
                    items:2
                },
                768:{
                    items:3
                },
                998:{
                    items:6
                }
            }
        });
    });
})(jQuery);
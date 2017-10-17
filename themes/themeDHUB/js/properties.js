(function ($) {
    "use strict";

    $(document).ready(function () {
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

        noUiSlider.create($('#filter-properties-price-range-slider').get(0), {
            connect: true,
            behaviour: 'tap',
            start: [ 800, 6200 ],
            orientation: 'horizontal',
            range: {
                'min': [ 0 ],
                'max': [ 7000 ]
            }
        });

        $('#testimonials-properties-carousel').owlCarousel({
            loop: true,
            margin: 10,
            center: true,
            items: 1,
            autoplay: true,
            autoplayHoverPause: true,
            dots: true,
            navigation: true
        });

        $('.hero-carousel__items').owlCarousel({
            loop: true,
            center: true,
            items: 1,
            autoplay: true,
            autoplayHoverPause: true,
            dots: false,
            nav:true
        });
    });
})(jQuery);
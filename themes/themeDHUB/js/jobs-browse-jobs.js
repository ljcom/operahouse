(function () {
    "use strict";

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

    noUiSlider.create($('#hero-jobs-filter-price-range-slider').get(0), {
        connect: true,
        behaviour: 'tap',
        start: [ 50000, 270000 ],
        orientation: 'horizontal',
        range: {
            'min': [ 0 ],
            'max': [ 300000 ]
        }
    });
})(jQuery);
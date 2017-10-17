(function ($) {
    "use strict";

    $(document).ready(function () {
        $('.sidebar-filter-default__price-slider').each(function () {
            noUiSlider.create(this, {
                connect: true,
                /*behaviour: 'tap',*/
                start: [ 6, 92 ],
                orientation: 'horizontal',
                tooltips: [wNumb({
                    prefix: '$',
                    decimals: 0,
                    thousand: ','
                }), wNumb({
                    prefix: '$',
                    decimals: 0,
                    thousand: ','
                })],
                pips: {
                    mode: 'range',
                    density: 3
                },
                range: {
                    'min': [ 0 ],
                    '25%': [   25 ],
                    '50%': [  50 ],
                    '75%': [  75 ],
                    'max': [ 100 ]
                }
            });
        });
    });
})(jQuery);
(function () {
    "use strict";

    $('[data-toggle="popover"]').popover();
    $('[data-toggle="tooltip"]').tooltip();

    function createHorizontalSlider(element) {
        noUiSlider.create(element, {
            connect: true,
            behaviour: 'tap',
            start: [ 500, 4000 ],
            orientation: 'horizontal',
            range: {
                // Starting at 500, step the value by 500,
                // until 4000 is reached. From there, step by 1000.
                'min': [ 0 ],
                '10%': [ 500, 500 ],
                '50%': [ 4000, 1000 ],
                'max': [ 10000 ]
            }
        });
    }

    function createVerticalSlider(element, start) {
        noUiSlider.create(element, {
            start: start,
            connect: [true, false],
            behaviour: 'tap',
            orientation: "vertical",
            range: {
                'min': 0,
                'max': 255
            }
        });
    }

    // Horizontal sliders
    createHorizontalSlider($('#range-slider-default').get(0)); // Create default slider
    createHorizontalSlider($('#range-slider-default-primary').get(0)); // Create default primary slider
    createHorizontalSlider($('#range-slider-default-info').get(0)); // Create default info slider
    createHorizontalSlider($('#range-slider-default-success').get(0)); // Create default success slider
    createHorizontalSlider($('#range-slider-default-warning').get(0)); // Create default warning slider
    createHorizontalSlider($('#range-slider-default-danger').get(0)); // Create default danger slider
    createHorizontalSlider($('#range-slider-default-shadow').get(0)); // Create default shadow slider
    createHorizontalSlider($('#range-slider-default-shadow-sm').get(0)); // Create default shadow small slider

    // Vertical sliders
    createVerticalSlider($('#range-slider-default-vertical').get(0), 120); // Create default slider
    createVerticalSlider($('#range-slider-default-primary-vertical').get(0), 200); // Create default primary slider
    createVerticalSlider($('#range-slider-default-info-vertical').get(0), 80); // Create default info slider
    createVerticalSlider($('#range-slider-default-success-vertical').get(0), 200); // Create default success slider
    createVerticalSlider($('#range-slider-default-warning-vertical').get(0), 160); // Create default warning slider
    createVerticalSlider($('#range-slider-default-danger-vertical').get(0), 60); // Create default danger slider

    $('.select2-form-control').select2();
})(jQuery);
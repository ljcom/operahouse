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

    $('.range-datepickers').kalendae({
        mode: 'range',
        months: 2,
        weekStart: 1,
        useYearNav: false,
        titleFormat: 'MMMM'
    });
})(jQuery);
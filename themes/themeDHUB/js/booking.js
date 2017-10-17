(function () {
    "use strict";

    $('#booking-date-picker').kalendae({
        mode: 'range',
        months: 2,
        weekStart: 1,
        useYearNav: false,
        titleFormat: 'MMMM'
    });
})(jQuery);
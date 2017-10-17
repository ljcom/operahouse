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
})(jQuery);
(function () {
    "use strict";

    $('.selectable').each(function () {
        var select = $(this);

        if (select.data('selectable-no-search')) {
            var theme = select.data('theme');
            select.select2({
                minimumResultsForSearch: -1
            });
        } else {
            select.select2();
        }
    });
})(jQuery);
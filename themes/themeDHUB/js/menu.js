(function ($, window) {
    "use strict";

    $.fn.menu = function(options) {
        var settings = $.extend($.fn.menu.defaults, options);

        return this.each(function() {
            var element = $(this);

            $(element).find('.menu-preview-nav-item-toggle > .menu-preview-link-item').on('click', function () {
                var parent = $(this).parent();
                var menu = $(this).next('.menu-preview');

                if (parent.hasClass(settings.openClass)) {
                    parent.removeClass(settings.openClass);
                    menu.hide();
                } else {
                    parent.addClass(settings.openClass);
                    menu.show();
                }

                return false;
            });
        });
    };

    $.fn.menu.defaults = {
        openClass: 'open'
    };
}(jQuery, window));
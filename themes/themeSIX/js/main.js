/**
  * responsiveMenu
  * searchButton
  * menuCanvas
  * Filterbox
  * slidePartner
  * slideTestimonial
  * slideTestimonial_S2
  * slideTestimonial_S3
  * slideTestimonial_S4
  * slideCarousel
  * slideClients
  * slideRelated
  * slideSingleSimple
  * slidePhotography
  * slidePhotography_s2
  * slideVideo
  * slideVideo_S2
  * slideProject
  * slideImagebox
  * slideImagebox_s2
  * slideOurwork
  * slideOwl_carousel
  * slideImagebox_s3
  * slidePartner_s2
  * tabAbout
  * counterAbout
  * progressBar
  * countdown_1
  * CountDown
  * CountDown_S2
  * videoPopup
  * accordionToggle
  * portfolioIsotope
  * googleMap
  * googleMap_S2
  * parallax
  * heights
  * flexProduct
  * tabProduct
  * tabDetailProduct
  * detectViewport
  * gridPhotography
  * shopMetroIpsotope
  * ajaxSubscribe.eventLoad
  * ajaxContactForm
  * swClick
  * goTop
  * scroll
  * removePreloader
*/

;(function($) {

   'use strict'
        var isMobile = {
            Android: function() {
                return navigator.userAgent.match(/Android/i);
            },
            BlackBerry: function() {
                return navigator.userAgent.match(/BlackBerry/i);
            },
            iOS: function() {
                return navigator.userAgent.match(/iPhone|iPad|iPod/i);
            },
            Opera: function() {
                return navigator.userAgent.match(/Opera Mini/i);
            },
            Windows: function() {
                return navigator.userAgent.match(/IEMobile/i);
            },
            any: function() {
                return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
            }
        }; // is Mobile

        var responsiveMenu = function() {
            var menuType = 'desktop';

            $(window).on('load resize', function() {
                var currMenuType = 'desktop';

                if ( matchMedia( 'only screen and (max-width: 991px)' ).matches ) {
                    currMenuType = 'mobile';
                }

                if ( currMenuType !== menuType ) {
                    menuType = currMenuType;

                    if ( currMenuType === 'mobile' ) {
                        var $mobileMenu = $('#mainnav').attr('id', 'mainnav-mobi').hide();
                        var hasChildMenu = $('#mainnav-mobi').find('ul.menu').children('li');
                        var hasSubmenuChild = $('.submenu').find('li.has-submenu-child');

                        $('#header').after($mobileMenu);
                        hasChildMenu.children('div.submenu').hide();
                        $(".menu-mega").hide();
                        hasChildMenu.children('a').after('<span class="btn-submenu"></span>');
                        $('.btn-menu').removeClass('active');
                        $('.submenu-child').hide();
                        hasSubmenuChild.children('a').after('<span class="btn-submenu-child"></span>');

                    } else {
                        var $desktopMenu = $('#mainnav-mobi').attr('id', 'mainnav').removeAttr('style');
                        $('div.submenu').show();
                        $desktopMenu.find('.menu-mega').removeAttr('style');
                        $('#header').find('.nav-wrap').append($desktopMenu);
                        $('.btn-submenu').remove();
                        $('.submenu-child').show();
                    }

                    if ($('#header').hasClass('style1') || $('#header').hasClass('style2 v1')) {
                        $('#mainnav-mobi').css({
                            // top: '100px'
                        });
                    }
                }
            });

            $('.btn-menu').on('click', function() {         
                $('#mainnav-mobi').slideToggle(300);
                $(this).toggleClass('active');
                return false;
            });

            $(document).on('click', '#mainnav-mobi li .btn-submenu', function(e) {
                $(this).toggleClass('active').next('.submenu').slideToggle(500);
                $(this).next('.menu-mega').slideToggle(500);
                e.stopImmediatePropagation();
                return false;
            });

            $(document).on('click', '#mainnav-mobi li .submenu .btn-submenu-child', function(e) {
                $(this).toggleClass('active').next('ul.submenu-child').slideToggle(500);
                // $(this).next('.menu-mega').slideToggle(500);
                e.stopImmediatePropagation();
                return false;
            });
        }; // Responsive Menu

        var searchButton = function() {
            var showsearch = $('.box-search .icon_search');
            var closesearch = $('.box-search form .input-search .delete');
            showsearch.on('click',function() {
                $(this).parent('.box-search').children('form').css({
                    opacity: '1',
                    visibility: 'visible',
                    width: '100%'
                });
            });
            closesearch.on('click', function() {
                $(this).closest('.box-search').children('form').css({
                    opacity: '0',
                    visibility: 'visible',
                    width: '0%'
                });
            });
        }; // Search button

        var menuCanvas = function() {
            var buttonCavas = $('.box-canvas span.ti-align-right');
            var closeCanvas = $('.menu-canvas .close');
            buttonCavas.on('click', function() {
                $(this).closest('section').children('.menu-canvas').css({
                    opacity: '1',
                    visibility: 'visible',
                    right: '0'
                });
            });

            closeCanvas.on('click', function() {
                $(this).parent('.menu-canvas').css({
                    opacity: '0',
                    visibility: 'hidden',
                    right: '-520px',
                });
            });
        }; // Menu Canvas

        var Filterbox = function(){
            var buttonFilter = $('.filter');
            var buttonHideFilter = $('.box-filter .hide');
            $('.box-filter').hide();
            buttonFilter.on('click',function(){
                $('.box-filter').slideDown();
            });

            buttonHideFilter.on('click',function(){
                $('.box-filter').slideUp();
            });
        };  // Filterbox

        var slidePartner = function() {
            $(".owl-carousel").owlCarousel({
                autoplay:true,
                dots:false,
                margin:30,
                loop:true,
                items:6,
                responsive:{
                    0:{
                        items: 2
                    },

                    479:{
                        items: 3
                    },
                    768:{
                        items: 4
                    },
                    991:{
                        items: 5
                    },
                    1200: {
                        items: 6
                    }
                }
            });
        };// slide Partner

        var slideTestimonial = function() {
            $(".owl-carousel-1").owlCarousel({
                autoplay:true,
                dots:true,
                margin: 28,
                loop:true,
                items:1,
            });
        };// slide Testimonial

        var slideTestimonial_S2 = function() {
            $(".owl-carousel-2").owlCarousel({
                autoplay:true,
                dots:false,
                nav:true,
                loop:true,
                items:1,
                responsive:{
                    0:{
                        items: 1,
                        nav: false
                    },
                    479:{
                        items: 1,
                        nav: false
                    },
                    768:{
                        items: 1,
                        nav: false
                    },
                    991:{
                        items: 1
                    },
                    1200: {
                        items: 1
                    }
                }
            });
        };// slide Testimonial s2

        var slideTestimonial_S3 = function() {
            $(".owl-carousel-3").owlCarousel({
                autoplay:true,
                dots:true,
                margin: 28,
                loop:true,
                items:2,
                responsive:{
                    0:{
                        items: 1
                    },

                    479:{
                        items: 1
                    },
                    768:{
                        items: 1
                    },
                    991:{
                        items: 2
                    },
                    1200: {
                        items: 2
                    }
                }
            });
        };// slide Testimonial s3

        var slideTestimonial_S4 = function() {
            $(".owl-carousel-4").owlCarousel({
                autoplay:true,
                dots:false,
                nav: true,
                margin: 28,
                loop:true,
                items:1,
            });
        };// slide Testimonial s4

        var slideCarousel = function() {
            $(".owl-carousel-5").owlCarousel({
                autoplay:true,
                dots:true,
                margin: 30,
                loop:true,
                items:3,
            });
        };// slide Carousel

        var slideClients = function() {
            $(".owl-carousel-6").owlCarousel({
                autoplay:true,
                dots:false,
                margin: 0,
                loop:true,
                items:6,
                responsive:{
                    0:{
                        items: 2
                    },

                    479:{
                        items: 3
                    },
                    768:{
                        items: 4
                    },
                    991:{
                        items: 5
                    },
                    1200: {
                        items: 6
                    }
                }
            });
        };// slide Clients

        var slideRelated = function() {
            $(".owl-carousel-7").owlCarousel({
                autoplay:true,
                nav:true,
                dots: false,
                margin: 30,
                loop:true,
                items:4,
                responsive:{
                    0:{
                        items: 1
                    },

                    479:{
                        items: 2
                    },
                    768:{
                        items: 3
                    },
                    991:{
                        items: 4
                    },
                    1200: {
                        items: 4
                    }
                }
            });
        };// slide Related

        var slideSingleSimple = function() {
            $(".owl-carousel-8").owlCarousel({
                autoplay:true,
                nav:true,
                dots: true,
                margin: 10,
                loop:true,
                items:1,
                responsive:{
                    0:{
                        nav: false,
                    },

                    479:{
                        nav: false,
                    },
                    768:{
                        items: 1
                    },
                    991:{
                        items: 1
                    },
                    1200: {
                        items: 1
                    }
                }
            });
        };// slide Singlesimple

        var slidePhotography = function() {
            $(".owl-carousel-9").owlCarousel({
                autoplay:false,
                nav:false,
                dots: false,
                margin: 20,
                loop: true,
                items:1,
            });
        };// slide Photography

        var slidePhotography_s2 = function() {
            $(".owl-carousel-10").owlCarousel({
                autoplay:false,
                nav:true,
                dots: false,
                margin: 0,
                loop:true,
                items:1,
                responsive:{
                    0:{
                        items: 1,
                        nav: false
                    },
                    479:{
                        items: 1,
                        nav: false
                    },
                    576:{
                        items: 1,
                        nav: false
                    },
                    768:{
                        items: 1,
                    },
                    991:{
                        items: 1
                    },
                    1200: {
                        items: 1
                    }
                }
            });
        };// slide Photography_S2

        var slideVideo = function() {
            $(".owl-carousel-11").owlCarousel({
                autoplay:true,
                nav:false,
                dots: true,
                margin: 0,
                loop:true,
                items:1,
            });
        };// slide video

        var slideVideo_S2 = function() {
            $(".owl-carousel-12").owlCarousel({
                autoplay:true,
                nav:true,
                dots: false,
                margin: 30,
                loop:true,
                items:4,
                responsive:{
                    0:{
                        items: 1
                    },
                    479:{
                        items: 2
                    },
                    576:{
                        items: 2
                    },
                    768:{
                        items: 3
                    },
                    991:{
                        items: 4
                    },
                    1200: {
                        items: 4
                    }
                }
            });
        };// slide video S2

        var slideProject = function() {
            $(".owl-carousel-13").owlCarousel({
                autoplay:true,
                nav:false,
                dots: false,
                margin: 30,
                loop:true,
                items:3,
                responsive:{
                    0:{
                        items: 1
                    },
                    479:{
                        items: 1
                    },
                    576:{
                        items: 2
                    },
                    768:{
                        items: 2
                    },
                    991:{
                        items: 3
                    },
                    1200: {
                        items: 3
                    }
                }
            });
        };// slide Project

        var slideImagebox = function() {
            $(".owl-carousel-14").owlCarousel({
                autoplay:true,
                nav:false,
                dots: true,
                margin: 30,
                loop:true,
                items:3,
                responsive:{
                    0:{
                        items: 1
                    },
                    479:{
                        items: 1
                    },
                    576:{
                        items: 2
                    },
                    768:{
                        items: 2
                    },
                    991:{
                        items: 3
                    },
                    1200: {
                        items: 3
                    }
                }
            });
        };// slide Imagebox

        var slideImagebox_s2 = function() {
            $(".owl-carousel-15").owlCarousel({
                autoplay:true,
                nav:false,
                dots: false,
                margin: 0,
                loop:true,
                items:3,
                 responsive:{
                    0:{
                        items: 1
                    },
                    479:{
                        items: 1
                    },
                    576:{
                        items: 1
                    },
                    768:{
                        items: 2
                    },
                    991:{
                        items: 2
                    },
                    1200: {
                        items: 3
                    }
                }
            });
        };// slide Imagebox S2

        var slideOurwork = function() {
            $(".owl-carousel-16").owlCarousel({
                autoplay:true,
                nav:false,
                dots: false,
                margin: 0,
                loop:true,
                items:4,
                 responsive:{
                    0:{
                        items: 1
                    },
                    479:{
                        items: 1
                    },
                    576:{
                        items: 2
                    },
                    768:{
                        items: 3
                    },
                    991:{
                        items: 3
                    },
                    1200: {
                        items: 4
                    }
                }
            });
        };// slide ourwork

        var slideOwl_carousel = function() {
            $(".owl-carousel-17").owlCarousel({
                autoplay:true,
                nav:false,
                dots: true,
                margin: 30,
                loop:true,
                items:3,
                 responsive:{
                    0:{
                        items: 1
                    },
                    479:{
                        items: 1
                    },
                    576:{
                        items: 1
                    },
                    768:{
                        items: 2
                    },
                    991:{
                        items: 2
                    },
                    1200: {
                        items: 3
                    }
                }
            });
        };// slide Owl carousel

        var slideImagebox_s3 = function() {
            $(".owl-carousel-18").owlCarousel({
                autoplay:true,
                nav:false,
                dots: false,
                margin: 30,
                loop:true,
                items:4,
                responsive:{
                    0:{
                        items: 1
                    },
                    479:{
                        items: 1
                    },
                    576:{
                        items: 2
                    },
                    768:{
                        items: 3
                    },
                    991:{
                        items: 4
                    },
                    1200: {
                        items: 4
                    }
                }
            });
        };// slide Imagebox S3

        var slidePartner_s2 = function() {
            $(".owl-carousel-19").owlCarousel({
                autoplay:true,
                nav:false,
                dots: false,
                margin: 0,
                loop:true,
                items:5,
                responsive:{
                    0:{
                        items: 2
                    },
                    479:{
                        items: 2
                    },
                    576:{
                        items: 3
                    },
                    768:{
                        items: 4
                    },
                    991:{
                        items: 4
                    },
                    1200: {
                        items: 5
                    }
                }
            });
        };// slide Partner S3

        var tabAbout = function() {
            $('.tab-about').each(function() {
            $(this).children('.content-tab').children().hide();
            $(this).children('.content-tab').children().first().show()
            $(this).find('.tab-list-about').children('li').on('click', function(){
                var liActive = $(this).index(),
                contentActive = $(this).siblings().removeClass('active').parents('.tab-about').children('.content-tab').children().eq(liActive);
                contentActive.addClass('active').fadeIn("slow");
                contentActive.siblings().removeClass('active');
                $(this).addClass('active').parents('.tab-about').children('.content-tab').children().eq(liActive).siblings().hide();
            });
            });
        }; // Tab About

        var counterAbout = function() {      
            if ( $().countTo ) {
                $('.wrap-counter').on('on-appear', function() {
                    $(this).find('.numb-count').each(function() {
                        var to = parseInt( $(this).data('to'), 10 ),
                            speed = parseInt( $(this).data('speed'), 10 );
                            
                        $(this).countTo({
                            to: to,
                            speen: speed
                        });
                    });
                }); // wrap counter
            };
        }; // Counter About

        var progressBar = function() {        
            $('.progress-bar').on('on-appear', function() {
                $(this).each(function() {
                    $(this).css("overflow", "inherit");
                    var percent = $(this).data('percent');                
                    $(this).find('.progress-animate').animate({
                        "overflow":"inherit",
                        "width": percent + '%'
                    }, $(this).find('.progress-animate').data('duration') );

                    $(this).parent('.progress-item').find('.perc').addClass('show').animate({
                        "overflow":"inherit",
                        "width": percent + '%'
                    }, $(this).find('.progress-animate').data('duration') );
                });
            });
        }; // Progress Bar

        var countdown_1 = function() {
            $('.countdown-1').final_countdown();
        }// Countdown 1 

        var CountDown = function() {
            var before = '<div class="square"><div class="numb">',
                textday = '</div><div class="text">DAY',
                texthour = '</div><div class="text">HOURS',
                textmin = '</div><div class="text">MINUTES',
                textsec = '</div><div class="text">SECONDS';
                if ($().countdown) {
                    $(".countdown").countdown('2018/01/31', function(event) {
                      $(this).html(event.strftime(before + '%D' + textday + '</div></div>' + before + '%H' + texthour + '</div></div>' + before + '%M' + textmin + '</div></div>' + before + '%S' + textsec + '</div>'));
                    });
                };
        }; // Count Down

        var CountDown_S2 = function() {
            var before = '<div class="col-md-3 col-sm-6"><div class="square"><div class="numb">',
                textday = '</div><div class="text">/DAY',
                texthour = '</div><div class="text">/HOURS',
                textmin = '</div><div class="text">/MINUTES',
                textsec = '</div><div class="text">/SECONDS';
                if ($().countdown) {
                    $(".countdown-2").countdown('2018/01/31', function(event) {
                      $(this).html(event.strftime(before + '%D' + textday + '</div></div></div>' + before + '%H' + texthour + '</div></div></div>' + before + '%M' + textmin + '</div></div></div>' + before + '%S' + textsec + '</div></div>'));
                    });
                };
        }; // Count Down s2

        var detectViewport = function() {
            $('[data-waypoint-active="yes"]').waypoint(function() {
                $(this).trigger('on-appear');
            }, { offset: '95%', triggerOnce: true });
             $(window).on('load', function() {
                setTimeout(function() {
                    $.waypoints('refresh');
                }, 100);
            });
        }; // Detect Viewport

        var videoPopup =  function() {
            $(".fancybox").on("click", function(){
                $.fancybox({
                  href: this.href,
                  type: $(this).data("type")
                }); // fancybox
                return false   
            }); // on
        }; // Video Popup

        var accordionToggle = function() {
            var speed = {duration: 400};
            $('.toggle-content').hide();
            $('.accordion-toggle .toggle-title.active').siblings('.toggle-content').show();
            $('.accordion').find('.toggle-title').on('click', function() {
                $(this).toggleClass('active');
                $(this).next().slideToggle(speed);
                $(".toggle-content").not($(this).next()).slideUp(speed);
                if ($(this).is('.active')) {
                    $(this).closest('.accordion').find('.toggle-title.active').toggleClass('active')
                    $(this).toggleClass('active');
                };
            });
        }; // Accordion Toggle

        var portfolioIsotope = function() { 
            if ( $().isotope ) {           
                var $container = $('.wrap-portfolio');
                $container.imagesLoaded(function(){
                    $container.isotope({
                        itemSelector: '.ipsotope',
                        transitionDuration: '1s'
                    });
                });

                $('.tab-product-list li').on('click',function() {                           
                    var selector = $(this).attr('data-filter');
                    $('.tab-product-list li').removeClass('active');
                    $(this).addClass('active');
                    $container.isotope({ filter: selector });
                    return false;
                });            
            };
        }; // Portfolio Isotope

        var googleMap = function() {            
            if ( $().gmap3 ) {  
                $(".map").gmap3({
                    map:{
                        options:{
                            zoom: 11,
                            mapTypeId: 'themesflat_style',
                            mapTypeControlOptions: {
                                mapTypeIds: ['themesflat_style', google.maps.MapTypeId.SATELLITE, google.maps.MapTypeId.HYBRID]
                            },
                            scrollwheel: false
                        }
                    },
                    getlatlng:{
                        address:  $('.flat-maps').data('address'),
                        callback: function(results) {
                            if ( !results ) return;
                            $(this).gmap3('get').setCenter(new google.maps.LatLng(results[0].geometry.location.lat(), results[0].geometry.location.lng()));
                            $(this).gmap3({
                                marker:{
                                    latLng:results[0].geometry.location,
                                    options:{
                                        icon: $('.flat-maps').data('image')
                                    }
                                }
                            });
                        }
                    },
                    styledmaptype:{
                        id: "themesflat_style",
                        options:{
                            name: "Yolo Map"
                        },
                        styles:[
                            {
                                "featureType": "water",
                                "elementType": "geometry",
                                "stylers": [
                                    {
                                        "color": "#e9e9e9"
                                    },
                                    {
                                        "lightness": 17
                                    }
                                ]
                            },
                            {
                                "featureType": "landscape",
                                "elementType": "geometry",
                                "stylers": [
                                    {
                                        "color": "#f5f5f5"
                                    },
                                    {
                                        "lightness": 20
                                    }
                                ]
                            },
                            {
                                "featureType": "road.highway",
                                "elementType": "geometry.fill",
                                "stylers": [
                                    {
                                        "color": "#ffffff"
                                    },
                                    {
                                        "lightness": 17
                                    }
                                ]
                            },
                            {
                                "featureType": "road.highway",
                                "elementType": "geometry.stroke",
                                "stylers": [
                                    {
                                        "color": "#ffffff"
                                    },
                                    {
                                        "lightness": 29
                                    },
                                    {
                                        "weight": 0.2
                                    }
                                ]
                            },
                            {
                                "featureType": "road.arterial",
                                "elementType": "geometry",
                                "stylers": [
                                    {
                                        "color": "#ffffff"
                                    },
                                    {
                                        "lightness": 18
                                    }
                                ]
                            },
                            {
                                "featureType": "road.local",
                                "elementType": "geometry",
                                "stylers": [
                                    {
                                        "color": "#ffffff"
                                    },
                                    {
                                        "lightness": 16
                                    }
                                ]
                            },
                            {
                                "featureType": "poi",
                                "elementType": "geometry",
                                "stylers": [
                                    {
                                        "color": "#f5f5f5"
                                    },
                                    {
                                        "lightness": 21
                                    }
                                ]
                            },
                            {
                                "featureType": "poi.park",
                                "elementType": "geometry",
                                "stylers": [
                                    {
                                        "color": "#dedede"
                                    },
                                    {
                                        "lightness": 21
                                    }
                                ]
                            },
                            {
                                "elementType": "labels.text.stroke",
                                "stylers": [
                                    {
                                        "visibility": "on"
                                    },
                                    {
                                        "color": "#ffffff"
                                    },
                                    {
                                        "lightness": 16
                                    }
                                ]
                            },
                            {
                                "elementType": "labels.text.fill",
                                "stylers": [
                                    {
                                        "saturation": 36
                                    },
                                    {
                                        "color": "#333333"
                                    },
                                    {
                                        "lightness": 40
                                    }
                                ]
                            },
                            {
                                "elementType": "labels.icon",
                                "stylers": [
                                    {
                                        "visibility": "off"
                                    }
                                ]
                            },
                            {
                                "featureType": "transit",
                                "elementType": "geometry",
                                "stylers": [
                                    {
                                        "color": "#f2f2f2"
                                    },
                                    {
                                        "lightness": 19
                                    }
                                ]
                            },
                            {
                                "featureType": "administrative",
                                "elementType": "geometry.fill",
                                "stylers": [
                                    {
                                        "color": "#fefefe"
                                    },
                                    {
                                        "lightness": 20
                                    }
                                ]
                            },
                            {
                                "featureType": "administrative",
                                "elementType": "geometry.stroke",
                                "stylers": [
                                    {
                                        "color": "#fefefe"
                                    },
                                    {
                                        "lightness": 17
                                    },
                                    {
                                        "weight": 1.2
                                    }
                                ]
                            }
                        ]
                        
                    },  
                });
            }
            $('.map').css( 'height', $('.flat-maps').data('height') );
        }; // Google Map

        var googleMap_S2 = function() {            
            if ( $().gmap3 ) {  
                $(".map-2").gmap3({
                    map:{
                        options:{
                            zoom: 16,
                            mapTypeId: 'themesflat_style',
                            mapTypeControlOptions: {
                                mapTypeIds: ['themesflat_style', google.maps.MapTypeId.SATELLITE, google.maps.MapTypeId.HYBRID]
                            },
                            scrollwheel: false
                        }
                    },
                    getlatlng:{
                        address:  $('.flat-maps-2').data('address'),
                        callback: function(results) {
                            if ( !results ) return;
                            $(this).gmap3('get').setCenter(new google.maps.LatLng(results[0].geometry.location.lat(), results[0].geometry.location.lng()));
                            $(this).gmap3({
                                marker:{
                                    latLng:results[0].geometry.location,
                                    options:{
                                        icon: $('.flat-maps-2').data('image')
                                    }
                                }
                            });
                        }
                    },
                    styledmaptype:{
                        id: "themesflat_style",
                        options:{
                            name: "Yolo Map"
                        },
                        styles:[
                            {
                                "featureType": "all",
                                "elementType": "labels.text.fill",
                                "stylers": [
                                    {
                                        "saturation": 36
                                    },
                                    {
                                        "color": "#000000"
                                    },
                                    {
                                        "lightness": 40
                                    }
                                ]
                            },
                            {
                                "featureType": "all",
                                "elementType": "labels.text.stroke",
                                "stylers": [
                                    {
                                        "visibility": "on"
                                    },
                                    {
                                        "color": "#000000"
                                    },
                                    {
                                        "lightness": 16
                                    }
                                ]
                            },
                            {
                                "featureType": "all",
                                "elementType": "labels.icon",
                                "stylers": [
                                    {
                                        "visibility": "off"
                                    }
                                ]
                            },
                            {
                                "featureType": "administrative",
                                "elementType": "geometry.fill",
                                "stylers": [
                                    {
                                        "color": "#000000"
                                    },
                                    {
                                        "lightness": 20
                                    }
                                ]
                            },
                            {
                                "featureType": "administrative",
                                "elementType": "geometry.stroke",
                                "stylers": [
                                    {
                                        "color": "#000000"
                                    },
                                    {
                                        "lightness": 17
                                    },
                                    {
                                        "weight": 1.2
                                    }
                                ]
                            },
                            {
                                "featureType": "landscape",
                                "elementType": "geometry",
                                "stylers": [
                                    {
                                        "color": "#000000"
                                    },
                                    {
                                        "lightness": 20
                                    }
                                ]
                            },
                            {
                                "featureType": "poi",
                                "elementType": "geometry",
                                "stylers": [
                                    {
                                        "color": "#000000"
                                    },
                                    {
                                        "lightness": 21
                                    }
                                ]
                            },
                            {
                                "featureType": "road.highway",
                                "elementType": "geometry.fill",
                                "stylers": [
                                    {
                                        "color": "#000000"
                                    },
                                    {
                                        "lightness": 17
                                    }
                                ]
                            },
                            {
                                "featureType": "road.highway",
                                "elementType": "geometry.stroke",
                                "stylers": [
                                    {
                                        "color": "#000000"
                                    },
                                    {
                                        "lightness": 29
                                    },
                                    {
                                        "weight": 0.2
                                    }
                                ]
                            },
                            {
                                "featureType": "road.arterial",
                                "elementType": "geometry",
                                "stylers": [
                                    {
                                        "color": "#000000"
                                    },
                                    {
                                        "lightness": 18
                                    }
                                ]
                            },
                            {
                                "featureType": "road.local",
                                "elementType": "geometry",
                                "stylers": [
                                    {
                                        "color": "#000000"
                                    },
                                    {
                                        "lightness": 16
                                    }
                                ]
                            },
                            {
                                "featureType": "transit",
                                "elementType": "geometry",
                                "stylers": [
                                    {
                                        "color": "#000000"
                                    },
                                    {
                                        "lightness": 19
                                    }
                                ]
                            },
                            {
                                "featureType": "water",
                                "elementType": "geometry",
                                "stylers": [
                                    {
                                        "color": "#000000"
                                    },
                                    {
                                        "lightness": 17
                                    }
                                ]
                            }
                        ]
                        
                    },  
                });
            }
            $('.map-2').css( 'height', $('.flat-maps-2').data('height') );
        }; // Google Map S2

        var parallax = function() {
            if ( $().parallax && isMobile.any() === null ) {
                $('.parallax1').parallax("50%", 0.3);
                $('.parallax2').parallax("30%", 0.5);
                $('.parallax3').parallax("50%", 0.5);
                $('.parallax4').parallax("50%", 0.5);  
                $('.parallax5').parallax("50%", 0.7);
                $('.parallax6').parallax("50%", 0.5);
                $('.parallax7').parallax("50%", 0.5); 
                $('.parallax8').parallax("50%", 0.5);
                $('.parallax9').parallax("50%", 0.5);
                $('.parallax10').parallax("50%", 0.4);
                $('.parallax11').parallax("50%", 0.4); 
                $('.parallax12').parallax("100%", 0.5);
                $('.parallax13').parallax("50%", 0.5);
                $('.parallax15').parallax("50%", 0.6); 
            }
        }; // Parallax

        var heights = function() {
            $(window).on('load', function() { 
                $('.row-box').each(function() {
                    var h = $(".info-image").height();
                    $(".info-text").css({
                        height: h,
                    });
                    var h1 = $(".info-image.v1").height();
                    $(".info-text.v1").css({
                        height: h1,
                    });
                });
            });
        }; // Heights

        var tabProduct = function() {
            $('#main-shop .wrap-product').each(function() {
            $(this).find('.tab-product-content').children().hide();
            $(this).find('.tab-product-content').children().first().show().addClass('active');
            $(this).find('.tab-product-list').children('li').on('click', function(){
                    var liActive = $(this).index(),
                    contentActive = $(this).siblings().removeClass('active').parents('.wrap-product').find('.tab-product-content').children().eq(liActive);
                    contentActive.addClass('active').fadeIn("slow");
                    contentActive.siblings().removeClass('active');
                    $(this).addClass('active').parents('.wrap-product').find('.tab-product-content').children().eq(liActive).siblings().hide();
                });
            })
        }; // Tab Product

        var tabDetailProduct = function() {
            $('.product-content').each(function() {
            $(this).find('.tab-content').children().hide();
            $(this).find('.tab-content').children().first().show().addClass('active');
            $(this).find('.tab-detail-list').children('li').on('click', function(){
                var liActive = $(this).index(),
                contentActive = $(this).siblings().removeClass('active').parents('.product-content').find('.tab-content').children().eq(liActive);
                contentActive.addClass('active').fadeIn("slow");
                contentActive.siblings().removeClass('active');
                $(this).addClass('active').parents('.product-content').find('.tab-content').children().eq(liActive).siblings().hide();
            });
            });
        }; // Tab Detail Product

        var flexProduct = function() {
            $('.flexslider').flexslider({
                animation: "slide",
                controlNav: "thumbnails"
            });
        }; // Flex Product

        var gridPhotography = function() { 
            if ( $().isotope ) {           
                var $grid = $('.wrap-portfolio.padding-5');
                $grid.imagesLoaded(function(){
                    $grid.isotope({
                        itemSelector: '.ipsotope',
                        layoutMode: 'fitRows',
                        transitionDuration: '1s',
                        masonry: {
                            columnWidth: '.wrap-portfolio.padding-5'
                        }
                    });
                });          
            }; // Portfolio Isotope
        }; // Grid Photography

        var shopMetroIpsotope = function() { 
            if ( $().isotope ) {           
                var $container = $('.wrap-portfolio.style5.v1');
                $container.imagesLoaded(function(){
                    $container.isotope({
                        itemSelector: '.ipsotope',
                        layoutMode: 'masonry',
                        transitionDuration: '1s',
                        masonry: {
                            columnWidth: '.wrap-portfolio.style5.v1 .portfolio-item.one-four'
                        }
                    });          
                }); // Portfolio Isotope
            };
        }; // Grid Photography

        var ajaxSubscribe = {
            obj: {
                subscribeEmail    : $('#subscribe-email'),
                subscribeButton   : $('#subscribe-button'),
                subscribeMsg      : $('#subscribe-msg'),
                subscribeContent  : $("#subscribe-content"),
                dataMailchimp     : $('#subscribe-form').attr('data-mailchimp'),
                success_message   : '<div class="notification_ok">Thank you for joining our mailing list! Please check your email for a confirmation link.</div>',
                failure_message   : '<div class="notification_error">Error! <strong>There was a problem processing your submission.</strong></div>',
                noticeError       : '<div class="notification_error">{msg}</div>',
                noticeInfo        : '<div class="notification_error">{msg}</div>',
                basicAction       : 'mail/subscribe.php',
                mailChimpAction   : 'mail/subscribe-mailchimp.php'
            },

            eventLoad: function() {
                var objUse = ajaxSubscribe.obj;

                $(objUse.subscribeButton).on('click', function() {
                    if ( window.ajaxCalling ) return;
                    var isMailchimp = objUse.dataMailchimp === 'true';

                    if ( isMailchimp ) {
                        ajaxSubscribe.ajaxCall(objUse.mailChimpAction);
                    } else {
                        ajaxSubscribe.ajaxCall(objUse.basicAction);
                    }
                });
            },// event Load

            ajaxCall: function (action) {
                window.ajaxCalling = true;
                var objUse = ajaxSubscribe.obj;
                var messageDiv = objUse.subscribeMsg.html('').hide();
                $.ajax({
                    url: action,
                    type: 'POST',
                    dataType: 'json',
                    data: {
                       subscribeEmail: objUse.subscribeEmail.val()
                    },
                    success: function (responseData, textStatus, jqXHR) {
                        if ( responseData.status ) {
                            objUse.subscribeContent.fadeOut(500, function () {
                                messageDiv.html(objUse.success_message).fadeIn(500);
                            });
                        } else {
                            switch (responseData.msg) {
                                case "email-required":
                                    messageDiv.html(objUse.noticeError.replace('{msg}','Error! <strong>Email is required.</strong>'));
                                    break;
                                case "email-err":
                                    messageDiv.html(objUse.noticeError.replace('{msg}','Error! <strong>Email invalid.</strong>'));
                                    break;
                                case "duplicate":
                                    messageDiv.html(objUse.noticeError.replace('{msg}','Error! <strong>Email is duplicate.</strong>'));
                                    break;
                                case "filewrite":
                                    messageDiv.html(objUse.noticeInfo.replace('{msg}','Error! <strong>Mail list file is open.</strong>'));
                                    break;
                                case "undefined":
                                    messageDiv.html(objUse.noticeInfo.replace('{msg}','Error! <strong>undefined error.</strong>'));
                                    break;
                                case "api-error":
                                    objUse.subscribeContent.fadeOut(500, function () {
                                        messageDiv.html(objUse.failure_message);
                                    });
                            }
                            messageDiv.fadeIn(500);
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert('Connection error');
                    },
                    complete: function (data) {
                        window.ajaxCalling = false;
                    }
                });
            } // ajaxCall
        }; // ajax Subscribe

        var ajaxContactForm = function() {  
            $('#contactform').each(function() {
                $(this).validate({
                    submitHandler: function( form ) {
                        var $form = $(form),
                            str = $form.serialize(),
                            loading = $('<div />', { 'class': 'loading' });

                        $.ajax({
                            type: "POST",
                            url:  $form.attr('action'),
                            data: str,
                            beforeSend: function () {
                                $form.find('.form-submit').append(loading);
                            },
                            success: function( msg ) {
                                var result, cls;                            
                                if ( msg === 'Success' ) {                                
                                    result == 'Message Sent Successfully To Email Administrator. ( You can change the email management a very easy way to get the message of customers in the user manual )';
                                    cls == 'msg-success';
                                } else {
                                    result == 'Error sending email.';
                                    cls == 'msg-error';
                                }

                                $form.prepend(
                                    $('<div />', {
                                        'class': 'flat-alert ' + cls,
                                        'text' : result
                                    }).append(
                                        $('<a class="close" href="#"><i class="fa fa-close"></i></a>')
                                    )
                                );

                                $form.find(':input').not('.submit').val('');
                            },
                            complete: function (xhr, status, error_thrown) {
                                $form.find('.loading').remove();
                            }
                        });
                    }
                });
            }); // each contactform
        };   // ajax ContactForm

        var swClick = function () {
            function activeLayout () {
                $(".switcher-container" ).on( "click", "a.sw-light", function() {
                    $(this).toggleClass( "active" );
                    $('body').addClass('home-boxed');  
                    $('body').css({'background': '#f6f6f6' });                
                    $('.sw-pattern.pattern').css ({ "top": "100%", "opacity": 1, "z-index": "10"});
                }).on( "click", "a.sw-dark", function() {
                    $('.sw-pattern.pattern').css ({ "top": "98%", "opacity": 0, "z-index": "-1"});
                    $(this).removeClass('active').addClass('active');
                    $('body').removeClass('home-boxed');
                    $('body').css({'background': '#fff' });
                    return false;
                })       
            }

            function activePattern () {
                $('.sw-pattern').on('click', function () {
                    $('.sw-pattern.pattern a').removeClass('current');
                    $(this).addClass('current');
                    $('body').css({'background': 'url("' + $(this).data('image') + '")', 'background-size' : '30px 30px', 'background-repeat': 'repeat' });
                    return false;
                })
            }
            activeLayout(); 
            activePattern();
        } // Swicher Click

        var goTop = function(){
            var gotop = $('.go-top');
            $(window).on('scroll', function() {
                if ($(this).scrollTop() > 500) {
                    gotop.addClass('show');
                } else {
                    gotop.removeClass('show');
                }
            });
            gotop.on('click', function() {
                $('html, body').animate({ scrollTop: 0}, 800, 'easeInOutExpo');
                return false;
            });
        }; // Go Top

        var scroll = function() {
            var scrollDown = $('.scroll-down a');
            scrollDown.on('click', function() {
                $('html, body').animate({ scrollTop: $( $(this).attr('href') ).offset().top - 30}, 800);
                return false;
            });
        } // Scroll

        var removePreloader = function() {        
            $('.preloader').fadeOut('2s',function () {
                $(this).remove();
            });
        }; // Remove Preloader

    // Dom Ready
    $(function() {
        responsiveMenu();
        searchButton();
        menuCanvas();
        Filterbox();
        slidePartner();
        slideTestimonial();
        slideTestimonial_S2();
        slideTestimonial_S3();
        slideTestimonial_S4();
        slideCarousel();
        slideClients();
        slideRelated();
        slideSingleSimple();
        slidePhotography();
        slidePhotography_s2();
        slideVideo();
        slideVideo_S2();
        slideProject();
        slideImagebox();
        slideImagebox_s2();
        slideOurwork();
        slideOwl_carousel();
        slideImagebox_s3();
        slidePartner_s2();
        tabAbout();
        counterAbout();
        progressBar();
        countdown_1();
        CountDown();
        CountDown_S2();
        videoPopup();
        accordionToggle();
        portfolioIsotope();
        googleMap();
        googleMap_S2();
        parallax();
        heights();
        flexProduct();
        tabProduct();
        tabDetailProduct();
        detectViewport();
        gridPhotography();
        shopMetroIpsotope();
        ajaxSubscribe.eventLoad();
        ajaxContactForm();
        swClick();
        goTop();
        scroll();
        removePreloader();
    });

})(jQuery);

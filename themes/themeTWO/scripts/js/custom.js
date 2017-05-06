//============================== header =========================
jQuery(document).ready(function(){
	"use strict";
	$(window).load(function(){
		$('.body-wrapper').each(function(){
			var header_area = $('.header');
			var main_area = header_area.children('.navbar');

			var logo = main_area.find('.navbar-header');
			var navigation = main_area.find('.navbar-collapse');				
			var original = {
				nav_top: navigation.css('margin-top')
			};
				
			$(window).scroll(function(){
				if( main_area.hasClass('bb-fixed-header') && ($(this).scrollTop() == 0 || $(this).width() < 750)){
					main_area.removeClass('bb-fixed-header').appendTo(header_area);
					navigation.animate({'margin-top': original.nav_top}, {duration: 100, queue: false, complete: function(){
						header_area.css('height', 'auto');
					}});								
				}else if( !main_area.hasClass('bb-fixed-header') && $(this).width() > 750 &&
					$(this).scrollTop() > header_area.offset().top + header_area.height() - parseInt($('html').css('margin-top')) ){
					
					header_area.css('height', header_area.height());
					main_area.css({'opacity': '0'}).addClass('bb-fixed-header');
					main_area.appendTo($('body')).animate({'opacity': 1});
						
					navigation.css({'margin-top': '0px'});
				}				
			});
		});			
		
		$(window).trigger('resize');
		$(window).trigger('scroll');
	});
});


//============================== ALL DROPDOWN ON HOVER =========================
jQuery(document).ready(function(){
	if($(".navbar").width() > 1007)
	{
		$('.nav .dropdown').hover(function() {
        	$(this).addClass('open');
	    },
	    function() {
	        $(this).removeClass('open');
	    });
	};
	$('.nav-category .dropdown-submenu ').hover(function() {
    	$(this).addClass('open');
    },
    function() {
        $(this).removeClass('open');
    });
});
//============================== SEARCH =========================
jQuery(document).ready(function(){
	$('.searchBox a').on("click",function() {
	    $(".searchBox .dropdown-menu").toggleClass('display-block');
	    $(".searchBox a i").toggleClass('fa-close').toggleClass("fa-search");
	});
});
//============================== RS-SLIDER =========================
jQuery(document).ready(function() {
	jQuery('.bannerV1 .fullscreenbanner').revolution({
		delay: 5000,
		startwidth: 1170,
		startheight: 500,
		fullWidth: "on",
		fullScreen: "off",
		hideCaptionAtLimit: "",
		dottedOverlay: "twoxtwo",
		navigationStyle: "preview4",
		fullScreenOffsetContainer: "",
		hideTimerBar:"on",
	});

	jQuery('.bannerV4 .fullscreenbanner').revolution({
		delay: 5000,
		startwidth: 835,
		startheight: 470,
		fullWidth: "off",
		fullScreen: "off",
		hideCaptionAtLimit: "",
		dottedOverlay: "twoxtwo",
		navigationStyle: "preview4",
		fullScreenOffsetContainer: "",
		hideTimerBar:"on",
		onHoverStop:"on",
	});
});

//============================== OWL-CAROUSEL =========================
jQuery(document).ready(function() {
	"use strict";
	var owl = $('.owl-carousel.featuredProductsSlider');
	  owl.owlCarousel({
		  loop:true,
		  margin:28,
		  autoplay:true,
		  autoplayTimeout:2000,
		  autoplayHoverPause:true,
		  nav:true,
		  moveSlides: 4,
		  dots: false,
		  responsive:{
			  320:{
				  items:1
			  },
			  768:{
				  items:3
			  },
			  992:{
			  	items:4
			  }
		  }
	  });
	var owl = $('.owl-carousel.partnersLogoSlider');
	  owl.owlCarousel({
		  loop:true,
		  margin:28,
		  autoplay:true,
		  autoplayTimeout:3000,
		  autoplayHoverPause:true,
		  nav:true,
		  dots: false,
		  responsive:{
			  320:{
			  	slideBy: 1,
				  items:1
			  },
			  768:{
			  	slideBy: 3,
				  items:3
			  },
			  992:{
			  	slideBy: 5,
				  items:5
			  }
		  }
	  });

	var owl = $('.owl-carousel.featuredCollectionSlider');
	  owl.owlCarousel({
		  loop:true,
		  margin:28,
		  autoplay:false,
		  autoplayHoverPause:true,
		  nav:true,
		  dots: false,
		  responsive:{
			  320:{
			  	slideBy: 1,
				  items:1
			  },
			  768:{
			  	slideBy: 2,
				  items:2
			  },
			  992:{
			  	slideBy: 2,
			  	items:2
			  }
		  }
	  });

	  var owl = $('.owl-carousel.dealSlider');
	  owl.owlCarousel({
		  loop:true,
		  margin:28,
		  autoplay:false,
		  nav:true,
		  moveSlides: 1,
		  dots: false,
		  responsive:{
			  320:{
			  	slideBy: 1,
				  items:1
			  },
			  768:{
			  	slideBy: 3,
				  items:3
			  },
			  992:{
			  	slideBy: 3,
			  	items:3
			  }
		  }
	  });

	  var owl = $('.owl-carousel.testimonialSlider');
	  owl.owlCarousel({
		  loop:true,
		  margin:28,
		  autoplay:true,
		  autoplayTimeout:4000,
		  autoplayHoverPause:true,
		  smartSpeed:1000,
		  nav:true,
		  moveSlides: 1,
		  dots: false,
		  responsive:{
			  320:{
				  items:1
			  },
			  768:{
				  items:1
			  },
			  992:{
			  	items:1
			  }
		  }
	  });

	  var owl = $('.owl-carousel.categorySlider');
	  owl.owlCarousel({
		  loop:true,
		  margin:28,
		  autoplay:false,
		  nav:true,
		  moveSlides: 1,
		  dots: false,
		  smartSpeed:1000,
		  responsive:{
			  320:{
				  items:1
			  },
			  768:{
				  items:1
			  },
			  992:{
			  	items:1
			  }
		  }
	  });

	var owl = $('.owl-carousel.bannerV3');
	  owl.owlCarousel({
		  loop:true,
		  autoplay:true,
		  autoplayTimeout:4000,
		  autoplayHoverPause:true,
		  nav:true,
		  moveSlides: 1,
		  dots: false,
		  margin: 15,
		  items: 1,
		  responsive:{
			  320:{
				  items:1,
				  stagePadding: 20
			  },
			  768:{
				  items:1,
				  stagePadding: 100,
				  margin: 50
			  },
			  992:{
			  	items:1,
			  	stagePadding: 250,
			  	 margin: 50
			  }
		  }
	  });

});
//============================== SELECT BOX =========================
jQuery(document).ready(function() {
	$('.select-drop').selectbox();
});

//============================== SIDE NAV MENU TOGGLE =========================
jQuery(document).ready(function() {
	$('.side-nav li a').click(function() {
		$(this).find('i').toggleClass('fa fa-minus fa fa-plus');
	});
});

//============================== PRICE SLIDER RANGER =========================
jQuery(document).ready(function() {
	var minimum = 20;
	var maximum = 300;

	$( "#price-range" ).slider({
		range: true,
		min: minimum,
		max: maximum,
		values: [ minimum, maximum ],
		slide: function( event, ui ) {
			$( "#price-amount-1" ).val( "$" + ui.values[ 0 ] );
			$( "#price-amount-2" ).val( "$" + ui.values[ 1 ] );
		}
	});

	$( "#price-amount-1" ).val( "$" + $( "#price-range" ).slider( "values", 0 ));
	$( "#price-amount-2" ).val( "$" + $( "#price-range" ).slider( "values", 1 ));
});
//============================== PRODUCT SINGLE SLIDER =========================
jQuery(document).ready(function() {
	(function($){
	  $('#thumbcarousel').carousel(0);
	  var $thumbItems = $('#thumbcarousel .item');
	    $('#carousel').on('slide.bs.carousel', function (event) {
	     var $slide = $(event.relatedTarget);
	     var thumbIndex = $slide.data('thumb');
	     var curThumbIndex = $thumbItems.index($thumbItems.filter('.active').get(0));
	    if (curThumbIndex>thumbIndex) {
	      $('#thumbcarousel').one('slid.bs.carousel', function (event) {
	        $('#thumbcarousel').carousel(thumbIndex);
	      });
	      if (curThumbIndex === ($thumbItems.length-1)) {
	        $('#thumbcarousel').carousel('next');
	      } else {
	        $('#thumbcarousel').carousel(numThumbItems-1);
	      }
	    } else {
	      $('#thumbcarousel').carousel(thumbIndex);
	    }
	  });
	})(jQuery);
});

jQuery(document).ready(function() {
	$(".quick-view .btn-block").click(function(){
        $(".quick-view").modal("hide");
    });
});

//============================== Count down triger =========================
jQuery(document).ready(function() {
	"use strict";
 	$('#simple_timer').syotimer({
        year: 2017,
        month: 5,
        day: 9,
        hour: 20,
        minute: 30,
    });
    $('.bannerV3 #slider_timer').syotimer({
        year: 2017,
        month: 1,
        day: 9,
        hour: 20,
        minute: 30,
    });
});

//============================== ACCORDION OR COLLAPSE ICON CHANGE =========================
  
    var allIcons = $("#faqAccordion .panel-heading i.fa");
    $('#faqAccordion .panel-heading').click(function(){
      allIcons.removeClass('fa-chevron-down').addClass('fa-chevron-up');
      $(this).find('i.fa').removeClass('fa-chevron-up').addClass('fa-chevron-down');
    });

    var allIconsOne = $("#accordionOne .panel-heading i.fa");
    $('#accordionOne .panel-heading').click(function(){
      allIconsOne.removeClass('fa-chevron-down').addClass('fa-chevron-up');
      $(this).find('i.fa').removeClass('fa-chevron-up').addClass('fa-chevron-down');
    });

    var allIconsTwo = $("#accordionTwo .panel-heading i.fa");
    $('#accordionTwo .panel-heading').click(function(){
      allIconsTwo.removeClass('fa-chevron-down').addClass('fa-chevron-up');
      $(this).find('i.fa').removeClass('fa-chevron-up').addClass('fa-chevron-down');
    });

    var allIconsThree = $("#togglesOne .panel-heading i.fa");
    $('#togglesOne .panel-heading').click(function(){
      allIconsThree.removeClass('fa-chevron-down').addClass('fa-chevron-up');
      $(this).find('i.fa').removeClass('fa-chevron-up').addClass('fa-chevron-down');
    });

    var allIconsFour = $("#togglesTwo .panel-heading i.fa");
    $('#togglesTwo .panel-heading').click(function(){
      allIconsFour.removeClass('fa-chevron-down').addClass('fa-chevron-up');
      $(this).find('i.fa').removeClass('fa-chevron-up').addClass('fa-chevron-down');
    });
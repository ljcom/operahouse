<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
    <script>
      var meta = document.createElement('meta');
      meta.charset = "UTF-8";
      loadMeta(meta);

      var meta = document.createElement('meta');
      meta.httpEquiv = "X-UA-Compatible";
      meta.content = "IE=edge";
      loadMeta(meta);

      var meta = document.createElement('meta');
      meta.name = "viewport";
      meta.content = "width=device-width, initial-scale=1";
      loadMeta(meta);

      $("body").addClass("booking-page");

      //primary css and style in manifest.xml
      
      loadStyle('OPHContent/themes/themeDHUB/vendors/kalendae/kalendae.css');
      loadStyle('OPHContent/themes/themeDHUB/vendors/jquery-flexdatalist/jquery.flexdatalist.min.css');
      loadStyle('OPHContent/themes/themeDHUB/css/vendors/jquery-flexdatalist/jquery.flexdatalist.min.css');

      (function () {
      $(document).ready(function () {
      var dropDownToggle = $('.dropdown-toggle');

      $(".navbar-toggler").on("click", function () {
      $(this).toggleClass("is-active");
      });

      dropDownToggle.click(function() {
      var dropdownList = $(this).parent().find('.dropdown-menu');
      var dropdownOffset = $(this).offset();
      var offsetLeft = dropdownOffset.left;
      var dropdownWidth = dropdownList.width() / 2;
      var docWidth = $(window).width();

      var isDropdownVisible = (offsetLeft + dropdownWidth &#60;= docWidth);

      if (!isDropdownVisible) {
      dropdownList.addClass('dropdown-menu-right');
      } else {
      dropdownList.removeClass('dropdown-menu-right');
      }
      });
      });
      })(jQuery);

      loadScript('OPHContent/themes/themeDHUB/vendors/kalendae/kalendae.standalone.min.js');
      loadScript('OPHContent/themes/themeDHUB/js/booking.js');

    </script>


    <div class="header-booking">
      <div id="header-booking" class="header-booking__menu">
        <div class="container-fluid">
          <nav class="navbar navbar-toggleable-lg">
            <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#header-booking-menu">
              <span class="icon-bar">&#160;</span>
              <span class="icon-bar">&#160;</span>
              <span class="icon-bar">&#160;</span>
            </button>
            <a class="navbar-brand" href="index.html">
              <img src="OPHContent/themes/themeDHUB/images/logo/logo.png" class="header-booking__logo" alt=""/>
              <img src="OPHContent/themes/themeDHUB/images/logo/logo-sm.png" class="header-booking__logo-sm" alt=""/>
            </a>
            <div id="header-booking-menu" class="collapse navbar-collapse">
              <div class="header-booking__menu-collapse">
                <form class="form-inline header-booking__form">
                  <div class="form-control-inline-icon inline-icon-left header-booking__location">
                    <span class="icon iconfont-left iconfont-search-location">&#160;</span>
                    <input id="example-text-input-with-left-icon" type="text" class="form-control" placeholder="Anywhere"/>
                  </div>
                  <div class="form-control-inline-icon inline-icon-left header-booking__date-range">
                    <span class="icon iconfont-left iconfont-datepicker">&#160;</span>
                    <input id="booking-date-picker" class="form-control" type="text" placeholder="Anytime"/>
                  </div>
                  <div class="header-booking__search-passengers dropdown">
                    <button class="btn dropdown-toggle header-booking__search-passengers-dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <!--data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"-->
                      <span class="icon iconfont-user-group">&#160;</span>
                      <span class="header-booking__search-passengers-amount">1 Adult</span>
                    </button>
                    <div class="dropdown-menu header-booking__search-passengers-dropdown">
                      <div class="header-booking__search-passenger-type">
                        <span class="header-booking__search-passenger-type-title">Adults</span>
                        <div class="input-group header-booking__search-passenger-type-amount">
                          <span class="input-group-btn">
                            <button class="btn btn-outline-secondary" type="button">
                              <span class="icon iconfont-dash">&#160;</span>
                            </button>
                          </span>
                          <input type="text" class="form-control" placeholder="1" value="1"/>
                          <span class="input-group-btn">
                            <button class="btn btn-outline-secondary" type="button">
                              <span class="icon iconfont-plus">&#160;</span>
                            </button>
                          </span>
                        </div>
                      </div>
                      <div class="header-booking__search-passenger-type">
                        <span class="header-booking__search-passenger-type-title">Children up to 12</span>
                        <div class="input-group header-booking__search-passenger-type-amount">
                          <span class="input-group-btn">
                            <button class="btn btn-outline-secondary" type="button">
                              <span class="icon iconfont-dash">&#160;</span>
                            </button>
                          </span>
                          <input type="text" class="form-control" placeholder="0" value="0"/>
                          <span class="input-group-btn">
                            <button class="btn btn-outline-secondary" type="button">
                              <span class="icon iconfont-plus">&#160;</span>
                            </button>
                          </span>
                        </div>
                      </div>
                      <div class="header-booking__search-passenger-type">
                        <span class="header-booking__search-passenger-type-title">Babies</span>
                        <div class="input-group header-booking__search-passenger-type-amount">
                          <span class="input-group-btn">
                            <button class="btn btn-outline-secondary" type="button">
                              <span class="icon iconfont-dash">&#160;</span>
                            </button>
                          </span>
                          <input type="text" class="form-control" placeholder="0" value="0"/>
                          <span class="input-group-btn">
                            <button class="btn btn-outline-secondary" type="button">
                              <span class="icon iconfont-plus">&#160;</span>
                            </button>
                          </span>
                        </div>
                      </div>
                      <div class="header-booking__search-passengers-actions">
                        <a href="#" class="header-booking__search-passengers-cancel">Cancel</a>
                        <a href="#" class="header-booking__search-passengers-apply">Apply</a>
                      </div>
                    </div>
                  </div>
                </form>
                <div class="header-booking__links">
                  <a href="#" class="btn-link">Become a Host</a>
                  <a href="#" class="btn-link">Help</a>
                  <a href="#" class="btn-link">Sign Up</a>
                </div>
              </div>
            </div>
          </nav>
          <nav class="nav header-booking__nav">
            <a class="nav-link active" href="#">For you</a>
            <a class="nav-link" href="#">Homes</a>
            <a class="nav-link" href="#">Experiences</a>
            <a class="nav-link" href="#">Places</a>
          </nav>
        </div>
      </div>
    </div>
    <div class="listings-booking">
      <div class="container">
        <h2 class="listings-booking__heading">Just booked</h2>
        <div class="listings-booking__items">
          <div class="listings-booking__item">
            <img src="OPHContent/themes/themeDHUB/images/booking/listings/01.png" alt="" class="embed-responsive listings-booking__item-image"/>
            <div class="listings-booking__item-info">
              <a href="?env=GOPELAGO_data&#38;code=detailtrip" class="listings-booking__item-name">
                <strong class="listings-booking__item-price">$7956</strong> Step behind the scene of Havanas theater
              </a>

              <div class="listings-booking__item-rating">
                <span class="listings-booking__item-rating-stars">
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-outline">&#160;</span>
                </span>
                <span class="listings-booking__item-rating-amount">84 reviews</span>
              </div>
            </div>
          </div>
          <div class="listings-booking__item">
            <img src="OPHContent/themes/themeDHUB/images/booking/listings/02.png" alt="" class="embed-responsive listings-booking__item-image"/>
            <div class="listings-booking__item-info">
              <a href="#" class="listings-booking__item-name">
                <strong class="listings-booking__item-price">$7956</strong> Step behind the scene of Havanas theater
              </a>

              <div class="listings-booking__item-rating">
                <span class="listings-booking__item-rating-stars">
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-outline">&#160;</span>
                </span>
                <span class="listings-booking__item-rating-amount">84 reviews</span>
              </div>
            </div>
          </div>
          <div class="listings-booking__item">
            <img src="OPHContent/themes/themeDHUB/images/booking/listings/03.png" alt="" class="embed-responsive listings-booking__item-image"/>
            <div class="listings-booking__item-info">
              <a href="#" class="listings-booking__item-name">
                <strong class="listings-booking__item-price">$7956</strong> Step behind the scene of Havanas theater
              </a>

              <div class="listings-booking__item-rating">
                <span class="listings-booking__item-rating-stars">
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-outline"></span>
                </span>
                <span class="listings-booking__item-rating-amount">84 reviews</span>
              </div>
            </div>
          </div>
          <div class="listings-booking__item">
            <img src="OPHContent/themes/themeDHUB/images/booking/listings/04.png" alt="" class="embed-responsive listings-booking__item-image"/>
            <div class="listings-booking__item-info">
              <a href="#" class="listings-booking__item-name">
                <strong class="listings-booking__item-price">$7956</strong> Step behind the scene of Havanas theater
              </a>

              <div class="listings-booking__item-rating">
                <span class="listings-booking__item-rating-stars">
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-outline"></span>
                </span>
                <span class="listings-booking__item-rating-amount">84 reviews</span>
              </div>
            </div>
          </div>
          <div class="listings-booking__item">
            <img src="OPHContent/themes/themeDHUB/images/booking/listings/05.png" alt="" class="embed-responsive listings-booking__item-image"/>
            <div class="listings-booking__item-info">
              <a href="#" class="listings-booking__item-name">
                <strong class="listings-booking__item-price">$7956</strong> Step behind the scene of Havanas theater
              </a>

              <div class="listings-booking__item-rating">
                <span class="listings-booking__item-rating-stars">
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-outline"></span>
                </span>
                <span class="listings-booking__item-rating-amount">84 reviews</span>
              </div>
            </div>
          </div>
        </div>

        <h2 class="listings-booking__heading">
          Features destinations <a href="#" class="listings-booking__heading-see-all">See all</a>
        </h2>

        <div class="row listings-booking__feature-items">
          <div class="col-lg-2 col-md-6">
            <div class="listings-booking__feature">
              <img src="OPHContent/themes/themeDHUB/images/booking/listings/06.png" alt="" class="listings-booking__feature-image" style=" position: relative; display: block; width: 100%; padding: 0; overflow: hidden;"/>
              <a href="#" class="listings-booking__feature-name">Los Angeles</a>
            </div>
          </div>
          <div class="col-lg-2 col-md-6">
            <div class="listings-booking__feature">
              <img src="OPHContent/themes/themeDHUB/images/booking/listings/07.png" alt="" class="listings-booking__feature-image" style=" position: relative; display: block; width: 100%; padding: 0; overflow: hidden;"/>
              <a href="#" class="listings-booking__feature-name">Florence</a>
            </div>
          </div>
          <div class="col-lg-2 col-md-6">
            <div class="listings-booking__feature">
              <img src="OPHContent/themes/themeDHUB/images/booking/listings/08.png" alt="" class="listings-booking__feature-image" style=" position: relative; display: block; width: 100%; padding: 0; overflow: hidden;"/>
              <a href="#" class="listings-booking__feature-name">Paris</a>
            </div>
          </div>
          <div class="col-lg-2 col-md-6">
            <div class="listings-booking__feature">
              <img src="OPHContent/themes/themeDHUB/images/booking/listings/09.png" alt="" class="listings-booking__feature-image" style=" position: relative; display: block; width: 100%; padding: 0; overflow: hidden;"/>
              <a href="#" class="listings-booking__feature-name">Amsterdam</a>
            </div>
          </div>
          <div class="col-lg-2 col-md-6">
            <div class="listings-booking__feature">
              <img src="OPHContent/themes/themeDHUB/images/booking/listings/10.png" alt="" class="listings-booking__feature-image" style=" position: relative; display: block; width: 100%; padding: 0; overflow: hidden;"/>
              <a href="#" class="listings-booking__feature-name">Seoul</a>
            </div>
          </div>
          <div class="col-lg-2 col-md-6">
            <div class="listings-booking__feature">
              <img src="OPHContent/themes/themeDHUB/images/booking/listings/11.png" alt="" class="listings-booking__feature-image" style=" position: relative; display: block; width: 100%; padding: 0; overflow: hidden;"/>
              <a href="#" class="listings-booking__feature-name">Miami</a>
            </div>
          </div>
        </div>

        <h2 class="listings-booking__heading">
          Experience <a href="#" class="listings-booking__heading-see-all">See all</a>
        </h2>
        <div class="listings-booking__items">
          <div class="listings-booking__item">
            <img src="OPHContent/themes/themeDHUB/images/booking/listings/12.png" alt="" class="embed-responsive listings-booking__item-image"/>
            <div class="listings-booking__item-info">
              <a href="#" class="listings-booking__item-name">
                <strong class="listings-booking__item-price">$7956</strong> Step behind the scene of Havanas theater
              </a>

              <div class="listings-booking__item-rating">
                <span class="listings-booking__item-rating-stars">
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-outline"></span>
                </span>
                <span class="listings-booking__item-rating-amount">84 reviews</span>
              </div>
            </div>
          </div>
          <div class="listings-booking__item">
            <img src="OPHContent/themes/themeDHUB/images/booking/listings/13.png" alt="" class="embed-responsive listings-booking__item-image"/>
            <div class="listings-booking__item-info">
              <a href="#" class="listings-booking__item-name">
                <strong class="listings-booking__item-price">$7956</strong> Step behind the scene of Havanas theater
              </a>

              <div class="listings-booking__item-rating">
                <span class="listings-booking__item-rating-stars">
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-outline"></span>
                </span>
                <span class="listings-booking__item-rating-amount">84 reviews</span>
              </div>
            </div>
          </div>
          <div class="listings-booking__item">
            <img src="OPHContent/themes/themeDHUB/images/booking/listings/14.png" alt="" class="embed-responsive listings-booking__item-image"/>
            <div class="listings-booking__item-info">
              <a href="#" class="listings-booking__item-name">
                <strong class="listings-booking__item-price">$7956</strong> Step behind the scene of Havanas theater
              </a>

              <div class="listings-booking__item-rating">
                <span class="listings-booking__item-rating-stars">
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-outline"></span>
                </span>
                <span class="listings-booking__item-rating-amount">84 reviews</span>
              </div>
            </div>
          </div>
          <div class="listings-booking__item">
            <img src="OPHContent/themes/themeDHUB/images/booking/listings/15.png" alt="" class="embed-responsive listings-booking__item-image"/>
            <div class="listings-booking__item-info">
              <a href="#" class="listings-booking__item-name">
                <strong class="listings-booking__item-price">$7956</strong> Step behind the scene of Havanas theater
              </a>

              <div class="listings-booking__item-rating">
                <span class="listings-booking__item-rating-stars">
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-outline"></span>
                </span>
                <span class="listings-booking__item-rating-amount">84 reviews</span>
              </div>
            </div>
          </div>
          <div class="listings-booking__item">
            <img src="OPHContent/themes/themeDHUB/images/booking/listings/16.png" alt="" class="embed-responsive listings-booking__item-image"/>
            <div class="listings-booking__item-info">
              <a href="#" class="listings-booking__item-name">
                <strong class="listings-booking__item-price">$7956</strong> Step behind the scene of Havanas theater
              </a>

              <div class="listings-booking__item-rating">
                <span class="listings-booking__item-rating-stars">
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-solid">&#160;</span>
                  <span class="icon iconfont-star-outline"></span>
                </span>
                <span class="listings-booking__item-rating-amount">84 reviews</span>
              </div>
            </div>
          </div>
        </div>

        <h2 class="listings-booking__heading">Places in London</h2>
        <div class="listings-booking__items">
          <div class="listings-booking__item">
            <img src="OPHContent/themes/themeDHUB/images/booking/listings/17.png" alt="" class="embed-responsive listings-booking__item-image"/>
            <div class="listings-booking__item-info">
              <a href="#" class="listings-booking__item-name">
                <strong class="listings-booking__item-price">By Canada Stacker</strong> Food Blogger
              </a>
            </div>
          </div>
          <div class="listings-booking__item">
            <img src="OPHContent/themes/themeDHUB/images/booking/listings/18.png" alt="" class="embed-responsive listings-booking__item-image"/>
            <div class="listings-booking__item-info">
              <a href="#" class="listings-booking__item-name">
                <strong class="listings-booking__item-price">By Canada Stacker</strong> Food Blogger
              </a>
            </div>
          </div>
          <div class="listings-booking__item">
            <img src="OPHContent/themes/themeDHUB/images/booking/listings/19.png" alt="" class="embed-responsive listings-booking__item-image"/>
            <div class="listings-booking__item-info">
              <a href="#" class="listings-booking__item-name">
                <strong class="listings-booking__item-price">By Canada Stacker</strong> Food Blogger
              </a>
            </div>
          </div>
          <div class="listings-booking__item">
            <img src="OPHContent/themes/themeDHUB/images/booking/listings/20.png" alt="" class="embed-responsive listings-booking__item-image"/>
            <div class="listings-booking__item-info">
              <a href="#" class="listings-booking__item-name">
                <strong class="listings-booking__item-price">By Canada Stacker</strong> Food Blogger
              </a>
            </div>
          </div>
          <div class="listings-booking__item">
            <img src="OPHContent/themes/themeDHUB/images/booking/listings/21.png" alt="" class="embed-responsive listings-booking__item-image"/>
            <div class="listings-booking__item-info">
              <a href="#" class="listings-booking__item-name">
                <strong class="listings-booking__item-price">By Canada Stacker</strong> Food Blogger
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="footer-default footer-default--booking">
      <div class="container">
        <div class="row">
          <div class="col-lg-6">
            <span class="footer-default__copyright">© GOPELAGO.COM. All Rights Reserved.</span>
          </div>
          <div class="col-lg-6">
            <div class="footer-default__follow-us">
              <span class="footer-default__follow-us-text">Follow Us</span>

              <div class="footer-default__follow-us-items">
                <a href="" class="footer-default__follow-us-item">
                  <img src="OPHContent/themes/themeDHUB/images/social/google-plus.png" alt=""/>
                </a>
                <a href="" class="footer-default__follow-us-item">
                  <img src="OPHContent/themes/themeDHUB/images/social/twitter.png" alt=""/>
                </a>
                <a href="" class="footer-default__follow-us-item">
                  <img src="OPHContent/themes/themeDHUB/images/social/facebook.png" alt=""/>
                </a>
                <a href="" class="footer-default__follow-us-item">
                  <img src="OPHContent/themes/themeDHUB/images/social/linkedin.png" alt=""/>
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

  </xsl:template>
</xsl:stylesheet>
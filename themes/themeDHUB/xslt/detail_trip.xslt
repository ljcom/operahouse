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

      loadStyle('OPHContent/themes/themeDHUB/vendors/leaflet/leaflet.css');
      loadStyle('OPHContent/themes/themeDHUB/vendors/lightslider/css/lightslider.min.css');
      loadStyle('OPHContent/themes/themeDHUB/css/custom-me.css');

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

      loadScript('OPHContent/themes/themeDHUB/vendors/leaflet/leaflet.js');
      loadScript('OPHContent/themes/themeDHUB/vendors/lightslider/js/lightslider.min.js');
      loadScript('OPHContent/themes/themeDHUB/js/apartment.js');

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
            &#160;

          </nav>
        </div>
      </div>
    </div>
    <div class="apartment">
      <div class="apartment__wrap">
        <h1 class="apartment__name">First to Reach Corcovado</h1>
        <div class="apartment__location">
          Rio de Janeiro · Be among the first groups to reach Corcovado · Hosted by <a href="#host">John</a>
        </div>

        <div class="apartment__price">
          Rp658,843 per person
        </div>

        <a href="#" class="btn btn-primary apartment__price-make-reservation" >See dates</a>

        <div class="apartment__description">
          We’ll pick you up and take you on the first van up Corcovado Mountain, arriving there when the gates open at 8am. You’ll basically have one of the world's most famous statues with open arms with fewer people than usual– an opportunity to appreciate and take a photo with Rio de Janeiro's most emblematic postcard. We’ll then head to a nearby restaurant for breakfast and enjoy the most beautiful view of the Tijuca Forest. We’ll close out with a guided tour of an exhibition on the nearby landmarks.
        </div>

        <div class="apartment__unique-id">
          People are eyeing this experience. Over 900 people have viewed it this week.
        </div>
      </div>
      <div class="apartment__image-slider">
        <ul id="apartment-image-slider">
          <li data-thumb="OPHContent/documents/gopelago/sample/7e9be17f-a90a-4462-8689-f34c36eb06a4.jpg">
            <img src="OPHContent/documents/gopelago/sample/7e9be17f-a90a-4462-8689-f34c36eb06a4.jpg" alt=""/>
          </li>
          <li data-thumb="OPHContent/documents/gopelago/sample/9a59f37f-fcfb-4560-a614-93ae4200b364.jpg">
            <img src="OPHContent/documents/gopelago/sample/9a59f37f-fcfb-4560-a614-93ae4200b364.jpg" alt=""/>
          </li>
          <li data-thumb="OPHContent/documents/gopelago/sample/a5e4eb55-f852-4096-a91a-be166c7ea5e8.jpg">
            <img src="OPHContent/documents/gopelago/sample/a5e4eb55-f852-4096-a91a-be166c7ea5e8.jpg" alt=""/>
          </li>
          <li data-thumb="OPHContent/documents/gopelago/sample/da065944-75fa-47b6-b2dd-9327bdd34142.jpg">
            <img src="OPHContent/documents/gopelago/sample/da065944-75fa-47b6-b2dd-9327bdd34142.jpg" alt=""/>
          </li>
          <li data-thumb="OPHContent/documents/gopelago/sample/e5b0c2d0-1a7a-4102-942c-54ae26a966e4.jpg">
            <img src="OPHContent/documents/gopelago/sample/e5b0c2d0-1a7a-4102-942c-54ae26a966e4.jpg" alt=""/>
          </li>
        </ul>
        <div style="padding-top:10px;text-align:middle;">
          <span style="line-height:22px;vertical-align:middle">
            Save to Wish List
          </span>
          <span class="icon iconfont-heart-outline apartment__about-amenity-icon" style="font-size:22px;vertical-align:middle;">&#160;</span>
        </div>
      </div>

    </div>
    <div class="apartment__about">
      <div class="container">
        <div class="apartment__about-wrap">
          <ul class="apartment__about-accomodation">
            <li class="apartment__about-accomodation-item">Breakfast: 1</li>
            <li class="apartment__about-accomodation-item">Drink: 1</li>
            <li class="apartment__about-accomodation-item">Ticket: 1</li>
            <li class="apartment__about-accomodation-item">Transportation: 1</li>
          </ul>
          <ul class="apartment__about-amenity">
            <li class="apartment__about-amenity-item">
              <span class="icon iconfont-food-service apartment__about-amenity-icon">&#160;</span>
              <div class="apartment__about-amenity-info">
                <span>
                  Full Breakfast: <br/>
                  Breakfast is well served <br/>
                  and includes bread, omelette, <br/>
                  ham and cheese.
                </span>
                <span>Coffee, juice and water</span>
              </div>
            </li>
            <li class="apartment__about-amenity-item">
              <span class="icon iconfont-visit apartment__about-amenity-icon">&#160;</span>
              <div class="apartment__about-amenity-info">
                <span>
                  Transportation and Ticket <br/>for the Christ
                </span>
              </div>
            </li>
            <li class="apartment__about-amenity-item">
              <span class="icon iconfont-clock-solid apartment__about-amenity-icon">&#160;</span>
              <div class="apartment__about-amenity-info">
                <span>4.5 hours</span>
              </div>
            </li>
            <li class="apartment__about-amenity-item">
              <span class="icon iconfont-info-solid apartment__about-amenity-icon">&#160;</span>
              <div class="apartment__about-amenity-info">
                <span>
                  Offered in English <br/> and Portuguese
                </span>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </div>
    <div class="apartment__full-description">
      <div class="container">
        <p style="font-size:16pt;font-weight:400">
          Notes
        </p>
        <p>
          Be sure to bring sunscreen and a camera. It’s not every day you get to have some exclusive time with God himself.
        </p>
        <p style="font-size:16pt;font-weight:400">
          Where we’ll be
        </p>
        <p>
          We’ll spend the morning on Corcovado, which is known as one of the New Seven Wonders of the World. Then you'll enjoy breakfast with breathtaking views of the world's largest urban forest and swing by the restaurant’s exhibition before we leave.
        </p>
      </div>
    </div>
    <div id="apartment-map" class="apartment__map">&#160;</div>

    <div class="container apartment__owner" id="host">
      <div class="apartment__owner-avatar-wrap">
        <img src="OPHContent/themes/themeDHUB/images/apartments/avatar.png" alt="" class="apartment__owner-avatar" width="170" height="170"/>
      </div>
      <div class="apartment__owner-info" style="padding-right:40px">
        <div class="apartment__owner-info-name">John</div>
        <div class="apartment__owner-info-location">Italy, Abruzzo, Teramo</div>

        <div class="apartment__owner-info-actions-wrap">
          <p>I love nature and history so much that I’ve dedicated my life to these two fields. I’ve been a tour guide of the Tijuca Forest and the Christ for many years, and every time I go, I still love it just as much as the first time. I can’t wait to share this incredible experience with you.</p>

        </div>
      </div>
      <div class="trip-availability" style="max-width:50%;">
        <h2 class="container listings-booking__heading" style="margin-top:0">Upcoming availability</h2>
        <span>
          Fri, Oct 20
          7:00 AM − 11:30 AM · Rp658,951 per person
        </span>
        <a href="#" class="btn btn-outline-primary btn-lg">Choose</a>
        <div class="trip-availability">
          Fri, Oct 27
          7:00 AM − 11:30 AM · Rp658,951 per person
          <a href="#" class="btn btn-outline-primary btn-lg">Choose</a>
        </div>
        <div class="trip-availability">
          See all availability Dates
        </div>
      </div>
    </div>

    <div class="container" style="padding: 30px 0 40px 0;">
      <h2 class="listings-booking__heading">
        Review
      </h2>
      <div class="container review">
        <div class="apartment__owner-avatar-wrap">
          <img src="OPHContent/documents/gopelago/sample/e3f6c3d1-0283-44b8-8a23-2723edee7562.jpg" alt="" class="apartment__owner-avatar" width="80" height="80"/>
        </div>
        <div class="apartment__owner-info">
          <div class="apartment__owner-info-name" style="font-size:20px">Ricardo</div>
          <div class="apartment__owner-info-location">October 6, 2017</div>

          <div class="apartment__owner-info-actions-wrap">
            <p>Experiência incrível!!! A guia Jade foi super atenciosa nos dando todo o suporte e atenção! Valeu super a pena!!!</p>
          </div>
        </div>

      </div>
      <div class="container review">
        <div class="apartment__owner-avatar-wrap">
          <img src="OPHContent/documents/gopelago/sample/64acb9e2-b669-4527-92a3-6f507c27203e.jpg" alt="" class="apartment__owner-avatar" width="80" height="80"/>
        </div>
        <div class="apartment__owner-info">
          <div class="apartment__owner-info-name" style="font-size:20px">André</div>
          <div class="apartment__owner-info-location">October 6, 2017</div>

          <div class="apartment__owner-info-actions-wrap">
            <p>Great way to have the Christ all to yourself for a few minutes.</p>

          </div>
        </div>

      </div>
      <div class="container review">
        <div class="apartment__owner-avatar-wrap">
          <img src="OPHContent/documents/gopelago/sample/2d401711-1f1e-4c9f-8add-4b3a7ced53a4.jpg" alt="" class="apartment__owner-avatar" width="80" height="80"/>
        </div>
        <div class="apartment__owner-info">
          <div class="apartment__owner-info-name" style="font-size:20px">Jorge</div>
          <div class="apartment__owner-info-location">September 22, 2017</div>

          <div class="apartment__owner-info-actions-wrap">
            <p>When we arrived to Corcovado, it was empty so it was amazing to be the first ones to take pictures there, after that, the breakfast was all you can eat, and finally the new expositions of the Tijuca National Park were really good. Just one thing, when you arrive at the meeting point don't wait for anyone in particular, just go directly to the ticket office and show your Airbnb confirmation to the staff they'll show you the way.</p>

          </div>
        </div>
      </div>
    </div>

    <h2 class="container listings-booking__heading">
      Similar experiences <a href="#" class="listings-booking__heading-see-all">See all</a>
    </h2>

    <div class="container listings-booking__items">
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
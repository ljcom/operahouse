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

      //primary css and style in manifest.xml

      loadStyle('OPHContent/themes/themeDHUB/vendors/leaflet/leaflet.css');
      loadStyle('OPHContent/themes/themeDHUB/vendors/lightslider/css/lightslider.min.css');

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



    <div class="header-default">
      <div class="header-topbar">
        <div class="container">
          <div class="header-topbar__contact-info">
            <div class="header-topbar__contact-info-item">
              <span class="title">Phone:</span>
              <span class="value">800-987-65-43</span>
            </div>
            <div class="header-topbar__contact-info-item">
              <span class="title">Email: </span>
              <span class="value">info@companyname.com</span>
            </div>
          </div>
          <ul class="nav header-topbar__nav">
            <li class="nav-item">
              <a class="nav-link" href="#">Online Booking</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="contact.html">Contact</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="signup.html">Sing In</a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">English</a>
              <div class="dropdown-menu" data-dropdown-in="zoomIn" data-dropdown-out="zoomOut">
                <a class="dropdown-item" href="#">Russian</a>
                <a class="dropdown-item active" href="#">English</a>
                <a class="dropdown-item" href="#">German</a>
              </div>
            </li>
          </ul>
        </div>
      </div>
      <div id="header-menu" class="header-default__menu">
        <div class="container">
          <nav class="navbar navbar-toggleable-lg">
            <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#header-default-menu">
              <span class="icon-bar">&#160;</span>
              <span class="icon-bar">&#160;</span>
              <span class="icon-bar">&#160;</span>
            </button>
            <a class="navbar-brand" href="index.html">
              Direct<span class="colored">o</span>ry
            </a>
            <div id="header-default-menu" class="collapse navbar-collapse">
              <div class="header-default__menu-collapse">
                <ul class="nav navbar-nav">
                  <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Listings</a>
                    <div class="dropdown-menu" data-dropdown-in="zoomIn" data-dropdown-out="zoomOut">
                      <a class="dropdown-item" href="index.html">Job Listing</a>
                      <a class="dropdown-item" href="listings-booking.html">Booking Listing</a>
                      <a class="dropdown-item" href="listings-apartments-grid.html">Apartments Listing</a>
                      <a class="dropdown-item" href="listings-houses.html">Houses Listing</a>
                      <a class="dropdown-item" href="listings-houses-projects.html">Houses Projects Listing</a>
                      <a class="dropdown-item" href="listings-master.html">Masters Listing</a>
                      <a class="dropdown-item" href="listings-travel-trips.html">Travel Trips Listing</a>
                      <a class="dropdown-item" href="listings-places.html">Places Listing</a>
                      <a class="dropdown-item" href="listings-properties.html">Properties Listing</a>
                      <a class="dropdown-item" href="listings-booking-flight.html">Flight Listing</a>
                    </div>
                  </li>
                  <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Pages</a>
                    <div class="dropdown-menu" data-dropdown-in="zoomIn" data-dropdown-out="zoomOut">
                      <div class="dropdown-menu__columns">
                        <div class="dropdown-menu__column">
                          <a class="dropdown-item" href="jobs-browse-jobs.html">Job - Browse Jobs</a>
                          <a class="dropdown-item" href="jobs-overview.html">Job - Overview</a>
                          <a class="dropdown-item" href="jobs-post-job.html">Job - Post Job</a>
                          <a class="dropdown-item" href="jobs-browse-resumes.html">Job - Browse Resumes</a>
                          <a class="dropdown-item" href="jobs-candidate-resume.html">Job - Candidate Resume</a>
                          <a class="dropdown-item" href="job-signup.html">Job - Sign Up</a>
                          <a class="dropdown-item" href="master-orders-list.html">FindMaster - Orders List</a>
                          <a class="dropdown-item" href="master-post-application.html">FindMaster - Post Application</a>
                          <a class="dropdown-item" href="master-profile-information.html">FindMaster - Profile Information</a>
                        </div>
                        <div class="dropdown-menu__column">
                          <a class="dropdown-item" href="master-profile-prices.html">FindMaster - Profile Prices</a>
                          <a class="dropdown-item" href="master-profile-reviews.html">FindMaster - Profile Reviews</a>
                          <a class="dropdown-item" href="master-profile-work-examples.html">FindMaster - Profile Work Examples</a>
                          <a class="dropdown-item" href="master-service-offers.html">FindMaster -Service Offers</a>
                          <a class="dropdown-item" href="apartments-apartment.html">Apartments - Apartment Overview</a>
                          <a class="dropdown-item" href="houses-about-us.html">Houses - About Us</a>
                          <a class="dropdown-item" href="houses-certificates.html">Houses - Certificates</a>
                          <a class="dropdown-item" href="houses-how-we-build.html">Houses - How We Build</a>
                          <a class="dropdown-item" href="contact.html">Contact</a>
                        </div>
                        <div class="dropdown-menu__column">
                          <a class="dropdown-item" href="all-categories.html">All Categories</a>
                          <a class="dropdown-item" href="uikit.html">UI Kit</a>
                          <a class="dropdown-item" href="login.html">Log In</a>
                          <a class="dropdown-item" href="reset-password.html">Reset Password</a>
                          <a class="dropdown-item" href="reset-password-success.html">Reset Password Success</a>
                          <a class="dropdown-item" href="500.html">500 Error</a>
                          <a class="dropdown-item" href="404.html">404 Error</a>
                        </div>
                      </div>
                    </div>
                  </li>
                  <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Elements</a>
                    <div class="dropdown-menu" data-dropdown-in="zoomIn" data-dropdown-out="zoomOut">
                      <a class="dropdown-item" href="hero-booking-places.html">Hero - Booking Places</a>
                      <a class="dropdown-item" href="hero-steps.html">Hero - Steps</a>
                    </div>
                  </li>
                  <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Blog</a>
                    <div class="dropdown-menu" data-dropdown-in="zoomIn" data-dropdown-out="zoomOut">
                      <a class="dropdown-item" href="blog.html">Main</a>
                      <a class="dropdown-item" href="blog-post.html">Post Overview</a>
                    </div>
                  </li>
                </ul>
                <div class="header-default__dropdowns">
                  <div class="nav-item dropdown header-default__currency">
                    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">
                      <span>$</span>
                    </a>
                    <div class="dropdown-menu" data-dropdown-in="zoomIn" data-dropdown-out="zoomOut">
                      <div class="header-default__currency-block">
                        <h6 class="header-default__currency-heading">Major currencies</h6>

                        <div class="header-default__currency-lists">
                          <ul class="list-unstyled">
                            <li>
                              <a href="#">
                                <span>€ £ $</span> Hotels' currency
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>US $</span> US Dollar
                              </a>
                            </li>
                          </ul>
                          <ul class="list-unstyled">
                            <li>
                              <a href="#">
                                <span>€</span> Euro
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>KZT</span> Kazakhstan Tenge
                              </a>
                            </li>
                          </ul>
                          <ul class="list-unstyled">
                            <li>
                              <a href="#">
                                <span>RUR</span> Russian ruble
                              </a>
                            </li>
                            <li>
                              <a href="#" class="is-active">
                                <span>£</span> Pound sterling
                              </a>
                            </li>
                          </ul>
                        </div>
                      </div>
                      <div class="header-default__currency-block">
                        <h6 class="header-default__currency-heading">All currencies</h6>

                        <div class="header-default__currency-lists">
                          <ul class="list-unstyled">
                            <li>
                              <a href="#">
                                <span>AUD</span> Australian Dollar
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>AZN</span> Azerbaijani manat
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>AR $</span> Argentine Peso
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>BHD</span> Bahraini Dinar
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>BGN</span> Bulgarian lev
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>R $</span> Brazilian Real
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>HUF</span> Hungarian Forint
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>HK $</span> Hong Kong Dollar
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>GEL</span> Georgian lari
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>DKK</span> Danish Krone
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>AED</span> UAE Dirham
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>US $</span> US Dollar
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>FJD</span> Fiji Dollar
                              </a>
                            </li>
                          </ul>
                          <ul class="list-unstyled">
                            <li>
                              <a href="#">
                                <span>€</span> Euro
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>EGP</span> Egyptian Pound
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>#</span> Israeli Shekel
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>Rs</span> Indian Rupee
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>Rp</span> Indonesian Rupiah
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>JOD</span> Jordanian Dinar
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>KZT</span> Kazakhstan Tenge
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>CAD</span> The Canadian dollar
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>QAR</span> Qatari Rial
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>CNY</span> Chinese yuan
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>COP</span> Colombian Peso
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>KRW</span> Korean Won
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>KWD</span> Kuwaiti Dinar
                              </a>
                            </li>
                          </ul>
                          <ul class="list-unstyled">
                            <li>
                              <a href="#">
                                <span>MYR</span> Malaysian Ringgit
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>MXN</span> Mexican Peso
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>MDL</span> Moldovan Leu
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>NAD</span> Namibian dollar
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>NZD</span> New Zealand Dollar
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>LEI</span> New Romanian leu lei
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>NOK</span> Norwegian Krone
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>OMR</span> Omani Rial
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>zł</span> Polish zloty
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>Rub.</span> Russian ruble
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>SAR</span> Saudi Riyal
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>S $</span> Singapore Dollar
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>TWD</span> Taiwan Dollar
                              </a>
                            </li>
                          </ul>
                          <ul class="list-unstyled">
                            <li>
                              <a href="#">
                                <span>THB</span> Thai Baht
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>TL</span> Turkish lira
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>UAH</span> Ukrainian hryvnia
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>XOF</span> CFA Franc BCEAO
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>£</span> Pound sterling
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>Kč</span> Czech Koruna
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>CL $</span> Chilean Peso
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>SEK</span> Swedish Krona
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>CHF</span> Swiss Franc
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>ZAR</span> South African Rand
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <span>¥</span> The Japanese yen
                              </a>
                            </li>
                          </ul>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="nav-item dropdown header-default__langs">
                    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">
                      <span>
                        <img src="OPHContent/themes/themeDHUB/images/flags/16/United-States.png" alt=""/>
                      </span>
                    </a>
                    <div class="dropdown-menu" data-dropdown-in="zoomIn" data-dropdown-out="zoomOut">
                      <div class="header-default__langs-block">
                        <h6 class="header-default__langs-heading">Popular languages</h6>

                        <div class="header-default__langs-lists">
                          <ul class="list-unstyled">
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Russia.png" alt=""/> Русский
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/United-Kingdom.png" alt=""/> English (UK)
                              </a>
                            </li>
                          </ul>
                          <ul class="list-unstyled">
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/United-States.png" alt=""/> English (US)
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/China.png" alt=""/> 体中文
                              </a>
                            </li>
                          </ul>
                          <ul class="list-unstyled">
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/France.png" alt=""/> Français
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Germany.png" alt=""/> Deutsch
                              </a>
                            </li>
                          </ul>
                        </div>
                      </div>
                      <div class="header-default__langs-block">
                        <h6 class="header-default__langs-heading">All languages</h6>

                        <div class="header-default__langs-lists">
                          <ul class="list-unstyled">
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/United-Kingdom.png" alt=""/> English (UK)
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/United-States.png" alt=""/> English (US)
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Germany.png" alt=""/> Deutsch
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Netherlands.png" alt=""/> Nederlands
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/France.png" alt=""/> Français
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Spain.png" alt=""/> Español
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Russia.png" alt=""/> Català
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Italy.png" alt=""/> Italiano
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Portugal.png" alt=""/> Português (PT)
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Brazil.png" alt=""/> Português (BR)
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Norway.png" alt=""/> Norsk
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Finland.png" alt=""/> Suomi
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Sweden.png" alt=""/> Svenska
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Denmark.png" alt=""/> Dansk
                              </a>
                            </li>
                          </ul>
                          <ul class="list-unstyled">
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Czech-Republic.png" alt=""/> Čeština
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Hungary.png" alt=""/> Magyar
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Romania.png" alt=""/> Română
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Japan.png" alt=""/> 日本語
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/China.png" alt=""/> 简体中文
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Russia.png" alt=""/> 繁體中文
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Poland.png" alt=""/> Polski
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Greece.png" alt=""/> Ελληνικά
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Russia.png" alt=""/> Русский
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Turkey.png" alt=""/> Türkçe
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Bulgaria.png" alt=""/> Български
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Russia.png" alt=""/>العربية
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Russia.png" alt=""/> 日本語
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Russia.png" alt=""/>עברית
                              </a>
                            </li>
                          </ul>
                          <ul class="list-unstyled">
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Latvia.png" alt=""/> Latviski
                              </a>
                            </li>
                            <li>
                              <a href="#" class="is-active">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Ukraine.png" alt=""/> Українська
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Indonesia.png" alt=""/> Bahasa Indonesia
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Malaysia.png" alt=""/> Bahasa Malaysia
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Thailand.png" alt=""/> ภาษาไทย
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Russia.png" alt=""/> Eesti
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Croatia.png" alt=""/> Hrvatski
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Lithuania.png" alt=""/> Lietuvių
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Slovenia.png" alt=""/> Slovenčina
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Russia.png" alt=""/> Srpski
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Vietnam.png" alt=""/> Tiếng Việt
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Philippines.png" alt=""/> Filipino
                              </a>
                            </li>
                            <li>
                              <a href="#">
                                <img src="OPHContent/themes/themeDHUB/images/flags/16/Russia.png" alt=""/> Íslenska
                              </a>
                            </li>
                          </ul>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="header-default__menu-links">
                  <a href="jobs-post-job.html" class="btn btn-outline-primary">
                    <span class="text">Add Listing</span>
                  </a>
                </div>
              </div>
            </div>
          </nav>
        </div>
      </div>
    </div>
    <div class="apartment">
      <div class="apartment__wrap">
        <a href="" class="apartment__back-to-search">Back to search</a>
        <h1 class="apartment__name">Apartment near the sea</h1>
        <div class="apartment__location">Italy, Abruzzo, Teramo</div>

        <div class="apartment__price">
          $399/mo <a href="" class="apartment__price-offer">Offer your price</a>
        </div>

        <a href="#" class="btn btn-primary apartment__price-make-reservation" >Make a reservation</a>

        <div class="apartment__description">
          Strong focus on great code to bring ultra fast experience
          from browsing the listings in the directory theme.
          Strong focus on great code to bring ultra fast experience
          from browsing the listings in the directory theme.
        </div>

        <div class="apartment__unique-id">
          Number of ads: <span class="text-bold">08034</span>
        </div>
      </div>
      <div class="apartment__image-slider">
        <ul id="apartment-image-slider">
          <li data-thumb="OPHContent/themes/themeDHUB/images/apartments/flat-thumb.png">
            <img src="OPHContent/themes/themeDHUB/images/apartments/flat-lg.png" alt=""/>
          </li>
          <li data-thumb="OPHContent/themes/themeDHUB/images/apartments/flat-thumb.png">
            <img src="OPHContent/themes/themeDHUB/images/apartments/flat-lg.png" alt=""/>
          </li>
          <li data-thumb="OPHContent/themes/themeDHUB/images/apartments/flat-thumb.png">
            <img src="OPHContent/themes/themeDHUB/images/apartments/flat-lg.png" alt=""/>
          </li>
          <li data-thumb="OPHContent/themes/themeDHUB/images/apartments/flat-thumb.png">
            <img src="OPHContent/themes/themeDHUB/images/apartments/flat-lg.png" alt=""/>
          </li>
          <li data-thumb="OPHContent/themes/themeDHUB/images/apartments/flat-thumb.png">
            <img src="OPHContent/themes/themeDHUB/images/apartments/flat-lg.png" alt=""/>
          </li>
          <li data-thumb="OPHContent/themes/themeDHUB/images/apartments/flat-thumb.png">
            <img src="OPHContent/themes/themeDHUB/images/apartments/flat-lg.png" alt=""/>
          </li>
          <li data-thumb="OPHContent/themes/themeDHUB/images/apartments/flat-thumb.png">
            <img src="OPHContent/themes/themeDHUB/images/apartments/flat-lg.png" alt=""/>
          </li>
          <li data-thumb="OPHContent/themes/themeDHUB/images/apartments/flat-thumb.png">
            <img src="OPHContent/themes/themeDHUB/images/apartments/flat-lg.png" alt=""/>
          </li>
        </ul>
      </div>
    </div>
    <div class="apartment__about">
      <div class="container">
        <div class="apartment__about-wrap">
          <ul class="apartment__about-accomodation">
            <li class="apartment__about-accomodation-item">Hall: 1</li>
            <li class="apartment__about-accomodation-item">Bedroom: 2</li>
            <li class="apartment__about-accomodation-item">Kitchen: 1</li>
            <li class="apartment__about-accomodation-item">Bathroom: 2</li>
            <li class="apartment__about-accomodation-item">Terrace: 0</li>
            <li class="apartment__about-accomodation-item">Furniture for sale: No</li>
          </ul>
          <ul class="apartment__about-amenity">
            <li class="apartment__about-amenity-item">
              <span class="icon iconfont-info-solid apartment__about-amenity-icon">&#160;</span>
              <div class="apartment__about-amenity-info">
                <span>Floor: 5</span>
                <span>
                  Total area: 45m<sup>2</sup>
                </span>
                <span>
                  Living area: 34m<sup>2</sup>
                </span>
              </div>
            </li>
            <li class="apartment__about-amenity-item">
              <span class="icon iconfont-bed apartment__about-amenity-icon">&#160;</span>
              <div class="apartment__about-amenity-info">
                <span>Amount beds: 1</span>
              </div>
            </li>
            <li class="apartment__about-amenity-item">
              <span class="icon iconfont-map-point-v2 apartment__about-amenity-icon">&#160;</span>
              <div class="apartment__about-amenity-info">
                <span>
                  Distance from <br/> the sea: 150m
                </span>
              </div>
            </li>
            <li class="apartment__about-amenity-item">
              <span class="icon iconfont-wallet apartment__about-amenity-icon">&#160;</span>
              <div class="apartment__about-amenity-info">
                <span>Long-term rent: $399/mo</span>
                <span>Communal tax: $49/mo</span>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </div>
    <div class="apartment__full-description">
      <div class="container">
        <p>
          But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful.
        </p>
        <p>
          Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure.
        </p>
      </div>
    </div>
    <div id="apartment-map" class="apartment__map">&#160;</div>

    <div class="container apartment__owner">
      <div class="apartment__owner-avatar-wrap">
        <img src="OPHContent/themes/themeDHUB/images/apartments/avatar.png" alt="" class="apartment__owner-avatar" width="170" height="170"/>
      </div>
      <div class="apartment__owner-info">
        <div class="apartment__owner-info-name">John</div>
        <div class="apartment__owner-info-location">Italy, Abruzzo, Teramo</div>

        <div class="apartment__owner-info-actions-wrap">
          <ul class="apartment__owner-info-actions list-unstyled">
            <li>
              <a href="#">All listings</a> &#2013; 192
            </li>
            <li>
              <a href="#">Send advertisement to e-mail</a>
            </li>
          </ul>
          <ul class="apartment__owner-info-actions list-unstyled">
            <li>
              <a href="#">All listings</a>
            </li>
            <li>
              <a href="#">Send advertisement to e-mail</a>
            </li>
          </ul>
        </div>
      </div>
      <div class="apartment__owner-actions">
        <a href="#" class="btn btn-primary btn-lg">Request a call</a>
        <a href="#" class="btn btn-outline-primary btn-lg">Send a message</a>
      </div>
    </div>
    <div class="footer-default">
      <div class="container">
        <div class="row">
          <div class="col-lg-6">
            <h6 class="footer-default__heading">About</h6>
            <p>
              Morbi convallis bibendum urna ut viverra. Maecenas quis consequat
              libero, a feugiat eros. Nunc ut lacinia tortor morbi ultricies laoreet
              ullamcorper phasellus semper.
            </p>

            <a href="#" class="btn btn-outline-secondary btn-get-started">Get Started</a>
          </div>
          <div class="col-lg-2 col-md-4">
            <h6 class="footer-default__heading footer-default__heading--sm">For Candidates</h6>

            <ul class="list-unstyled">
              <li>
                <a href="">Browse Jobs</a>
              </li>
              <li>
                <a href="">Browse Categories</a>
              </li>
              <li>
                <a href="">Submit Resume</a>
              </li>
              <li>
                <a href="">Dashboard</a>
              </li>
              <li>
                <a href="">Job Alert</a>
              </li>
              <li>
                <a href="">My Bookmarks</a>
              </li>
            </ul>
          </div>
          <div class="col-lg-2 col-md-4">
            <h6 class="footer-default__heading footer-default__heading--sm">For Employees</h6>

            <ul class="list-unstyled">
              <li>
                <a href="">Browse Candidates</a>
              </li>
              <li>
                <a href="">Dashboard</a>
              </li>
              <li>
                <a href="post-job.html">Add Job</a>
              </li>
              <li>
                <a href="">Job Package</a>
              </li>
            </ul>
          </div>
          <div class="col-lg-2 col-md-4">
            <h6 class="footer-default__heading footer-default__heading--sm">Other</h6>

            <ul class="list-unstyled">
              <li>
                <a href="">Shortcodes</a>
              </li>
              <li>
                <a href="">Job Page</a>
              </li>
              <li>
                <a href="">Job Page Alternative</a>
              </li>
              <li>
                <a href="">Resume Page</a>
              </li>
              <li>
                <a href="">Blog</a>
              </li>
              <li>
                <a href="">Contact</a>
              </li>
            </ul>
          </div>
        </div>
        <hr/>
        <div class="row">
          <div class="col-lg-6">
            <span class="footer-default__copyright">© Themes Anytime. All Rights Reserved.</span>
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
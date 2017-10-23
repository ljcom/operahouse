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

      loadStyle('OPHContent/themes/themeDHUB/vendors/select2/css/select2.min.css');
      loadStyle('OPHContent/themes/themeDHUB/css/vendors/select2/select2.min.css');

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

      loadScript('OPHContent/themes/themeDHUB/vendors/select2/js/select2.min.js');
      loadScript('OPHContent/themes/themeDHUB/js/travel-trips.js');




      //LoadNewPart('home_browse', 'contentWrapper', 'home', '','');
      //changeColorMenuFront();
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
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="index.html">
              G<span class="colored">O</span>PELAGO
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
                        <img src="OPHContent/themes/themeDHUB/images/flags/16/United-States.png" alt="" />
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
    <div class="hero-travel-trips">
      <div class="container">
        <h2 class="hero-travel-trips__heading">Search for expedition</h2>
        <form action="#" class="hero-travel-trips__form">
          <div class="form-control-inline-icon inline-icon-left hero-travel-trips__search-input">
            <span class="icon iconfont-left iconfont-search-v2">&#160;</span>
            <input type="text" class="form-control" placeholder="Ex.Summer camp..."/>
          </div>

          <div class="hero-travel-trips__select">
            <div class="hero-travel-trips__select-heading">Type</div>
            <select class="form-control selectable" data-selectable-no-search="true">
              <option value="" selected="">All</option>
              <option value="">All</option>
              <option value="">sfasf</option>
              <option value="">sfasf</option>
            </select>
          </div>

          <div class="hero-travel-trips__select">
            <div class="hero-travel-trips__select-heading">Period</div>
            <select class="form-control selectable" data-selectable-no-search="true">
              <option value="" selected="">Anytime</option>
              <option value="">Anytime</option>
              <option value="">sfasf</option>
              <option value="">sfasf</option>
            </select>
          </div>

          <div class="hero-travel-trips__select">
            <div class="hero-travel-trips__select-heading">Price</div>
            <select class="form-control selectable" data-selectable-no-search="true">
              <option value="" selected="">Anyprice</option>
              <option value="">sfasf</option>
              <option value="">sfasf</option>
              <option value="">sfasf</option>
            </select>
          </div>

          <button type="button" class="btn btn-primary hero-travel-trips__search-btn">Search</button>
        </form>
      </div>
    </div>
    <div class="listing-travel-trips">
      <div class="container">
        <div class="row">
          <div class="col-xl-3 col-lg-4 col-md-6">
            <div class="listing-travel-trips__item">
              <div class="listing-travel-trips__item-image">
                <img src="OPHContent/themes/themeDHUB/images/listings/travel-trips/01.png" alt="" class="embed-responsive"/>
                <div class="listing-travel-trips__item-title">
                  <span>Swimming with Dolphins</span>
                </div>
              </div>
              <div class="listing-travel-trips__item-info">
                <div class="listing-travel-trips__item-description">
                  It is possible to charter, rent or
                  lease an aircraft for less than ever
                  before and it has also become
                </div>
                <div class="listing-travel-trips__item-details">
                  <div class="listing-travel-trips__item-details-price">
                    <span class="heading">Price</span>
                    <span class="value">$450</span>
                  </div>
                  <div class="listing-travel-trips__item-details-duration">
                    <span class="heading">Duration</span>
                    <span class="value">5 nights</span>
                  </div>
                  <a href="#" class="btn btn-outline-default listing-travel-trips__item-details-view-link">Details</a>
                </div>
              </div>
            </div>
          </div>
          <div class="col-xl-3 col-lg-4 col-md-6">
            <div class="listing-travel-trips__item">
              <div class="listing-travel-trips__item-image">
                <div class="listing-travel-trips__item-users">
                  <img src="OPHContent/themes/themeDHUB/images/listings/travel-trips/avatar-1.png" alt="" width="34" height="34"/>
                  <img src="OPHContent/themes/themeDHUB/images/listings/travel-trips/avatar-2.png" alt="" width="34" height="34"/>
                </div>
                <img src="OPHContent/themes/themeDHUB/images/listings/travel-trips/02.png" alt="" class="embed-responsive"/>
                  <div class="listing-travel-trips__item-title">
                    <span>How Hypnosis Can Help You</span>
                  </div>
                </div>
              <div class="listing-travel-trips__item-info">
                <div class="listing-travel-trips__item-description">
                  It is possible to charter, rent or
                  lease an aircraft for less than ever
                  before and it has also become
                </div>
                <div class="listing-travel-trips__item-details">
                  <div class="listing-travel-trips__item-details-price">
                    <span class="heading">Price</span>
                    <span class="value">$450</span>
                  </div>
                  <div class="listing-travel-trips__item-details-duration">
                    <span class="heading">Duration</span>
                    <span class="value">5 nights</span>
                  </div>
                  <a href="#" class="btn btn-outline-default listing-travel-trips__item-details-view-link">Details</a>
                </div>
              </div>
            </div>
          </div>
          <div class="col-xl-3 col-lg-4 col-md-6">
            <div class="listing-travel-trips__item">
              <div class="listing-travel-trips__item-image">
                <div class="listing-travel-trips__item-users">
                  <img src="OPHContent/themes/themeDHUB/images/listings/travel-trips/avatar-3.png" alt="" width="34" height="34"/>
                </div>
                <img src="OPHContent/themes/themeDHUB/images/listings/travel-trips/03.png" alt="" class="embed-responsive"/>
                <div class="listing-travel-trips__item-title">
                  <span>
                    When you are Down and out How <br/> do You Get Up and Go Forward
                            </span>
                </div>
              </div>
              <div class="listing-travel-trips__item-info">
                <div class="listing-travel-trips__item-description">
                  It is possible to charter, rent or
                  lease an aircraft for less than ever
                  before and it has also become
                </div>
                <div class="listing-travel-trips__item-details">
                  <div class="listing-travel-trips__item-details-price">
                    <span class="heading">Price</span>
                    <span class="value">$450</span>
                  </div>
                  <div class="listing-travel-trips__item-details-duration">
                    <span class="heading">Duration</span>
                    <span class="value">5 nights</span>
                  </div>
                  <a href="#" class="btn btn-outline-default listing-travel-trips__item-details-view-link">Details</a>
                </div>
              </div>
            </div>
          </div>
          <div class="col-xl-3 col-lg-4 col-md-6">
            <div class="listing-travel-trips__item">
              <div class="listing-travel-trips__item-image">
                <img src="OPHContent/themes/themeDHUB/images/listings/travel-trips/04.png" alt="" class="embed-responsive"/>
                <div class="listing-travel-trips__item-title">
                  <span>Why Las Vegas Hotel Rooms For You</span>
                </div>
              </div>
              <div class="listing-travel-trips__item-info">
                <div class="listing-travel-trips__item-description">
                  It is possible to charter, rent or
                  lease an aircraft for less than ever
                  before and it has also become
                </div>
                <div class="listing-travel-trips__item-details">
                  <div class="listing-travel-trips__item-details-price">
                    <span class="heading">Price</span>
                    <span class="value">$450</span>
                  </div>
                  <div class="listing-travel-trips__item-details-duration">
                    <span class="heading">Duration</span>
                    <span class="value">5 nights</span>
                  </div>
                  <a href="#" class="btn btn-outline-default listing-travel-trips__item-details-view-link">Details</a>
                </div>
              </div>
            </div>
          </div>
          <div class="col-xl-3 col-lg-4 col-md-6">
            <div class="listing-travel-trips__item">
              <div class="listing-travel-trips__item-image">
                <div class="listing-travel-trips__item-users">
                  <img src="OPHContent/themes/themeDHUB/images/listings/travel-trips/avatar-3.png" alt="" width="34" height="34"/>
                </div>
                <img src="OPHContent/themes/themeDHUB/images/listings/travel-trips/05.png" alt="" class="embed-responsive"/>
                <div class="listing-travel-trips__item-title">
                  <span>Swimming with Dolphins</span>
                </div>
              </div>
              <div class="listing-travel-trips__item-info">
                <div class="listing-travel-trips__item-description">
                  It is possible to charter, rent or
                  lease an aircraft for less than ever
                  before and it has also become
                </div>
                <div class="listing-travel-trips__item-details">
                  <div class="listing-travel-trips__item-details-price">
                    <span class="heading">Price</span>
                    <span class="value">$450</span>
                  </div>
                  <div class="listing-travel-trips__item-details-duration">
                    <span class="heading">Duration</span>
                    <span class="value">5 nights</span>
                  </div>
                  <a href="#" class="btn btn-outline-default listing-travel-trips__item-details-view-link">Details</a>
                </div>
              </div>
            </div>
          </div>
          <div class="col-xl-3 col-lg-4 col-md-6">
            <div class="listing-travel-trips__item">
              <div class="listing-travel-trips__item-image">
                <img src="OPHContent/themes/themeDHUB/images/listings/travel-trips/06.png" alt="" class="embed-responsive"/>
                <div class="listing-travel-trips__item-title">
                  <span>How Hypnosis Can Help You</span>
                </div>
              </div>
              <div class="listing-travel-trips__item-info">
                <div class="listing-travel-trips__item-description">
                  It is possible to charter, rent or
                  lease an aircraft for less than ever
                  before and it has also become
                </div>
                <div class="listing-travel-trips__item-details">
                  <div class="listing-travel-trips__item-details-price">
                    <span class="heading">Price</span>
                    <span class="value">$450</span>
                  </div>
                  <div class="listing-travel-trips__item-details-duration">
                    <span class="heading">Duration</span>
                    <span class="value">5 nights</span>
                  </div>
                  <a href="#" class="btn btn-outline-default listing-travel-trips__item-details-view-link">Details</a>
                </div>
              </div>
            </div>
          </div>
          <div class="col-xl-3 col-lg-4 col-md-6">
            <div class="listing-travel-trips__item">
              <div class="listing-travel-trips__item-image">
                <img src="OPHContent/themes/themeDHUB/images/listings/travel-trips/07.png" alt="" class="embed-responsive"/>
                <div class="listing-travel-trips__item-title">
                  <span>
                    When you are Down and out How <br/> do You Get Up and Go Forward
                            </span>
                </div>
              </div>
              <div class="listing-travel-trips__item-info">
                <div class="listing-travel-trips__item-description">
                  It is possible to charter, rent or
                  lease an aircraft for less than ever
                  before and it has also become
                </div>
                <div class="listing-travel-trips__item-details">
                  <div class="listing-travel-trips__item-details-price">
                    <span class="heading">Price</span>
                    <span class="value">$450</span>
                  </div>
                  <div class="listing-travel-trips__item-details-duration">
                    <span class="heading">Duration</span>
                    <span class="value">5 nights</span>
                  </div>
                  <a href="#" class="btn btn-outline-default listing-travel-trips__item-details-view-link">Details</a>
                </div>
              </div>
            </div>
          </div>
          <div class="col-xl-3 col-lg-4 col-md-6">
            <div class="listing-travel-trips__item">
              <div class="listing-travel-trips__item-image">
                <div class="listing-travel-trips__item-users">
                  <img src="OPHContent/themes/themeDHUB/images/listings/travel-trips/avatar-1.png" alt="" width="34" height="34"/>
                    <img src="OPHContent/themes/themeDHUB/images/listings/travel-trips/avatar-2.png" alt="" width="34" height="34"/>
                      <img src="OPHContent/themes/themeDHUB/images/listings/travel-trips/avatar-3.png" alt="" width="34" height="34"/>
                        <img src="OPHContent/themes/themeDHUB/images/listings/travel-trips/avatar-1.png" alt="" width="34" height="34"/>
                        </div>
                <img src="OPHContent/themes/themeDHUB/images/listings/travel-trips/08.png" alt="" class="embed-responsive"/>
                  <div class="listing-travel-trips__item-title">
                    <span>Why Las Vegas Hotel Rooms For You</span>
                  </div>
                </div>
              <div class="listing-travel-trips__item-info">
                <div class="listing-travel-trips__item-description">
                  It is possible to charter, rent or
                  lease an aircraft for less than ever
                  before and it has also become
                </div>
                <div class="listing-travel-trips__item-details">
                  <div class="listing-travel-trips__item-details-price">
                    <span class="heading">Price</span>
                    <span class="value">$450</span>
                  </div>
                  <div class="listing-travel-trips__item-details-duration">
                    <span class="heading">Duration</span>
                    <span class="value">5 nights</span>
                  </div>
                  <a href="#" class="btn btn-outline-default listing-travel-trips__item-details-view-link">Details</a>
                </div>
              </div>
            </div>
          </div>
          <div class="col-xl-3 col-lg-4 col-md-6">
            <div class="listing-travel-trips__item">
              <div class="listing-travel-trips__item-image">
                <img src="OPHContent/themes/themeDHUB/images/listings/travel-trips/09.png" alt="" class="embed-responsive"/>
                  <div class="listing-travel-trips__item-title">
                    <span>Swimming with Dolphins</span>
                  </div>
                </div>
              <div class="listing-travel-trips__item-info">
                <div class="listing-travel-trips__item-description">
                  It is possible to charter, rent or
                  lease an aircraft for less than ever
                  before and it has also become
                </div>
                <div class="listing-travel-trips__item-details">
                  <div class="listing-travel-trips__item-details-price">
                    <span class="heading">Price</span>
                    <span class="value">$450</span>
                  </div>
                  <div class="listing-travel-trips__item-details-duration">
                    <span class="heading">Duration</span>
                    <span class="value">5 nights</span>
                  </div>
                  <a href="#" class="btn btn-outline-default listing-travel-trips__item-details-view-link">Details</a>
                </div>
              </div>
            </div>
          </div>
          <div class="col-xl-3 col-lg-4 col-md-6">
            <div class="listing-travel-trips__item">
              <div class="listing-travel-trips__item-image">
                <img src="OPHContent/themes/themeDHUB/images/listings/travel-trips/10.png" alt="" class="embed-responsive"/>
                  <div class="listing-travel-trips__item-title">
                    <span>How Hypnosis Can Help You</span>
                  </div>
                </div>
              <div class="listing-travel-trips__item-info">
                <div class="listing-travel-trips__item-description">
                  It is possible to charter, rent or
                  lease an aircraft for less than ever
                  before and it has also become
                </div>
                <div class="listing-travel-trips__item-details">
                  <div class="listing-travel-trips__item-details-price">
                    <span class="heading">Price</span>
                    <span class="value">$450</span>
                  </div>
                  <div class="listing-travel-trips__item-details-duration">
                    <span class="heading">Duration</span>
                    <span class="value">5 nights</span>
                  </div>
                  <a href="#" class="btn btn-outline-default listing-travel-trips__item-details-view-link">Details</a>
                </div>
              </div>
            </div>
          </div>
          <div class="col-xl-3 col-lg-4 col-md-6">
            <div class="listing-travel-trips__item">
              <div class="listing-travel-trips__item-image">
                <div class="listing-travel-trips__item-users">
                  <img src="OPHContent/themes/themeDHUB/images/listings/travel-trips/avatar-1.png" alt="" width="34" height="34"/>
                    <img src="OPHContent/themes/themeDHUB/images/listings/travel-trips/avatar-2.png" alt="" width="34" height="34"/>
                        </div>
                <img src="OPHContent/themes/themeDHUB/images/listings/travel-trips/11.png" alt="" class="embed-responsive"/>
                  <div class="listing-travel-trips__item-title">
                    <span>
                      When you are Down and out How <br/> do You Get Up and Go Forward
                            </span>
                  </div>
                </div>
              <div class="listing-travel-trips__item-info">
                <div class="listing-travel-trips__item-description">
                  It is possible to charter, rent or
                  lease an aircraft for less than ever
                  before and it has also become
                </div>
                <div class="listing-travel-trips__item-details">
                  <div class="listing-travel-trips__item-details-price">
                    <span class="heading">Price</span>
                    <span class="value">$450</span>
                  </div>
                  <div class="listing-travel-trips__item-details-duration">
                    <span class="heading">Duration</span>
                    <span class="value">5 nights</span>
                  </div>
                  <a href="#" class="btn btn-outline-default listing-travel-trips__item-details-view-link">Details</a>
                </div>
              </div>
            </div>
          </div>
          <div class="col-xl-3 col-lg-4 col-md-6">
            <div class="listing-travel-trips__item">
              <div class="listing-travel-trips__item-image">
                <img src="OPHContent/themes/themeDHUB/images/listings/travel-trips/12.png" alt="" class="embed-responsive"/>
                  <div class="listing-travel-trips__item-title">
                    <span>Why Las Vegas Hotel Rooms For You</span>
                  </div>
                </div>
              <div class="listing-travel-trips__item-info">
                <div class="listing-travel-trips__item-description">
                  It is possible to charter, rent or
                  lease an aircraft for less than ever
                  before and it has also become
                </div>
                <div class="listing-travel-trips__item-details">
                  <div class="listing-travel-trips__item-details-price">
                    <span class="heading">Price</span>
                    <span class="value">$450</span>
                  </div>
                  <div class="listing-travel-trips__item-details-duration">
                    <span class="heading">Duration</span>
                    <span class="value">5 nights</span>
                  </div>
                  <a href="#" class="btn btn-outline-default listing-travel-trips__item-details-view-link">Details</a>
                </div>
              </div>
            </div>
          </div>
        </div>

        <nav class="listings-pagination listings-travel-trips-pagination d-flex justify-content-center">
          <ul class="pagination">
            <li class="page-item active">
              <a class="page-link" href="#">1</a>
            </li>
            <li class="page-item">
              <a class="page-link" href="#">2</a>
            </li>
            <li class="page-item">
              <a class="page-link" href="#">3</a>
            </li>
            <li class="page-item">
              <a class="page-link" href="#">4</a>
            </li>
            <li class="page-item">
              <a class="page-link" href="#">5</a>
            </li>
            <li class="page-item">
              <a class="page-link" href="#">...</a>
            </li>
            <li class="page-item">
              <a class="page-link" href="#">99</a>
            </li>
          </ul>
        </nav>
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
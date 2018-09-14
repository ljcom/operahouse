<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" >

  <xsl:template match="/">
    <script>
      $("body").addClass("header_sticky");
      document.title='<xsl:value-of select="/sqroot/header/info/title"/>';

      var meta = document.createElement('meta');
      meta.charset = "UTF-8";
      loadMeta(meta);

      var meta = document.createElement('meta');
      meta.httpEquiv = "X-UA-Compatible";
      meta.content = "IE=edge";
      loadMeta(meta);

      var meta = document.createElement('meta');
      meta.name = "viewport";
      meta.content = "width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no";
      loadMeta(meta);


      loadScript('OPHContent/themes/themeSIX/js/main.js');
      //loadScript('OPHContent/themes/themeSIX/js/switcher.js');
    </script>

    <!-- Boostrap style -->

    <!--link href="./images/icons/favicon.png" rel="shortcut icon"-->


    <div class="preloader">
      <div class="dizzy-gillespie"></div>
    </div>
    <!-- /.preloader -->

    <div class="boxed">

      <section id="header" class="header">
        <div class="container-fluid">
          <div id="logo" class="logo float-left">
            <a href="index.html" title="Yolo">
              L'OREAL
            </a>
          </div>
          <!-- /.logo -->
          <div class="menu-extra">
            <div class="box-search">
              <span class="icon_search"></span>
              <form action="#" method="get" accept-charset="utf-8">
                <div class="input-search">
                  <input type="text" name="search" placeholder="|Enter Your Search..."/>
                  <span class="ti-close delete"></span>
                </div>
              </form>
            </div>
            <div class="box-cart">
              <span class="icon_bag_alt"></span>
              <div class="subcart">
                <ul class="product-choose">
                  <li class="overflow">
                    <div class="img-product float-left">
                      <img src="images/shop/s-01.jpg" alt=""/>
                    </div>
                    <div class="info-product float-left overflow">
                      <div class="price">
                        $60.00 x <span>1</span>
                      </div>
                      <div class="name">
                        <a href="#" title="">Kabino Bedside Table</a>
                      </div>
                    </div>
                    <div class="delete">
                      <img src="images/shop/delete.png" alt=""/>
                    </div>
                  </li>
                  <li class="overflow">
                    <div class="img-product float-left">
                      <img src="images/shop/s-02.jpg" alt=""/>
                    </div>
                    <div class="info-product float-left overflow">
                      <div class="price">
                        $80.00 x <span>1</span>
                      </div>
                      <div class="name">
                        <a href="#" title="">Kabino Bedside Table</a>
                      </div>
                    </div>
                    <div class="delete">
                      <img src="images/shop/delete.png" alt=""/>
                    </div>
                  </li>
                </ul>
                <div class="total-cart overflow">
                  <p class="float-left">TOTAL:</p>
                  <p class="float-right">$460.00</p>
                </div>
                <div class="btn-cart">
                  <a href="#" class="view-cart" title="">VIEW CARD</a>
                  <a href="#" class="check-out" title="">CHECK OUT</a>
                </div>
              </div>
            </div>
            <div class="box-canvas">
              <span class="ti-align-right"></span>
            </div>
          </div>
          <!-- /.icon-header -->
          <ul class="flat-infomation">
            <li class="phone">
              <a href="#" title="">
                <i class="fa fa-tty" aria-hidden="true"></i> 021 29886666
              </a>
            </li>
            <li class="purchase">
              <a href="#" title="">USER LOGIN</a>
            </li>
          </ul>
          <!-- /.flat-infomation -->
          <div class="nav-wrap">
            <div class="btn-menu">
              <span></span>
            </div>
            <!-- //mobile menu button -->
            <div id="mainnav" class="mainnav">
              <ul class="menu">
                <li class="has-menu-mega">
                  <a href="index.html" title="">
                    Home
                  </a>
                  <div class="menu-mega overflow">
                    <ul class="menu-mega-child one-four">
                      <li>
                        <a href="index.html" title="">Home 01</a>
                      </li>
                      <li>
                        <a href="index-v2.html" title="">Home 02</a>
                      </li>
                      <li>
                        <a href="index-v3.html" title="">Home 03</a>
                      </li>
                      <li>
                        <a href="index-v4.html" title="">Home 04</a>
                      </li>
                      <li>
                        <a href="index-v5.html" title="">Home 05</a>
                      </li>
                      <li>
                        <a href="agency-simple.html" title="">Agency Simple</a>
                      </li>
                      <li>
                        <a href="corporate-agency.html" title="">Corporate Agency</a>
                      </li>
                      <li>
                        <a href="agency-classic.html" title="">Agency Classic</a>
                      </li>
                    </ul>
                    <!-- /.menu-mega-child one-four -->
                    <ul class="menu-mega-child one-four">
                      <li>
                        <a href="digital-agency.html" title="">Digital Agency</a>
                      </li>
                      <li>
                        <a href="business-consulting.html" title="">Business Consulting</a>
                      </li>
                      <li>
                        <a href="startup-business.html" title="">StartUp Business</a>
                      </li>
                      <li>
                        <a href="creative-agency.html" title="">Creative Agency</a>
                      </li>
                      <li>
                        <a href="personal-dark.html" target="_blank" title="">Personal Dark</a>
                      </li>
                      <li>
                        <a href="personal-white.html" target="_blank" title="">Personal White</a>
                      </li>
                      <li>
                        <a href="studio.html" target="_blank" title="">Studio</a>
                      </li>
                      <li>
                        <a href="architecture.html" title="">Architecture</a>
                      </li>
                    </ul>
                    <!-- /.menu-mega-child one-four -->
                    <ul class="menu-mega-child one-four">
                      <li>
                        <a href="education-online.html" title="">Education Online</a>
                      </li>
                      <li>
                        <a href="portfolio-masonry-home.html" target="_blank" title="">Portfolio Masonry</a>
                      </li>
                      <li>
                        <a href="portfolio-textbox-home.html" target="_blank" title="">Portfolio Textbox</a>
                      </li>
                      <li>
                        <a href="photography-white.html" target="_blank" title="">Photography White</a>
                      </li>
                      <li>
                        <a href="photography-dark.html" target="_blank" title="">Photography Dark</a>
                      </li>
                      <li>
                        <a href="photography-fullscreen.html" target="_blank" title="">Photography FullScreen</a>
                      </li>
                      <li>
                        <a href="photography-thumbnails.html" target="_blank" title="">Photography</a>
                      </li>
                    </ul>
                    <!-- /.menu-mega-child one-four -->
                    <ul class="menu-mega-child one-four">
                      <li>
                        <a href="video.html" target="_blank" title="">Video</a>
                      </li>
                      <li>
                        <a href="blog-minimals.html" target="_blank" title="">Blog Minimals</a>
                      </li>
                      <li>
                        <a href="blog-creative.html" target="_blank" title="">Blog Creative</a>
                      </li>
                      <li>
                        <a href="shop-minimals.html" title="">Shop Minimal</a>
                      </li>
                      <li>
                        <a href="shop-minimals-02.html" title="">Shop Minimal02</a>
                      </li>
                      <li>
                        <a href="shop-minimals-03.html" title="">Shop Minimal03</a>
                      </li>
                      <li>
                        <a href="shop-metro.html" title="">Shop Funiture Metro</a>
                      </li>
                      <li>
                        <a href="comming-soon.html" target="_blank" title="">Comming Soon</a>
                      </li>
                    </ul>
                    <!-- /.menu-mega-child one-four -->
                  </div>
                  <!-- /.submenu menu-mega -->
                </li>
                <!-- /.has-menu-mega -->
                <li class="has-submenu">
                  <a href="#" title="">
                    How To Submit
                  </a>
                  <div class="submenu">
                    <ul>
                      <li>
                        <a href="faqs.html" title="">Term and Conditions</a>
                      </li>
                      <li>
                        <a href="faqs.html" title="">FAQS</a>
                      </li>
                    </ul>
                  </div>
                </li>
                <!-- /.has-submenu -->
                <li class="active has-submenu">
                  <a href="#" title="">
                    Invoice List
                  </a>
                  <div class="submenu">
                    <ul>
                      <li class="has-submenu-child">
                        <a href="portfolio-outside01.html" title="">Title OutSide</a>
                        <ul class="submenu-child">
                          <li>
                            <a href="portfolio-outside01.html" title="">Grid 01 Title Outside</a>
                          </li>
                          <li>
                            <a href="portfolio-outside02.html" title="">Grid 02 Title Outside</a>
                          </li>
                          <li>
                            <a href="portfolio-outside03.html" title="">Grid 03 Title Outside</a>
                          </li>
                        </ul>
                      </li>
                      <li class="has-submenu-child">
                        <a href="portfolio-inside01.html" title="">Title Inside</a>
                        <ul class="submenu-child">
                          <li>
                            <a href="portfolio-inside01.html" title="">Grid 01 Title Inside</a>
                          </li>
                          <li>
                            <a href="portfolio-inside02.html" title="">Grid 02 Title Inside</a>
                          </li>
                          <li>
                            <a href="portfolio-inside03.html" title="">Grid 03 Title Inside</a>
                          </li>
                        </ul>
                      </li>
                      <li class="has-submenu-child">
                        <a href="portfolio-hover01.html" title="">Title Hover</a>
                        <ul class="submenu-child">
                          <li>
                            <a href="portfolio-hover01.html" title="">Grid 01 Hover</a>
                          </li>
                          <li>
                            <a href="portfolio-hover02.html" title="">Grid 02 Hover</a>
                          </li>
                          <li>
                            <a href="portfolio-hover03.html" title="">Grid 03 Hover</a>
                          </li>
                        </ul>
                      </li>
                      <li>
                        <a href="portfolio-masonry.html" title="">Masonry</a>
                      </li>
                      <li>
                        <a href="portfolio-textbox.html" title="">TextBox</a>
                      </li>
                      <li class="has-submenu-child">
                        <a href="portfolio-metro03.html" title="">Metro</a>
                        <ul class="submenu-child">
                          <li>
                            <a href="portfolio-metro03.html" title="">Metro 03</a>
                          </li>
                          <li>
                            <a href="portfolio-metro04.html" title="">Metro 04</a>
                          </li>
                        </ul>
                      </li>
                      <li class="has-submenu-child">
                        <a href="portfolio-simple.html" title="">Portfolio Single</a>
                        <ul class="submenu-child">
                          <li>
                            <a href="portfolio-simple.html" title="">Single Simple</a>
                          </li>
                          <li>
                            <a href="portfolio-scroll.html" title="">Single Scroll</a>
                          </li>
                          <li>
                            <a href="portfolio-single-fullwidth.html" title="">Single Fullwidth</a>
                          </li>
                        </ul>
                      </li>
                    </ul>
                  </div>
                </li>
                <!-- /.has-submenu -->

              </ul>
              <!-- /.menu -->
            </div>
            <!-- /.mainnav -->
          </div>
          <!-- /.nav-wrap -->
          <div class="clearfix"></div>
        </div>
        <!-- /.container-fluid -->
        <div class="menu-canvas">
          <div class="close">
            <i class="fa fa-times" aria-hidden="true"></i>
          </div>
          <div class="widget-about">
            <h5>We Are yolo</h5>
            <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim.</p>
          </div>
          <div class="widget-contact">
            <h5>Contact Us</h5>
            <ul>
              <li>88 Landsriver St, Califonia, USA</li>
              <li>(04) 122 00 111</li>
              <li>
                <a href="#" title="">support@elegant.com</a>
              </li>
            </ul>
          </div>
          <div class="share-link">
            <ul class="social-ft">
              <li>
                <a href="" title="Facebook">
                  <i class="ti-facebook" aria-hidden="true"></i>
                </a>
              </li>
              <li>
                <a href="" title="Twitter">
                  <i class="ti-twitter-alt" aria-hidden="true"></i>
                </a>
              </li>
              <li>
                <a href="" title="Google Plus">
                  <i class="ti-google" aria-hidden="true"></i>
                </a>
              </li>
              <li>
                <a href="" title="Instagram">
                  <i class="fa fa-instagram" aria-hidden="true"></i>
                </a>
              </li>
              <li>
                <a href="" title="Dribble">
                  <i class="ti-dribbble" aria-hidden="true"></i>
                </a>
              </li>
              <li>
                <a href="" title="Pinterest">
                  <i class="ti-pinterest" aria-hidden="true"></i>
                </a>
              </li>
            </ul>
            <p class="copyright">Copyright ©2017 Yolo. All Rights Reserved</p>
          </div>
        </div>
      </section>
      <!-- /.header -->

      <section class="page-title parallax parallax1">
        <div class="title-heading">
          <div class="container">
            <div class="row">
              <div class="col-md-12">
                <div class="box-title style1">
                  <h1>
                    User Login
                  </h1>
                  <!-- /.breadcrumbs -->
                </div>
                <!-- /.box-title -->
              </div>
              <!-- /.col-md-12 -->
            </div>
            <!-- /.row -->
          </div>
          <!-- /.container -->
        </div>
        <!-- /.title-heading -->
        <div class="overlay-black"></div>
      </section>
      <!-- /.page-title parallax -->

      <div class="divider100"></div>

      <div class="flat-contact-simple">
        <div class="container">
          <div class="row">
            <div class="col-md-6">
              <div class="contact-classic">
                <p class="color-default">INVOICE PORTAL</p>
                <h2 class="font-weight-3">Use a local account to sign in</h2>

              </div>
              <!-- /.contact-classic -->
            </div>
            <!-- /.col-md-6 -->
            <div class="col-md-6">
              <div class="form-contact-form style4">
                <form id="contactform" action="./contact/contact-process.php" method="post" accept-charset="utf-8">
                  <div class="subscribe-content">
                    <div class="contact-form-name contact-form">
                      <input type="text" name="username" id="username" placeholder="Enter your email address" required="" />
                    </div>
                    <div class="contact-form-name contact-form">
                      <input type="password" name="password" id="password" placeholder="Enter Your Password" required="" />
                    </div>
                    
                      <button type="submit" class="border-radius-2" style="margin-right:5px">SUBMIT</button>
                    
                  
                      <button type="submit" class="border-radius-2">CANCEL</button>
                  
                  </div>
                </form>
                <!-- /form -->
              </div>
              <!-- /.form-contact-form -->
            </div>
            <!-- /.col-md-6 -->
          </div>
          <!-- /.row -->
        </div>
        <!-- /.container -->
      </div>
      <!-- /.flat-contact-simple -->

      <div class="divider100"></div>

      <section class="flat-partner background">
        <div class="container">
          <div class="row">
            <div class="col-md-12">
              <!--<ul class="owl-carousel">
                <li>
                  <img src="images/partner/01.png" alt=""/>
                </li>
                <li>
                  <img src="images/partner/02.png" alt=""/>
                </li>
                <li>
                  <img src="images/partner/03.png" alt=""/>
                </li>
                <li>
                  <img src="images/partner/04.png" alt=""/>
                </li>
                <li>
                  <img src="images/partner/05.png" alt=""/>
                </li>
                <li>
                  <img src="images/partner/06.png" alt=""/>
                </li>
              </ul>-->
              <!-- /.owl-carousel -->
            </div>
            <!-- /.col-md-12 -->
          </div>
          <!-- /.row -->
        </div>
        <!-- /.container -->
      </section>
      <!-- /.flat-partner background -->

      <footer>
        <div class="container">
          <div class="row">
            <div class="col-md-3">
              <div class="widget-ft widget-contact">
                <h3 class="title">CONTACT US</h3>
                <ul class="flat-contact">
                  <li class="contact">
                    <p class="phone">1 (800) 686-6688</p>
                    <p class="email">info.deercreative@gmail.com</p>
                  </li>
                  <li class="address">
                    <p>
                      40 Baria Sreet 133/2 <br/>NewYork City, US
                    </p>
                  </li>
                  <li class="open-hours">
                    <p>Open hours: 8.00-18.00 Mon-Fri</p>
                  </li>
                </ul>
              </div>
              <!-- /.widget-ft widget-contact -->
            </div>
            <!-- /.col-md-3 -->
            <div class="col-md-3">
              <div class="widget-ft widget-link-cat">
                <h3 class="title">LINK CATEGORIES</h3>
                <ul class="one-half">
                  <li>
                    <a href="#" title="">Agency</a>
                  </li>
                  <li>
                    <a href="#" title="">Studio</a>
                  </li>
                  <li>
                    <a href="#" title="">Studio</a>
                  </li>
                  <li>
                    <a href="#" title="">Blogs</a>
                  </li>
                  <li>
                    <a href="#" title="">Shop</a>
                  </li>
                </ul>
                <!-- /.one-half -->
                <ul class="one-half">
                  <li>
                    <a href="#" title="">Home</a>
                  </li>
                  <li>
                    <a href="#" title="">About</a>
                  </li>
                  <li>
                    <a href="#" title="">Services</a>
                  </li>
                  <li>
                    <a href="#" title="">Work</a>
                  </li>
                  <li>
                    <a href="#" title="">Privacy </a>
                  </li>
                </ul>
                <!-- /.one-half -->
              </div>
              <!-- /.widget-ft widget-link-cat -->
            </div>
            <!-- /.col-md-3 -->
            <div class="col-md-3">
              <div class="widget-ft widget-lastest-news">
                <h3 class="title">LATEST NEWS</h3>
                <ul class="flat-lastest-news">
                  <li>
                    <a href="#" title="">Device Frienly</a>
                    <p>
                      <span>December 22, 2017</span>
                      <span>
                        <i class="fa fa-comments-o" aria-hidden="true"></i>10
                      </span>
                    </p>
                  </li>
                  <li>
                    <a href="#" title="">Simple, Fast and Fun</a>
                    <p>
                      <span>December 22, 2017</span>
                      <span>
                        <i class="fa fa-comments-o" aria-hidden="true"></i>10
                      </span>
                    </p>
                  </li>
                  <li>
                    <a href="#" title="">We creative Experiences</a>
                    <p>
                      <span>December 22, 2017</span>
                      <span>
                        <i class="fa fa-comments-o" aria-hidden="true"></i>10
                      </span>
                    </p>
                  </li>
                </ul>
                <!-- /.flat-lastest-news -->
              </div>
              <!-- /.widget-ft widget-contact -->
            </div>
            <!-- /.col-md-3 -->
            <div class="col-md-3">
              <div class="widget-ft widget-twitter-feed">
                <h3 class="title">TWITTER FEED</h3>
                <p>
                  <i class="fa fa-twitter" aria-hidden="true"></i> Check out 'Yolo - Creative Multi-Purpose WordPress Theme' on #EnvatoMarket by @Leonard_Design
                </p>
                <p>#https://themeforest.net/user/leonard_design/portfolio</p>
                <span>About 9 months ago</span>
              </div>
            </div>
            <!-- /.col-md-3 -->
          </div>
          <!-- /.row -->
        </div>
        <!-- /.container -->
      </footer>
      <!-- /.footer -->

      <section class="footer-bottom">
        <div class="container">
          <div class="row">
            <div class="col-md-12">
              <ul class="social-ft">
                <li>
                  <a href="" title="Facebook">
                    <i class="fa fa-facebook" aria-hidden="true"></i>
                  </a>
                </li>
                <li>
                  <a href="" title="Twitter">
                    <i class="fa fa-twitter" aria-hidden="true"></i>
                  </a>
                </li>
                <li>
                  <a href="" title="Google Plus">
                    <i class="fa fa-google-plus" aria-hidden="true"></i>
                  </a>
                </li>
                <li>
                  <a href="" title="Instagram">
                    <i class="fa fa-instagram" aria-hidden="true"></i>
                  </a>
                </li>
                <li>
                  <a href="" title="Pinterest">
                    <i class="fa fa-pinterest" aria-hidden="true"></i>
                  </a>
                </li>
                <li>
                  <a href="" title="Tripadvisor">
                    <i class="fa fa-tripadvisor" aria-hidden="true"></i>
                  </a>
                </li>
              </ul>
              <p class="copyright">
                Copyright ©2017 <a href="#" title="">DeerCreative</a>. All Rights Reserved
              </p>
            </div>
          </div>
        </div>
        <!-- /.container -->
      </section>
      <!-- /.footer-bottom -->

      <div class="button-go-top">
        <a href="#" title="" class="go-top">
          <i class="fa fa-chevron-up"></i>
        </a>
        <!-- /.go-top -->
      </div>
      <!-- /.button-go-top -->

    </div>
    <!-- /.boxed -->


  </xsl:template>
</xsl:stylesheet>
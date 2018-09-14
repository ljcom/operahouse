<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" >

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
      meta.content = "width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no";
      loadMeta(meta);


      loadScript('OPHContent/themes/themeSIX/js/main.js');

      $("body").addClass("header_sticky");
      document.title='<xsl:value-of select="/sqroot/header/info/title"/>';
      //loadContent(1);
    </script>

    <!-- Boostrap style -->

    <!--link href="./images/icons/favicon.png" rel="shortcut icon"-->


    <div class="preloader">
      <div class="dizzy-gillespie"></div>
    </div>
    <!-- /.preloader -->

    <!-- *** NOTIFICATION MODAL -->
    <div id="notiModal" class="modal fade" role="dialog">
      <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&#215;</button>
            <h4 class="modal-title" id="notiTitle">Modal Header</h4>
          </div>
          <div class="modal-body" id="notiContent">
            <p>Some text in the modal.</p>
          </div>
          <div class="modal-footer">
            <button id="notiBtn" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div>
        </div>

      </div>
    </div>
    <div class="boxed">

      <section id="header" class="header">
        <div class="container-fluid">
          <div id="logo" class="logo float-left" style="float:left;">
            <a href="index.html" title="Yolo">
              L'OREAL
            </a>
          </div>
          <!-- /.icon-header -->
          <ul class="flat-infomation">
            <xsl:apply-templates select="sqroot/header/menus/menu[@code='specialfront']/submenus/submenu" />
            
          </ul>
          <!-- /.flat-infomation -->
          <div class="nav-wrap">
            <div class="btn-menu">
              <span>dssadas</span>
            </div>
            <!-- //mobile menu button -->
            <div id="mainnav" class="mainnav">
              <ul class="menu flat-unstyled" style="margin-right:0;">
                <xsl:apply-templates select="sqroot/header/menus/menu[@code='primaryfront']/submenus/submenu" />
                
              </ul>
              <!-- /.menu -->
            </div>
            <!-- /.mainnav -->
          </div>
          <!-- /.nav-wrap -->
          <div class="clearfix"></div>
        </div>
        <!-- /.container-fluid -->
        
      </section>
      <!-- /.header -->

      <section class="page-title parallax" style="background-image: url('{sqroot/header/info/code/imgHeader/.}'); ">
        <div class="title-heading">
          <div class="container">
            <div class="row">
              <div class="col-md-12">
                <div class="box-title style1">
                  <h2 style="color:#000000cc; margin-bottom:10px;">
                    <xsl:value-of select="sqroot/header/info/code/name/." />
                  </h2>
                  <p style="color:#000000cc; font-size:25px; letter-spacing: 3px; ">
                    <xsl:value-of select="sqroot/header/info/code/titleTag/." />
                  </p>
                  <!--<div class="breadcrumbs">
                    <ul>
                      <li>
                        <a href="index.html" title="">Home</a>
                        <i class="fa fa-angle-right" aria-hidden="true"></i>
                      </li>
                      <li>
                        <a href="element.html" title="">Element</a>
                        <i class="fa fa-angle-right" aria-hidden="true"></i>
                      </li>
                      <li>
                        <a href="#" title="">Contact Simple</a>
                      </li>
                    </ul>
                  </div>-->
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
      
      <div id="contentWrapper">
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
                <div class="form-contact-form style3 v2 two">
                  <form id="formlogin" onsubmit="return signInFrontEnd();">
                    <div class="form-group enabled-input contact-form-name contact-form">
                      <label>User Name</label>
                      <input type="text" class="form-control" name="userid" id="userid" autofocus="autofocus" onkeypress="return checkenter(event)" />

                    </div>
                    <div class="form-group enabled-input contact-form-name contact-form">
                      <label>Password</label>
                      <input type="password" class="form-control" name="pwd" id="pwd" autofocus="autofocus" onkeypress="return checkenter(event)" />

                    </div>
                  </form>
                  <div class="btn-contact-form" style="text-align:center">
                    <button id="btn_submitLogin" class="flat-button-form border-radius-2" onclick="signInFrontEnd()">SUBMIT</button>&#160;
                  </div>
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
      </div>


      <div class="divider100"></div>


      <section class="flat-partner background">
        <div class="container">
          <div class="row">
            <div class="col-md-12">
              <!--<ul class="owl-carousel">
                <li>
                  <img src="images/partner/01.png" alt="">
							</li>
                <li>
                  <img src="images/partner/02.png" alt="">
							</li>
                <li>
                  <img src="images/partner/03.png" alt="">
							</li>
                <li>
                  <img src="images/partner/04.png" alt="">
							</li>
                <li>
                  <img src="images/partner/05.png" alt="">
							</li>
                <li>
                  <img src="images/partner/06.png" alt="">
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

  <xsl:template match="sqroot/header/menus/menu[@code='primaryfront']/submenus/submenu">
    <xsl:choose>
      <xsl:when test="(@type)='treeroot'">
        <li class="login">
          <a href="#" title="">
            <xsl:value-of select="caption/." /><i class="fa fa-angle-down" aria-hidden="true"></i>
          </a>
          <ul class="unstyled border-radius-5 box-shadow">
            <xsl:apply-templates select="submenus/submenu[@type='treeview']" />
          </ul>
        </li>
      </xsl:when>
      <xsl:when test="(@type)='label'">
        <li class="has-menu-mega">
          <a href="{pageURL/.}" title="">
            <xsl:value-of select="caption/." />
          </a>
        </li>
      </xsl:when>
    </xsl:choose>
    <!--<li class="dropdown">
      <xsl:choose>
        <xsl:when test="(@type)='treeroot'">
          <a href="{pageURL/.}" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" id="prim-{caption/.}">
            <xsl:value-of select="caption/." />
          </a>
          <ul class="dropdown-menu dropdown-menu-right">
            <xsl:apply-templates select="submenus/submenu[@mode='treeview']" />
          </ul>
        </xsl:when>
        <xsl:when test="(@type)='label'">
          <a href="{pageURL/.}" id="prim-{caption/.}"  onclick="clearCookies()">
            <xsl:value-of select="caption/." />
          </a>
        </xsl:when>
      </xsl:choose>
    </li>-->
  </xsl:template>


  <xsl:template match="sqroot/header/menus/menu[@code='specialfront']/submenus/submenu">
    <li class="{@type}">
      <a href="{pageURL/.}" title="">
        <xsl:value-of select="caption/." />
      </a>
    </li>
  </xsl:template>

  <xsl:template match="submenus/submenu[@type='treeview']">
    <li>
      <a href="{pageURL/.}" title="">
        <xsl:value-of select="caption/." />
      </a>
    </li>
  </xsl:template>
</xsl:stylesheet>
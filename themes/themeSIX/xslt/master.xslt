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
      resetBrowseCookies(1);
      loadContent(1);
      
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
            <img src="ophcontent/themes/themesix/images/logo.png" style="margin-top:20px"/>
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
              <ul class="menu" style="margin-right:0;">
                <xsl:apply-templates select="sqroot/header/menus/menu[@code='primaryfront']/submenus/submenu" />
                <xsl:choose>
                  <xsl:when test="/sqroot/header/info/user/userGUID/.">
                    <li class="has-submenu" style="width:150px;">
                      <a href="#" title="">
                        <xsl:value-of select="/sqroot/header/info/user/userNameAlias/." />
                      </a>
                      <div class="submenu">
                        <ul>
                          <li>
                            <a href="?code=userprof&amp;guid={/sqroot/header/info/user/userGUID/.}" title="">Profile</a>
                          </li>
                          <li>
                            <a href="javascript:signOut()" title="">Log Out</a>
                          </li>
                        </ul>
                      </div>
                    </li>
                  </xsl:when>
                  <xsl:otherwise>
                    <li>
                      <a href="?code=login" title="">
                        Sign In
                      </a>
                    </li>
                  </xsl:otherwise>
                </xsl:choose>

              </ul>
              <!-- /.menu -->
            </div>
            <!-- /.mainnav -->
          </div>
          <!-- /.nav-wrap -->
          <div class="clearfix"></div>
        </div>
        <!-- /.container-fluid -->
        <!--<div class="menu-canvas">
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
        </div>-->
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
                  <br/>
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
      <div id="contentWrapper">
        <section class="flat-row flat-contact-form style5">
          <div class="container" style="text-align:center">
            <i class="fa fa-spinner fa-spin fa fa-fw">&#xA0;</i>
            <br/>
            Loading Please Wait...
          </div>
        </section>
      </div>
      


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


      <section class="footer-bottom">
        <div class="container">
          <div class="row">
            <div class="col-md-12">
              <!--<ul class="social-ft">
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
              </ul>-->
              <p class="copyright" style="font-family:poppins">
                Copyright ©2018 <a href="#" title="">OPERAHOUSE</a>. All Rights Reserved
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
        <li class="has-submenu">
          <a href="#" title="">
            <xsl:value-of select="caption/." />
          </a>
          <div class="submenu">
            <ul>
              <xsl:apply-templates select="submenus/submenu[@type='treeview']" />
            </ul>
          </div>
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
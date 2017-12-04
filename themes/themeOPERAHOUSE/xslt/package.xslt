<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  <xsl:template match="/">
    <script>
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/assets/js/plugins.min.js');

      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/assets/js/app.min.js');

      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/assets/js/home-generic-6.js');

      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/assets/custom-me.js');

      loadContent(1);

      setCookie('lastPar', document.URL, 0, 1, 0);
      $(".cartbtn").click(function(){
      var filter = "parentdocguid='" + getCookie('cartID') + "'";
      LoadNewPart('cart_modal', 'cartmodalcontent', 'ordersdetailsmodal', filter, '');
      });
    </script>
    <!--sidebar-->
    <div class="ms-slidebar sb-slidebar sb-left sb-style-overlay" id="ms-slidebar">
      <div class="sb-slidebar-container">
        <header class="ms-slidebar-header">
          <div class="ms-slidebar-login">
            <xsl:if test="not(sqroot/header/info/user/userName/.)">
              <a href="index.aspx?code=register" class="withripple">
                <i class="zmdi zmdi-account"></i> Login
              </a>
            </xsl:if>
            <xsl:if test="(sqroot/header/info/user/userName/.)">
              <a href="index.aspx?code=userprofile&amp;GUID={/sqroot/header/info/user/userGUID}" class="withripple" data-toggle="tooltip" data-placement="bottom" title="Go to profile">
                <xsl:value-of select="/sqroot/header/info/user/userName/." />&amp;nbsp;
              </a>
              <a href="javascript:void(0)" onclick="signOut()" class="withripple" data-toggle="tooltip" data-placement="bottom" title="Signout">
                Sign Out
              </a>
            </xsl:if>
          </div>
          
        </header>
        <ul class="ms-slidebar-menu" id="slidebar-menu" role="tablist" aria-multiselectable="true">
          
          <xsl:apply-templates select="sqroot/header/menus/menu[@code='mobilemenu']/submenus/submenu" />
          
        </ul>
        
      </div>
    </div>
    <!--this is notif Modal-->
    <div class="modal modal-primary" id="notiModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel6">
      <div class="modal-dialog animated zoomIn animated-3x" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">
                <i class="zmdi zmdi-close"></i>
              </span>
            </button>
            <h3 class="modal-title" id="notiModalLabel">Notification</h3>
          </div>
          <div class="modal-body">
            <p id="notiModalText">Message</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>
    <!--preload-->
    <div id="ms-preload" class="ms-preload">
      <div id="status">
        <div class="spinner">
          <div class="dot1"></div>
          <div class="dot2"></div>
        </div>
      </div>
    </div>
    <!--wave loading screen-->
    <div id="content-loader" style="display:none">
      <div class="sk-wave">
        <div class="sk-rect sk-rect1"></div>
        <div class="sk-rect sk-rect2"></div>
        <div class="sk-rect sk-rect3"></div>
        <div class="sk-rect sk-rect4"></div>
        <div class="sk-rect sk-rect5"></div>
      </div>
    </div>
    <!--cartmodal-->
    <div class="modal modal-primary" id="cartmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel6">
      <div class="modal-dialog animated zoomIn animated-3x" role="document">
        <div class="modal-content">
          <div id="cartmodalcontent">
            test
          </div>
        </div>
      </div>
    </div>
    <!--this is content-->
    <div class="sb-site-container">
      <div class="modal modal-primary" id="ms-account-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog animated zoomIn animated-3x" role="document">
          <div class="modal-content">
            <div class="modal-header shadow-2dp no-pb">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">
                  <i class="zmdi zmdi-close"></i>
                </span>
              </button>
              <div class="modal-title text-center">
                <!--<span class="ms-logo ms-logo-white ms-logo-sm mr-1" style="font-size:12px;">MX4</span>-->
                <img  src="OPHContent/themes/{/sqroot/header/info/themeFolder}/assets/img/logo.png" style="max-width:30px; margin-right:10px;" />
                <h3 class="no-m ms-site-title">
                  <span>Operahouse</span>Systems                 
                </h3>
              </div>
            </div>
            
          </div>
        </div>
      </div>
      <header class="ms-header ms-header-primary">
        <div class="container container-full">
          <div class="ms-title">
            <a href="javascript:void(0)">
              <!-- <img src="OPHContent/themes/{/sqroot/header/info/themeFolder}/assets/img/demo/logo-header.png" alt=""> -->
              <!--<span class="ms-logo animated zoomInDown animation-delay-5" style="font-size:18px;">OPH</span>-->
              <img class="animated zoomInDown animation-delay-5" src="OPHContent/themes/{/sqroot/header/info/themeFolder}/assets/img/logo.png" style="max-width:70px;" />
              <h1 class="animated fadeInRight animation-delay-6">
                <span>Operahouse</span>Systems               
              </h1>
            </a>
          </div>
          <div class="header-right">

            <xsl:if test="(sqroot/header/info/user/userName/.)">
              <div class="btn-group">
                <a href="index.aspx?code=userprofile&amp;GUID={/sqroot/header/info/user/userGUID}" style="color:white; padding:5px;" class="animated zoomInDown animation-delay-10" data-toggle="tooltip" data-placement="bottom" title="Go to profile">
                  <xsl:value-of select="/sqroot/header/info/user/userName/." />&amp;nbsp;
                </a>
                <a href="#" style="color:white; padding:5px;" class="animated zoomInDown animation-delay-10" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                   <i class="zmdi zmdi-chevron-down right only"></i>
                </a>
                <ul class="dropdown-menu dropdown-menu-right" style="top:25px;">
               
                  <li>
                    <a href="javascript:void(0)" onclick="signOut()" style="padding:5px 10px;">Sign Out</a>
                  </li>
                </ul>
              </div>
              <a href="javascript:void(0)" class="cartbtn btn-ms-menu btn-circle btn-circle-primary animated zoomInDown animation-delay-10" data-toggle="modal" data-target="#cartmodal">
                <i class="zmdi zmdi-shopping-cart">
                  <p id="totalincart" href="javascript:void(0)" style="color:white; background:#EB8C00; position:absolute;top:10px;right:15px; padding:2px; font-size:10px;">0</p>
                </i>

              </a>
            </xsl:if>

            <xsl:if test="not(sqroot/header/info/user/userName/.)">
              <a href="index.aspx?code=register" class="btn-circle btn-circle-primary no-focus animated zoomInDown animation-delay-8" data-toggle="tooltip" data-placement="bottom" title="Login or Register">
                <i class="zmdi zmdi-account"></i>
              </a>
            </xsl:if>
            <a href="javascript:void(0)" class="btn-ms-menu btn-circle btn-circle-primary sb-toggle-left animated zoomInDown animation-delay-10"  data-toggle="tooltip" data-placement="bottom" title="Show Menu Sidebar">
              <i class="zmdi zmdi-menu"></i>
            </a>
          </div>
        </div>
      </header>
      <!--this is menu-->
      <nav class="navbar navbar-static-top yamm ms-navbar ms-navbar-primary">
        <div class="container container-full">
          <div class="navbar-header">
            <a class="navbar-brand" href="javascript:void(0)">
               <img src="OPHContent/themes/{/sqroot/header/info/themeFolder}/assets/img/logo.png" style="width:30px" alt=""/> 
              <!--<span class="ms-logo ms-logo-sm" style="font-size:12px;">MX4</span>-->
              <span class="ms-title">
                <strong>Operahouse</strong>
                Systems
              </span>
            </a>
          </div>
          <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">

              <xsl:apply-templates select="sqroot/header/menus/menu[@code='primaryfront']/submenus/submenu" />
              <li class="btn-navbar-menu">
                <a href="javascript:void(0)" class="cartbtn" data-toggle="modal" data-target="#cartmodal">
                  <i class="zmdi zmdi-shopping-cart">
                    <p id="totalincart" href="javascript:void(0)" style="color:white; background:#EB8C00; position:absolute;top:10px;right:15px; padding:2px; font-size:10px;">0</p>
                  </i>

                </a>
              </li>
            </ul>
          </div>
          <!-- navbar-collapse collapse -->
          <a href="javascript:void(0)" class="sb-toggle-left btn-navbar-menu">
            <i class="zmdi zmdi-menu"></i>
          </a>
        </div>
        <!-- container -->
      </nav>

      <div id="contentWrapper">
        
        
      </div>
      <!--this is content One-->
      <!--<div class="container mt-6">
        <div class="text-center">
          <h2 class="color-primary">
            Knows the
            <span class="text-normal">Material Style</span> and surprise yourself
          </h2>
          <p class="lead">Put here a short description or brief highlights in your app.</p>
        </div>
        <div class="panel-body">
          <div class="tab-content mt-4">
            <div class="row">
              <div class="col-md-6 col-lg-5 col-md-push-6 col-lg-push-7">
                <ul class="list-unstyled hand-list">
                  <li class="animated fadeInLeft animation-delay-2">
                    <h2 class="no-mt color-primary no-mb">Ideas for your product</h2>
                    <p class="lead handwriting">Lorem ipsum dolor sit amet, consectetur adipisicing elit provident tempore porro deserunt nostrum sapiente.</p>
                  </li>
                  <li class="animated fadeInLeft animation-delay-4">
                    <h2 class="handwriting no-mt color-primary no-mb">Type here annotations</h2>
                    <p class="lead handwriting">Lorem ipsum dolor sit amet, consectetur adipisicing elit provident tempore porro deserunt nostrum sapiente.</p>
                  </li>
                  <li class="animated fadeInLeft animation-delay-6">
                    <h2 class="handwriting no-mt color-primary no-mb">An informal approach to design</h2>
                    <p class="lead handwriting">Lorem ipsum dolor sit amet, consectetur adipisicing elit provident tempore porro deserunt nostrum.</p>
                  </li>
                </ul>
              </div>
              <div class="col-md-6 col-lg-7 col-md-pull-6 col-lg-pull-5">
                <img class="img-responsive animated zoomInDown animation-delay-3" src="assets/img/demo/surface.png" />
              </div>
            </div>
          </div>
        </div>
      </div>-->
      <!--this is banner-->
      <!--<div class="container mt-6">
        <div class="text-center mw-800 center-block mb-4">
          <h2 class="color-primary wow fadeInDown animation-delay-4">We know what you need</h2>
          <p class="lead wow fadeInDown animation-delay-4">Discover our projects and the rigorous process of creation. Our principles are creativity, design, experience and knowledge. We are backed by 20 years of research.</p>
        </div>
        <div class="row">
          <div class="col-md-3">
            <div class="card card-royal wow zoomInUp animation-delay-5">
              <div class="bg-royal">
                <img src="assets/img/demo/m1.png" alt="..." class="img-avatar-circle"/> </div>
              <div class="card-block pt-4 text-center">
                <h4 class="color-royal">A Feature Title</h4>
                <p>Eaque repellendus nemo deserunt qui sequi laborum officiis assumenda caecati.</p>
                <a href="javascript:void(0)" class="btn btn-royal">
                  <i class="zmdi zmdi-star"></i> Action here
                </a>
              </div>
            </div>
          </div>
          <div class="col-md-3">
            <div class="card card-danger wow zoomInUp animation-delay-6">
              <div class="bg-danger">
                <img src="assets/img/demo/m2.png" alt="..." class="img-avatar-circle"/> </div>
              <div class="card-block pt-4 text-center">
                <h4 class="color-danger">A Feature Title</h4>
                <p>Eaque repellendus nemo deserunt qui sequi laborum officiis assumenda caecati.</p>
                <a href="javascript:void(0)" class="btn btn-danger">
                  <i class="zmdi zmdi-star"></i> Action here
                </a>
              </div>
            </div>
          </div>
          <div class="col-md-3">
            <div class="card card-warning wow zoomInUp animation-delay-7">
              <div class="bg-warning">
                <img src="assets/img/demo/m3.png" alt="..." class="img-avatar-circle"/> </div>
              <div class="card-block pt-4 text-center">
                <h4 class="color-warning">A Feature Title</h4>
                <p>Eaque repellendus nemo deserunt qui sequi laborum officiis assumenda caecati.</p>
                <a href="javascript:void(0)" class="btn btn-warning">
                  <i class="zmdi zmdi-star"></i> Action here
                </a>
              </div>
            </div>
          </div>
          <div class="col-md-3">
            <div class="card card-success wow zoomInUp animation-delay-8">
              <div class="bg-success">
                <img src="assets/img/demo/m4.png" alt="..." class="img-avatar-circle"/> </div>
              <div class="card-block pt-4 text-center">
                <h4 class="color-success">A Feature Title</h4>
                <p>Eaque repellendus nemo deserunt qui sequi laborum officiis assumenda caecati.</p>
                <a href="javascript:void(0)" class="btn btn-success">
                  <i class="zmdi zmdi-star"></i> Action here
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>-->
      <!--this is amazing feature-->
      <!--<section class="wrap ms-hero-page ms-hero-img-coffee ms-hero-bg-info ms-bg-fixed color-white mt-6">
        <div class="container">
          <h2 class="text-center fw-500 mb-6 wow fadeInDown animation-delay-2">Amazing Features</h2>
          <div class="row">
            <div class="col-sm-6 col-md-3 wow fadeIn animation-delay-2">
              <div class="text-center">
                <div class="circle" id="circles-1"></div>
                <h4 class="text-center">HTML 5</h4>
                <p class="small-font">Lorem ipsum dolor sit amet consectetur adipisicing.</p>
              </div>
            </div>
            <div class="col-sm-6 col-md-3 wow fadeIn animation-delay-3">
              <div class="text-center">
                <div class="circle" id="circles-2"></div>
                <h4 class="text-center">CSS 3</h4>
                <p class="small-font">Lorem ipsum dolor sit amet consectetur adipisicing.</p>
              </div>
            </div>
            <div class="col-sm-6 col-md-3 wow fadeIn animation-delay-4">
              <div class="text-center">
                <div class="circle" id="circles-3"></div>
                <h4 class="text-center">Jquery</h4>
                <p class="small-font">Lorem ipsum dolor sit amet consectetur adipisicing.</p>
              </div>
            </div>
            <div class="col-sm-6 col-md-3 wow fadeIn animation-delay-5">
              <div class="text-center">
                <div class="circle" id="circles-4"></div>
                <h4 class="text-center">Bootstrap 3</h4>
                <p class="small-font">Lorem ipsum dolor sit amet consectetur adipisicing.</p>
              </div>
            </div>
          </div>
          <div class="text-center mt-6">
            <a href="javascript:void(0)" class="btn btn-raised btn-lg btn-white color-primary animated flipInX animation-delay-4">
              <i class="zmdi zmdi-info"></i> Know More
            </a>
            <a href="javascript:void(0)" class="btn btn-raised btn-lg btn-info animated flipInX animation-delay-6">
              <i class="zmdi zmdi-email"></i> Contact US
            </a>
          </div>
        </div>
      </section>-->

      <!--this is footer-->
      <footer class="ms-footer">
        <div class="container">
          <p>Copyright © OPERAHOUSE 2017</p>
        </div>
      </footer>
    </div>

    <!--button back to top-->
    <div class="btn-back-top">
      <a href="#" data-scroll="" id="back-top" class="btn-circle btn-circle-primary btn-circle-sm btn-circle-raised ">
        <i class="zmdi zmdi-long-arrow-up"></i>
      </a>
    </div>
  </xsl:template>
  
  <!--primaryfront menu-->
  <xsl:template match="sqroot/header/menus/menu[@code='primaryfront']/submenus/submenu">
    <xsl:if test="(@type)='label'">
      <li class="dropdown">
        <a href="{pageURL}" class="dropdown-toggle animated fadeIn animation-delay-4">
          <xsl:value-of select="caption/." />&#160;
        </a>
      </li>
    </xsl:if>
    <xsl:if test="(@type)='dropdown-expand'">
      <li class="dropdown yamm-fw">
        <a href="#" class="dropdown-toggle animated fadeIn animation-delay-6" data-toggle="dropdown" data-hover="dropdown" role="button" aria-haspopup="true" aria-expanded="false" data-name="component">
          <xsl:value-of select="caption/." />&#160;
          <i class="zmdi zmdi-chevron-down"></i>
        </a>

        <ul class="dropdown-menu dropdown-megamenu animated fadeIn animated-2x">
          <li>
            <div class="row">
              <div class="col-sm-3 megamenu-col">
                <xsl:apply-templates select="submenus/submenu[@type='list1']" />&#160;
                
              </div>
              <div class="col-sm-3 megamenu-col">
                <xsl:apply-templates select="submenus/submenu[@type='list2']" />&#160;

              </div>
              <div class="col-sm-3 megamenu-col">
                <xsl:apply-templates select="submenus/submenu[@type='list3']" />&#160;

              </div>
              <div class="col-sm-3 megamenu-col">
                <xsl:apply-templates select="submenus/submenu[@type='list4']" />&#160;

              </div>
            </div>
          </li>
        </ul>
      </li>
    </xsl:if>
   
  </xsl:template>

  <xsl:template match="submenus/submenu[@type='list1'] | submenus/submenu[@type='list2'] | submenus/submenu[@type='list3'] | submenus/submenu[@type='list4']">
    <div class="megamenu-block animated fadeInLeft animated-2x">
      <h3 class="megamenu-block-title">
        <xsl:value-of select="caption/." />&#160;
      </h3>
      <ul class="megamenu-block-list">
        <xsl:apply-templates select="submenus/submenu[@type='itemlist']" />&#160;
        
      </ul>
    </div>
  </xsl:template>


  <xsl:template match="submenus/submenu[@type='itemlist']">
    <li>
      <a class="withripple" href="{pageURL}">
        <i class="fa fa-angle-right"></i> <xsl:value-of select="caption/." />&#160;
      </a>
    </li>
  </xsl:template>

  <!--mobilemenu menu-->
  <xsl:template match="sqroot/header/menus/menu[@code='mobilemenu']/submenus/submenu">
    <xsl:if test="(@type)='label'">
      <li>
        <a class="link" href="{pageURL}">
          <xsl:value-of select="caption/." />
        </a>
      </li>
    </xsl:if>

    <xsl:if test="(@type)='dropdown-expand'">
      <li class="panel" role="tab" id="{MenuDescription}sch1">
        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#slidebar-menu" href="#{MenuDescription}sc1" aria-expanded="false" aria-controls="sc1">
           <xsl:value-of select="caption/." />
        </a>
        <ul id="{MenuDescription}sc1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="sch1">
          <xsl:apply-templates select="submenus/submenu[@type='mobiledrop']" />
         
        </ul>
      </li>
    </xsl:if>
    
  </xsl:template>

  <xsl:template match="submenus/submenu[@type='mobiledrop']">
    <li>
      <a  href="{pageURL}">
        <xsl:value-of select="caption/." />
      </a>
    </li>
  </xsl:template>
</xsl:stylesheet>

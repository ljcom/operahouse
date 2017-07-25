<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  <xsl:template match="/">
    <script>
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/assets/js/plugins.min.js');

      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/assets/js/app.min.js');

      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/assets/js/home-generic-6.js');
    </script>
    <div id="ms-preload" class="ms-preload">
      <div id="status">
        <div class="spinner">
          <div class="dot1"></div>
          <div class="dot2"></div>
        </div>
      </div>
    </div>
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
                  <span>Operahouse</span>
                  Systems
                </h3>
              </div>
              <div class="modal-header-tabs">
                <ul class="nav nav-tabs nav-tabs-full nav-tabs-3 nav-tabs-primary" role="tablist">
                  <li role="presentation" class="active">
                    <a href="#ms-login-tab" aria-controls="ms-login-tab" role="tab" data-toggle="tab" class="withoutripple">
                      <i class="zmdi zmdi-account"></i> Login
                    </a>
                  </li>
                  <li role="presentation">
                    <a href="#ms-register-tab" aria-controls="ms-register-tab" role="tab" data-toggle="tab" class="withoutripple">
                      <i class="zmdi zmdi-account-add"></i> Register
                    </a>
                  </li>
                  <li role="presentation">
                    <a href="#ms-recovery-tab" aria-controls="ms-recovery-tab" role="tab" data-toggle="tab" class="withoutripple">
                      <i class="zmdi zmdi-key"></i> Recovery Pass
                    </a>
                  </li>
                </ul>
              </div>
            </div>
            <div class="modal-body">
              <div class="tab-content">
                <div role="tabpanel" class="tab-pane fade active in" id="ms-login-tab">
                  <form autocomplete="off">
                    <fieldset>
                      <div class="form-group label-floating">
                        <div class="input-group">
                          <span class="input-group-addon">
                            <i class="zmdi zmdi-account"></i>
                          </span>
                          <label class="control-label" for="ms-form-user">Username</label>
                          <input type="text" id="ms-form-user" class="form-control" /> </div>
                      </div>
                      <div class="form-group label-floating">
                        <div class="input-group">
                          <span class="input-group-addon">
                            <i class="zmdi zmdi-lock"></i>
                          </span>
                          <label class="control-label" for="ms-form-pass">Password</label>
                          <input type="password" id="ms-form-pass" class="form-control" /> </div>
                      </div>
                      <div class="row mt-2">
                        <div class="col-md-6">
                          <div class="form-group no-mt">
                            <div class="checkbox">
                              <label>
                                <input type="checkbox" /> Remember Me </label>
                            </div>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <button class="btn btn-raised btn-primary pull-right">Login</button>
                        </div>
                      </div>
                    </fieldset>
                  </form>
                  <div class="text-center">
                    <h3>Login with</h3>
                    <a href="javascript:void(0)" class="wave-effect-light btn btn-raised btn-facebook">
                      <i class="zmdi zmdi-facebook"></i> Facebook
                    </a>
                    <a href="javascript:void(0)" class="wave-effect-light btn btn-raised btn-twitter">
                      <i class="zmdi zmdi-twitter"></i> Twitter
                    </a>
                    <a href="javascript:void(0)" class="wave-effect-light btn btn-raised btn-google">
                      <i class="zmdi zmdi-google"></i> Google
                    </a>
                  </div>
                </div>
                <div role="tabpanel" class="tab-pane fade" id="ms-register-tab">
                  <form>
                    <fieldset>
                      <div class="form-group label-floating">
                        <div class="input-group">
                          <span class="input-group-addon">
                            <i class="zmdi zmdi-account"></i>
                          </span>
                          <label class="control-label" for="ms-form-user">Username</label>
                          <input type="text" id="ms-form-user"  class="form-control" /> </div>
                      </div>
                      <div class="form-group label-floating">
                        <div class="input-group">
                          <span class="input-group-addon">
                            <i class="zmdi zmdi-email"></i>
                          </span>
                          <label class="control-label" for="ms-form-email">Email</label>
                          <input type="email" id="ms-form-email"  class="form-control" /> </div>
                      </div>
                      <div class="form-group label-floating">
                        <div class="input-group">
                          <span class="input-group-addon">
                            <i class="zmdi zmdi-lock"></i>
                          </span>
                          <label class="control-label" for="ms-form-pass">Password</label>
                          <input type="password" id="ms-form-pass"  class="form-control" /> </div>
                      </div>
                      <div class="form-group label-floating">
                        <div class="input-group">
                          <span class="input-group-addon">
                            <i class="zmdi zmdi-lock"></i>
                          </span>
                          <label class="control-label" for="ms-form-pass">Re-type Password</label>
                          <input type="password" id="ms-form-pass"  class="form-control" /> </div>
                      </div>
                      <button class="btn btn-raised btn-block btn-primary">Register Now</button>
                    </fieldset>
                  </form>
                </div>
                <div role="tabpanel" class="tab-pane fade" id="ms-recovery-tab">
                  <form>
                  <fieldset>
                    <div class="form-group label-floating">
                      <div class="input-group">
                        <span class="input-group-addon">
                          <i class="zmdi zmdi-account"></i>
                        </span>
                        <label class="control-label" for="ms-form-user">Username</label>
                        <input type="text" id="ms-form-user"  class="form-control" /> </div>
                    </div>
                    <div class="form-group label-floating">
                      <div class="input-group">
                        <span class="input-group-addon">
                          <i class="zmdi zmdi-email"></i>
                        </span>
                        <label class="control-label" for="ms-form-email">Email</label>
                        <input type="email" id="ms-form-email"  class="form-control" /> </div>
                    </div>
                    <button class="btn btn-raised btn-block btn-primary">Send Password</button>
                  </fieldset>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <header class="ms-header ms-header-primary">
        <div class="container container-full">
          <div class="ms-title">
            <a href="index.html">
              <!-- <img src="OPHContent/themes/{/sqroot/header/info/themeFolder}/assets/img/demo/logo-header.png" alt=""> -->
              <!--<span class="ms-logo animated zoomInDown animation-delay-5" style="font-size:18px;">OPH</span>-->
              <img class="animated zoomInDown animation-delay-5" src="OPHContent/themes/{/sqroot/header/info/themeFolder}/assets/img/logo.png" style="max-width:70px;" />
              <h1 class="animated fadeInRight animation-delay-6">
                <span>Operahouse</span>
                Systems
              </h1>
            </a>
          </div>
          <div class="header-right">
            <div class="share-menu">
              <ul class="share-menu-list">
                <li class="animated fadeInRight animation-delay-3">
                  <a href="javascript:void(0)" class="btn-circle btn-google">
                    <i class="zmdi zmdi-google"></i>
                  </a>
                </li>
                <li class="animated fadeInRight animation-delay-2">
                  <a href="javascript:void(0)" class="btn-circle btn-facebook">
                    <i class="zmdi zmdi-facebook"></i>
                  </a>
                </li>
                <li class="animated fadeInRight animation-delay-1">
                  <a href="javascript:void(0)" class="btn-circle btn-twitter">
                    <i class="zmdi zmdi-twitter"></i>
                  </a>
                </li>
              </ul>
              <a href="javascript:void(0)" class="btn-circle btn-circle-primary animated zoomInDown animation-delay-7">
                <i class="zmdi zmdi-share"></i>
              </a>
            </div>
            <a href="javascript:void(0)" class="btn-circle btn-circle-primary no-focus animated zoomInDown animation-delay-8" data-toggle="modal" data-target="#ms-account-modal">
              <i class="zmdi zmdi-account"></i>
            </a>
            <form class="search-form animated zoomInDown animation-delay-9">
              <input id="search-box" type="text" class="search-input" placeholder="Search..." name="q" />
              <label for="search-box">
                <i class="zmdi zmdi-search"></i>
              </label>
            </form>
            <a href="javascript:void(0)" class="btn-ms-menu btn-circle btn-circle-primary sb-toggle-left animated zoomInDown animation-delay-10">
              <i class="zmdi zmdi-menu"></i>
            </a>
          </div>
        </div>
      </header>
      <!--this is menu-->
      <nav class="navbar navbar-static-top yamm ms-navbar ms-navbar-primary">
        <div class="container container-full">
          <div class="navbar-header">
            <a class="navbar-brand" href="index.html">
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
              
              <!-- <li class="btn-navbar-menu"><a href="javascript:void(0)" class="sb-toggle-left"><i class="zmdi zmdi-menu"></i></a></li> -->
            </ul>
          </div>
          <!-- navbar-collapse collapse -->
          <a href="javascript:void(0)" class="sb-toggle-left btn-navbar-menu">
            <i class="zmdi zmdi-menu"></i>
          </a>
        </div>
        <!-- container -->
      </nav>
      <!--this is slider-->
      <header class="ms-hero-page ms-hero-img-keyboard ms-hero-bg-dark color-white">

        <div class="container index-1">
          <div class="col-md-6">
            <h1 class="text-uppercase animated fadeInDown animation-delay-5 typed-title">
              The power to create
              <br/>
                <span class="color-primary typed-class">incredible projects</span>
              </h1>
            <p class="lead lead-sm animated fadeInLeft animation-delay-7 color-light">Fugit velit necessitatibus maiores ex sit modi vitae repellendus, doloremque optio libero voluptas sed suscipit officiis ducimus iste.</p>
            <ul class="ms-list-arrow">
              <li class="animated fadeInUp animation-delay-7">Fugit officiis iure ullam tenetur earum magnam repellat.</li>
              <li class="animated fadeInUp animation-delay-10">Repellat placeat quisquam dignissimos laboriosam.</li>
              <li class="animated fadeInUp animation-delay-13">Obcaecati necessitatibus sapiente adipisci dolore.</li>
              <li class="animated fadeInUp animation-delay-16">Blanditiis tempora perspiciatis architecto voluptates.</li>
            </ul>
            <div class="text-center">
              <a href="javascript:void(0)" class="btn btn-raised btn-lg btn-white color-primary animated flipInX animation-delay-20">
                <i class="zmdi zmdi-airplane"></i> Call to action
              </a>
              <a href="javascript:void(0)" class="btn btn-raised btn-lg btn-warning animated flipInX animation-delay-24">
                <i class="zmdi zmdi-coffee"></i> Secondary Button
              </a>
            </div>
          </div>
          <div class="col-lg-6 col-md-5">
            <div class="ms-hero-img animated zoomInUp animation-delay-30" style="height:500px;">
              <img src="OPHContent/themes/{/sqroot/header/info/themeFolder}/assets/img/demo/mock-imac-material2.png" alt="" class="img-responsive"/>
                <div id="carousel-hero-img" class="carousel carousel-fade slide" data-ride="carousel" data-interval="5000"  style="top:-473px">
                  <!-- Indicators -->
                  <ol class="carousel-indicators carousel-indicators-hero-img">
                    <li data-target="#carousel-hero-img" data-slide-to="0" class="active"></li>
                    <li data-target="#carousel-hero-img" data-slide-to="1"></li>
                    <li data-target="#carousel-hero-img" data-slide-to="2"></li>
                  </ol>
                  <!-- Wrapper for slides -->
                  <div class="carousel-inner" role="listbox">
                    <div class="ms-hero-img-slider item active">
                      <img src="OPHContent/themes/{/sqroot/header/info/themeFolder}/assets/img/demo/hero1.png" alt="" class="img-responsive"/> </div>
                    <div class="ms-hero-img-slider item">
                      <img src="OPHContent/themes/{/sqroot/header/info/themeFolder}/assets/img/demo/hero3.png" alt="" class="img-responsive"/> </div>
                    <div class="ms-hero-img-slider item">
                      <img src="OPHContent/themes/{/sqroot/header/info/themeFolder}/assets/img/demo/hero2.png" alt="" class="img-responsive"/> </div>
                  </div>
                </div>
              </div>
          </div>
          <div class="col-md-12">
            <div class="text-center ms-margin">
              <a href="javascript:void(0)" class="btn btn-primary btn-raised btn-app wow flipInX animation-delay-20">
                <div class="btn-container">
                  <i class="fa fa-html5"></i>
                  <span>Aviable as</span>
                  <br/>
                    <strong>Web App</strong>
                  </div>
              </a>
              <a href="javascript:void(0)" class="btn btn-primary btn-raised btn-app wow flipInX animation-delay-22">
                <div class="btn-container">
                  <i class="fa fa-windows"></i>
                  <span>Coming Soon for</span>
                  <br/>
                    <strong>Windows</strong>
                  </div>
              </a>
              <a href="javascript:void(0)" class="btn btn-primary btn-raised btn-app wow flipInX animation-delay-26">
                <div class="btn-container">
                  <i class="fa fa-android"></i>
                  <span>Coming Soon in </span>
                  <br/>
                    <strong>Play Store</strong>
                  </div>
              </a>

            </div>
          </div>
        </div>
      </header>
      <!--this is banner-->
      <div class="container mt-6">
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
      </div>
      <!--this is amazing feature-->
      <section class="wrap ms-hero-page ms-hero-img-coffee ms-hero-bg-info ms-bg-fixed color-white mt-6">
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
      </section>
    </div>
  </xsl:template>

  <xsl:template match="sqroot/header/menus/menu[@code='primaryfront']/submenus/submenu">
    <xsl:if test="(@type)='label'">
      <li class="dropdown">
        <a href="javascript:void(0)" class="dropdown-toggle animated fadeIn animation-delay-4">
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
            </div>
          </li>
        </ul>
      </li>
    </xsl:if>
   
  </xsl:template>

  <xsl:template match="submenus/submenu[@type='list1']">
    <div class="megamenu-block animated fadeInLeft animated-2x">
      <h3 class="megamenu-block-title">
        <xsl:value-of select="caption/." />&#160;
      </h3>
      <ul class="megamenu-block-list">
        <xsl:apply-templates select="submenus/submenu[@type='itemlist1']" />&#160;
        
      
      </ul>
    </div>
  </xsl:template>

  <xsl:template match="submenus/submenu[@type='itemlist1']">
    <li>
      <a class="withripple" href="component-typography.html">
        <i class="fa fa-font"></i> <xsl:value-of select="caption/." />&#160;
      </a>
    </li>
  </xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:template match="/">
    <script>
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/assets/js/plugins.min.js');

      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/assets/js/app.min.js');

      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/assets/js/home-generic-6.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/assets/custom-me.js');
      
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
      <div class="ms-hero-page-override ms-hero-img-airplane ms-bg-fixed ms-hero-bg-dark-light">
        <div class="container">
          <div class="text-center">
            <h1 class="no-m ms-site-title color-white center-block ms-site-title-lg mt-2 animated zoomInDown animation-delay-5">Register</h1>
            <p class="lead lead-lg color-light text-center center-block mt-2 mw-800 text-uppercase fw-300 animated fadeInUp animation-delay-7">
              Do not wait more register now! Access our great community and benefit from
              <span class="color-info">exclusive membership</span> conditions.
            </p>
          </div>
        </div>
      </div>
      <!--this is Content-->
      <div class="container">
        <div class="card card-primary card-hero animated fadeInUp animation-delay-7">
          <div class="card-block" id="register_form">
            <script>
              LoadNewPartView('register_form', 'register_form', 'register', '00000000-0000-0000-0000-000000000000');
              
            </script>
            <form class="form-horizontal">
              <fieldset>
                <div class="form-group">
                  <label for="inputUser" class="col-md-2 control-label">Username</label>
                  <div class="col-md-9">
                    <input type="text" class="form-control" id="inputUser" placeholder="Username" /> 
                  </div>
                </div>
                <div class="row">
                  <div class="col-md-4 col-md-offset-8">
                    <button class="btn btn-raised btn-primary btn-block mt-4">Register Now</button>
                  </div>
                </div>
              </fieldset>
            </form>
          </div>
        </div>
      </div>
      
      <!--this is footer-->
      <footer class="ms-footer">
        <div class="container">
          <p>Copyright © OPERAHOUSE 2017</p>
        </div>
      </footer>
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

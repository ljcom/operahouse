<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  <xsl:output method="xml" indent="yes"/>
  <xsl:template match="/">
    <link rel="shortcut icon" href="assets/img/favicon.png?v=3"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
    <link rel="stylesheet" href="assets/css/preload.min.css" />
    <link rel="stylesheet" href="assets/css/plugins.min.css" />
    <link rel="stylesheet" href="assets/css/style.light-blue-500.min.css" />
    <link rel="stylesheet" href="assets/css/width-boxed.min.css" id="ms-boxed" disabled=""/>
    <!--[if lt IE 9]>
        <script src="assets/js/html5shiv.min.js"></script>
        <script src="assets/js/respond.min.js"></script>
    <![endif]-->
    <a href="javascript:void(0)" class="ms-conf-btn ms-configurator-btn btn-circle btn-circle-raised btn-circle-primary animated rubberBand">
      <ix class="fa fa-gears"></ix>
    </a>
    <div id="ms-configurator" class="ms-configurator">
      <div class="ms-configurator-title">
        <h3>
          <ix class="fa fa-gear"></ix> Theme Configurator
        </h3>
        <a href="javascript:void(0);" class="ms-conf-btn withripple">
          <ix class="zmdi zmdi-close"></ix>
        </a>
      </div>
      <div class="panel-group" id="accordion_conf" role="tablist" aria-multiselectable="true">
        <div class="panel panel-default">
          <div class="panel-heading" role="tab" id="ms-conf-header-color">
            <h4 class="panel-title">
              <a role="button" class="withripple" data-toggle="collapse" data-parent="#accordion_conf" href="#ms-collapse-conf-1" aria-expanded="true" aria-controls="ms-collapse-conf-1">
                <ix class="zmdi zmdi-invert-colors"></ix> Color Selector
              </a>
            </h4>
          </div>
          <div id="ms-collapse-conf-1" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="ms-conf-header-color">
            <div class="panel-body">
              <div id="color-options" class="ms-colors-container">
                <a href="javascript:void(0);" class="ms-color-box ms-color-box-primary red" data-color="red">red</a>
                <a href="javascript:void(0);" class="ms-color-box ms-color-box-primary pink" data-color="pink">pink</a>
                <a href="javascript:void(0);" class="ms-color-box ms-color-box-primary purple" data-color="purple">purple</a>
                <a href="javascript:void(0);" class="ms-color-box ms-color-box-primary deep-purple" data-color="deep-purple">deep-purple</a>
                <a href="javascript:void(0);" class="ms-color-box ms-color-box-primary indigo" data-color="indigo">indigo</a>
                <a href="javascript:void(0);" class="ms-color-box ms-color-box-primary blue" data-color="blue">blue</a>
                <a href="javascript:void(0);" class="ms-color-box ms-color-box-primary light-blue active" data-color="light-blue">light-blue</a>
                <a href="javascript:void(0);" class="ms-color-box ms-color-box-primary cyan" data-color="cyan">cyan</a>
                <a href="javascript:void(0);" class="ms-color-box ms-color-box-primary teal" data-color="teal">teal</a>
                <a href="javascript:void(0);" class="ms-color-box ms-color-box-primary green" data-color="green">green</a>
                <a href="javascript:void(0);" class="ms-color-box ms-color-box-primary light-green" data-color="light-green">light-green</a>
                <a href="javascript:void(0);" class="ms-color-box ms-color-box-primary lime" data-color="lime">lime</a>
                <a href="javascript:void(0);" class="ms-color-box ms-color-box-primary yellow" data-color="yellow">yellow</a>
                <a href="javascript:void(0);" class="ms-color-box ms-color-box-primary amber" data-color="amber">amber</a>
                <a href="javascript:void(0);" class="ms-color-box ms-color-box-primary orange" data-color="orange">orange</a>
                <a href="javascript:void(0);" class="ms-color-box ms-color-box-primary deep-orange" data-color="deep-orange">deep-orange</a>
                <a href="javascript:void(0);" class="ms-color-box ms-color-box-primary brown" data-color="brown">brown</a>
                <a href="javascript:void(0);" class="ms-color-box ms-color-box-primary grey" data-color="grey">grey</a>
                <a href="javascript:void(0);" class="ms-color-box ms-color-box-primary blue-grey" data-color="blue-grey">blue-grey</a>
              </div>
              <div id="grad-options" class="ms-color-shine">
                <h4 class="no-mb text-center">Color Brightness</h4>
                <span>300</span>
                <span>400</span>
                <span>500</span>
                <span>600</span>
                <span>700</span>
                <span>800</span>
                <a href="javascript:void(0)" data-shine="300" class="ms-color-box grad c300 light-blue">300</a>
                <a href="javascript:void(0)" data-shine="400" class="ms-color-box grad c400 light-blue">400</a>
                <a href="javascript:void(0)" data-shine="500" class="ms-color-box grad c500 light-blue active">500</a>
                <a href="javascript:void(0)" data-shine="600" class="ms-color-box grad c600 light-blue">600</a>
                <a href="javascript:void(0)" data-shine="700" class="ms-color-box grad c700 light-blue">700</a>
                <a href="javascript:void(0)" data-shine="800" class="ms-color-box grad c800 light-blue">800</a>
              </div>
            </div>
          </div>
        </div>
        <div class="panel panel-default">
          <div class="panel-heading" role="tab" id="ms-conf-header-headers">
            <h4 class="panel-title">
              <a class="collapsed withripple" role="button" data-toggle="collapse" data-parent="#accordion_conf" href="#ms-collapse-conf-2" aria-expanded="false" aria-controls="ms-collapse-conf-2">
                <ix class="zmdi zmdi-view-compact"></ix> Header Styles
              </a>
            </h4>
          </div>
          <div id="ms-collapse-conf-2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ms-conf-header-headers">
            <div class="panel-body">
              <!--<h5>Preset Options</h5>
                    <form class="form-inverse ms-conf-radio">
                        <div class="form-group">
                            <div class="radio radio-primary">
                                <label>
                                    <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked="">Default Style
                                </label>
                            </div>
                            <div class="radio radio-primary">
                                <label>
                                    <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">Pure Material
                                </label>
                            </div>
                            <div class="radio radio-primary">
                                <label>
                                    <input type="radio" name="optionsRadios" id="optionsRadios3" value="option3">Navbar Mode
                                </label>
                            </div>
                        </div>
                    </form>
                    <h5>Custom Header</h5>-->
              <h6>Header Options</h6>
              <form class="form-inverse ms-conf-radio" id="header-config">
                <div class="form-group">
                  <div class="radio radio-primary">
                    <label>
                      <input type="radio" name="customHeader" id="whiteHeader" value="white" checked="cheked" /> Light Color </label>
                  </div>
                  <div class="radio radio-primary">
                    <label>
                      <input type="radio" name="customHeader" id="primaryHeader" value="primary" /> Primary Color </label>
                  </div>
                  <div class="radio radio-primary">
                    <label>
                      <input type="radio" name="customHeader" id="darkHeader" value="dark"/> Dark Color </label>
                  </div>
                  <div class="radio radio-primary">
                    <label>
                      <input type="radio" name="customHeader" id="noHeader" value="hidden"/> No Header (Navbar Mode) </label>
                  </div>
                </div>
              </form>
              <h6>Navbar Options</h6>
              <form class="form-inverse ms-conf-radio" id="navbar-config">
                <div class="form-group">
                  <div class="radio radio-primary">
                    <label>
                      <input type="radio" name="customNavbar" id="whiteNavbar" value="white" checked=""/> Light Color </label>
                  </div>
                  <div class="radio radio-primary">
                    <label>
                      <input type="radio" name="customNavbar" id="primaryNavbar" value="primary"/> Primary Color </label>
                  </div>
                  <div class="radio radio-primary">
                    <label>
                      <input type="radio" name="customNavbar" id="darkNavbar" value="dark"/> Dark Color </label>
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>
        <div class="panel panel-default">
          <div class="panel-heading" role="tab" id="ms-conf-header-container">
            <h4 class="panel-title">
              <a class="collapsed withripple" role="button" data-toggle="collapse" data-parent="#accordion_conf" href="#ms-conf-collapse-3" aria-expanded="false" aria-controls="ms-conf-collapse-3">
                <ix class="zmdi zmdi-grid"></ix> Container Options
              </a>
            </h4>
          </div>
          <div id="ms-conf-collapse-3" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ms-conf-header-container">
            <div class="panel-body">
              <form class="form-inverse ms-conf-radio" id="boxed-config">
                <div class="form-group">
                  <div class="radio radio-primary">
                    <label>
                      <input type="radio" name="customWidth" id="fullWidth" value="full" checked="" /> Full Width </label>
                  </div>
                  <div class="radio radio-primary">
                    <label>
                      <input type="radio" name="customWidth" id="boxedWidth" value="boxed" /> Boxed Mode </label>
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div id="ms-preload" class="ms-preload">
      <div id="status">
        <div class="spinner">
          <div class="dot1"></div>
          <div class="dot2"></div>
        </div>
      </div>
    </div>
    <div class="bg-full-page bg-primary back-fixed">
      <div class="mw-500 absolute-center">
        <header class="text-center mb-2">
          <span class="logo-mini" style="font-size:9px; text-align:center">
            <img width="90" src="OPHContent/themes/{/sqroot/header/info/themeFolder}/images/oph4_logo.png" alt="Logo Image" />
          </span>
          <h1 class="no-m ms-site-title color-white center-block ms-site-title-lg mt-2 animated zoomInDown animation-delay-5">
            <span>
              OPERAHOUSE
            </span>
          </h1>
        </header>
        <script>
          $("#logoimg").attr("src","OPHContent/themes/"+loadThemeFolder()+"/images/oph4_logo.png");
        </script>
        <div class="card animated zoomInUp animation-delay-7 color-primary withripple">
          <div class="card-block">
            <div class="text-center color-dark">
              <h1 class="color-primary text-big">Coming Soon</h1>
              <div id="ms-countdown"></div>
              <p class="lead lead-sm">
                Wait our new website!
                <br/> Please leave your email, we will let you know...</p>
              <form>
                <div class="form-group label-floating mt-2 mb-1">
                  <div class="input-group center-block">
                    <label class="control-label" for="ms-subscribe">
                      <ix class="zmdi zmdi-email"></ix> Email Adress
                    </label>
                    <input type="email" id="ms-subscribe" class="form-control" /> </div>
                </div>
                <button class="btn btn-raised btn-primary btn-block" type="button">Subscribe</button>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script src="assets/js/plugins.min.js"></script>
    <script src="assets/js/app.min.js"></script>
    <script src="assets/js/configurator.min.js"></script>
    <script>
      (function(i, s, o, g, r, a, m)
      {
      i['GoogleAnalyticsObject'] = r;
      i[r] = i[r] || function()
      {
      (i[r].q = i[r].q || []).push(arguments)
      }, i[r].l = 1 * new Date();
      a = s.createElement(o),
      m = s.getElementsByTagName(o)[0];
      a.async = 1;
      a.src = g;
      m.parentNode.insertBefore(a, m)
      })(window, document, 'script', 'https://www.google-analytics.com/analytics.js', 'ga');
      ga('create', 'UA-90917746-1', 'auto');
      ga('send', 'pageview');
    </script>
    <script src="assets/js/coming.js"></script>
  </xsl:template>
</xsl:stylesheet>

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
      meta.content = "width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no";
      loadMeta(meta);

      $("body").addClass("skin-blue");
      $("body").addClass("hold-transition");
      $("body").addClass("sidebar-mini");
      $("body").addClass("fixed");

      <!--loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/bootstrap/css/bootstrap.min.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/styles/font-awesome-4.7.0/css/font-awesome.min.css');

      //loadStyle('https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/daterangepicker/daterangepicker.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/datepicker/datepicker3.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/iCheck/all.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/colorpicker/bootstrap-colorpicker.min.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/timepicker/bootstrap-timepicker.min.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/select2/select2.min.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/admin-LTE/css/AdminLTE.min.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/admin-LTE/css/skins/_all-skins.min.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/styles/custom-me.css');

      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/jQuery/jquery-2.2.3.min.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/bootstrap/js/bootstrap.min.js');
      --><!--loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/select2/select2.full.min.js');--><!--
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/input-mask/jquery.inputmask.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/input-mask/jquery.inputmask.date.extensions.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/input-mask/jquery.inputmask.extensions.js');
      loadScript('https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js');

      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/datepicker/bootstrap-datepicker.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/colorpicker/bootstrap-colorpicker.min.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/timepicker/bootstrap-timepicker.min.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/slimScroll/jquery.slimscroll.min.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/iCheck/icheck.min.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/fastclick/fastclick.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/admin-LTE/js/demo.js');-->
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/admin-LTE/js/app.min.js');

      document.title='Page Not Found';

      resetBrowseCookies();
      //loadContent(1);
    </script>
    <!-- Page script -->

    <header class="main-header">
      <!-- Logo -->
      <a href="javascript:goHome();" class="logo visible-phone" style="text-align:left;">
        <!-- mini logo for sidebar mini 50x50 pixels -->
        <span class="logo-mini" style="font-size:9px; text-align:center">
          <img width="30" src="OPHContent/themes/{/sqroot/header/info/themeFolder}/images/oph4_logo.png" alt="Logo Image" />
        </span>
        <!-- logo for regular state and mobile devices -->
        <span class="logo-lg" style="font-size:22px;">
          <div class="pull-left" style="margin-right:10px;">
            <img width="30" style="margin-top:-9px;" src="OPHContent/themes/{/sqroot/header/info/themeFolder}/images/oph4_logo.png" alt="Logo Image" />
          </div>
          <xsl:value-of select="sqroot/header/info/account/." />
        </span>
      </a>
      <!-- Header Navbar: style can be found in header.less -->
      <nav class="navbar navbar-static-top">
        <!-- Sidebar toggle button-->
        <a href="#" class="sidebar-toggle visible-phone" data-toggle="offcanvas" role="button" >
          <span class="sr-only">Toggle navigation</span>
        </a>
        <div id ="button-menu-phone" class="unvisible-phone" style="color:white;  margin:0; display:inline-table; margin-top:15px; margin-left:10px" data-toggle="collapse" data-target="#mobilemenupanel">
          <a href="#" style="color:white;">
            <span>
              <img width="30" style="margin-top:-9px;" src="OPHContent/themes/{/sqroot/header/info/themeFolder}/images/oph4_logo.png" alt="Logo Image" />
            </span>&#160;
            <xsl:value-of select="sqroot/header/info/code/name"/>&#160;(<xsl:value-of select="sqroot/header/info/code/id"/>)<span class="caret"></span>
          </a>
        </div>
        <div class="accordian-body collapse top-menu-div" id="mobilemenupanel"
        style="color:white; position:absolute; background:#222D32; z-index:100; width:100%; right:0px; top:50px; ">

          <form action="#" method="get" class="sidebar-form">
            <div class="input-group">
              <input type="text" name="q" class="form-control" placeholder="Search..." />
              <span class="input-group-btn">
                <button type="submit" name="search" id="search-btn" class="btn btn-flat">
                  <ix class="fa fa-search" aria-hidden="true"></ix>
                </button>
              </span>
            </div>
          </form>
          <div class="panel-group" id="accordion2">
            <div class="panel top-menu-onphone" style="border-radius:0; margin-top:0;">
              <a class="top-envi" data-toggle="collapse" data-parent="#accordion2" href="#collapse1a">
                Inventory <span class="caret"></span>
              </a>
              <div id="collapse1a" class="panel-collapse collapse">
                <ul>
                  <li>
                    <a href="browse.html">Consigment P &#038; D</a>
                  </li>
                  <li>
                    <a href="browse.html">Direct P &#038; D</a>
                  </li>
                  <li>
                    <a href="browse.html">PR\PVL Purchase</a>
                  </li>
                  <li>
                    <a href="browse.html">Product Request</a>
                  </li>
                  <li>
                    <a href="browse.html">Product Return</a>
                  </li>
                  <li>
                    <a href="browse.html">PKSP</a>
                  </li>
                  <li>
                    <a href="browse.html">Dumping of Stocks Authorization Form (DOSA)</a>
                  </li>
                  <li>
                    <a href="browse.html">Stock Adjustment</a>
                  </li>
                </ul>
              </div>
            </div>
            <div class="panel top-menu-onphone" style="border-radius:0; margin-top:0;">
              <a class="top-envi" data-toggle="collapse" data-parent="#accordion2" href="#collapse2a">
                HRD <span class="caret"></span>
              </a>
              <div id="collapse2a" class="panel-collapse collapse">
                <ul>
                  <li>
                    <a href="browse.html">Request for Recruitment (HRRR)</a>
                  </li>
                  <li>
                    <a href="browse.html">Recruitment Confirmation Form (HRRC)</a>
                  </li>
                  <li>
                    <a href="browse.html">Employee Change Notice (HRCH)</a>
                  </li>
                  <li>
                    <a href="browse.html">Training Authorization Form (HRTR)</a>
                  </li>
                  <li>
                    <a href="browse.html">Employee Departure Approval Form (HRDP)</a>
                  </li>
                  <li>
                    <a href="browse.html">Personal Probationary Period Assessment Form (HRPA)</a>
                  </li>
                  <li>
                    <a href="browse.html">Personal Data Changes Form (HRDC)</a>
                  </li>
                  <li>
                    <a href="browse.html">Probationary Validate Form (HRVL)</a>
                  </li>
                  <li>
                    <a href="browse.html">Staff Sales Process (STAF)</a>
                  </li>
                  <li>
                    <a href="browse.html">Incentive Form (HRIC)</a>
                  </li>
                  <li>
                    <a href="browse.html">Contact Reminder (HRCR)</a>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
        <div class="navbar-custom-menu">
          <ul class="nav navbar-nav">
            <li>
              <a href="#" id="button-menu-phone2" data-toggle="collapse" data-target="#right-menu-phone" class="unvisible-phone">
                <ix class="fa fa-list"></ix>
              </a>
            </li>
            <div class="collapse top-menu-div" id="right-menu-phone"
            style="color:white; position:absolute; background:#222D32; z-index:90; width:100%; right:0px; top:50px; ">
              <ul>
                <xsl:apply-templates select="sqroot/header/menus/menu[@code='primary']" />
              </ul>
            </div>
            <!-- Dashboard -->

            <xsl:if test="count(sqroot/header/info/user/userName)=0">
              <li>
                <a href="#" data-toggle="modal" data-target="#login-modal">
                  <span>
                    <ix class="fa fa-sign-in"></ix>&#160;
                  </span>
                  <span>Sign in</span>
                </a>
              </li>
            </xsl:if>

            <li class="dropdown messages-menu visible-phone" style="margin-right:20px;">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" title="User Setting">
                Welcome, <b>
                  <xsl:value-of select="sqroot/header/info/user/userName" />
                </b><span style="margin-right:10px;"></span>&#160;<ix class="fa fa-user"></ix>
                <!-- <span class="label label-success">4</span> -->
              </a>
              <ul class="dropdown-menu" style="border:none; border-radius:0px;" id="dropdown-top">
                <!-- <li class="header" style="background:#367FAA; color:white; text-align:right; border-radius:0; padding:10px 10px;">Welcome, <b>Administrator</b></li>
              <li> -->
                <!-- inner menu: contains the actual data -->
                <!--<ul class="user-setting-menu" id="right-menu-phone1">-->
                <li>
                  <!-- start message -->
                  <!--<span style="color:white">Act as :</span>-->
                  <a href="ophcore/api/default.aspx?mode=signout">
                    <span>
                      <ix class="fa fa-power-off"></ix>
                    </span> Sign out
                  </a>
                </li>
                <!--<xsl:apply-templates select="sqroot/header/menus/menu[@code='primary']" />-->

              </ul>
            </li>
            <!-- Control Sidebar Toggle Button -->

          </ul>
        </div>
      </nav>
    </header>

    <!-- *** LOGIN MODAL ***
_________________________________________________________ -->

    <div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="signinLabel" aria-hidden="true">
      <div class="modal-dialog modal-sm" role="document">

        <div class="modal-content">
          <form id="signinForm" method="post">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&#215;</button>
              <h4 class="modal-title" id="signinLabel">Sign in</h4>
            </div>

            <div class="modal-body">
              <div class="form-group">
                <input type="text" class="form-control" id="userid" placeholder="user id" />
              </div>
              <div class="form-group">
                <input type="password" class="form-control" id="pwd" placeholder="password" />
              </div>

              <p class="text-center text-muted">Not registered yet?</p>
              <p class="text-center text-muted">
                <a href="customer-register.html">
                  <strong>Register now</strong>
                </a>! It is easy and done in 1&#160;minute and gives you access to special discounts and much more!
              </p>

            </div>
            <div class="modal-footer">

              <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
              <a href="javascript: signIn();">
                <button type="button" class="btn btn-primary">
                  <span>
                    <ix class="fa fa-sign-in"></ix>&#160;
                  </span>Sign In
                </button>
              </a>

            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- *** LOGIN MODAL END *** -->

    <!-- Left side column. contains the logo and sidebar -->
    <aside  class="main-sidebar">
      <!-- sidebar: style can be found in sidebar.less -->
      <section id="sidebarWrapper" class="sidebar">


      </section>

      <!-- /.sidebar -->
    </aside>
    <!-- Content Wrapper. Contains page content -->
    <div id="contentWrapper" class="content-wrapper" style="background:white">
      <section class="content-header">
        <h1>
          404 Error Page
        </h1>
        <ol class="breadcrumb">
          <li>
            <a href="#">
              <ix class="fa fa-dashboard"></ix> Home
            </a>
          </li>
          <li>
            <a href="#">Examples</a>
          </li>
          <li class="active">404 error</li>
        </ol>
      </section>

      <!-- Main content -->
      <section class="content">
        <div class="error-page">
          <h2 class="headline text-yellow"> 404</h2>

          <div class="error-content">
            <h3>
              <span><ix class="fa fa-warning text-yellow"></ix>
              </span> Oops! Page not found.
            </h3>

            <p>
              We could not find the page you were looking for.
              Meanwhile, you may <a href="javascript:goHome()">return to dashboard</a> or try using the search form.
            </p>

            <form class="search-form">
              <div class="input-group">
                <input type="text" name="search" class="form-control" placeholder="Search"/>

                  <div class="input-group-btn">
                    <button type="submit" name="submit" class="btn btn-warning btn-flat">
                      <ix class="fa fa-search"></ix>
                    </button>
                  </div>
                </div>
              <!-- /.input-group -->
            </form>
          </div>
          <!-- /.error-content -->
        </div>
        <!-- /.error-page -->
      </section>
    </div>
    <!-- /.content-wrapper -->
    <footer class="main-footer">
      <div class="pull-right hidden-xs">
        <b>Version</b> 4.0
      </div>
      <strong>
        Copyright &#169; 2017 <a href="#">Operahouse</a>.
      </strong> All rights reserved.
    </footer>

    <!-- Control Sidebar -->
    <aside class="control-sidebar control-sidebar-dark">
      <!-- Create the tabs -->
      <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
        <li>
          <a href="#control-sidebar-home-tab" data-toggle="tab">
            <ix class="fa fa-home"></ix>
          </a>
        </li>
        <li>
          <a href="#control-sidebar-settings-tab" data-toggle="tab">
            <ix class="fa fa-gears"></ix>
          </a>
        </li>
      </ul>

    </aside>
    <!-- /.control-sidebar -->
    <!-- Add the sidebar's background. This div must be placed
       immediately after the control sidebar -->
    <div class="control-sidebar-bg"></div>

    <!-- ./wrapper -->
    <script>
      $(document).ready(function(){
      $("#button-menu-phone").click(function(){
      $('#right-menu-phone').removeClass("in");

      });
      $("#button-menu-phone2").click(function(){
      $('#mobilemenupanel').removeClass("in");


      });
      $('.expand-td').click(function(){
      var target = $(this).attr('data-target');
      // alert(target);
      var ids = $('.browse-data').map(function() {
      var id = this.id;
      if ('#'+id != target){
      // alert(id);
      $('#'+id).attr('class', 'browse-data accordian-body collapse');
      }
      // this.id.removeClass(in)
      // alert(this.id);
      })

      // alert(ids); // Result: a,b,c,d
      });
      });
    </script>

  </xsl:template>

  <xsl:template match="sqroot/header/menus/menu[@code='primary']/submenus/submenu/submenus/submenu">
    <li>
      <a href="{pageURL/.}">
        <xsl:value-of select="caption/." />
      </a>
    </li>
  </xsl:template>



</xsl:stylesheet>

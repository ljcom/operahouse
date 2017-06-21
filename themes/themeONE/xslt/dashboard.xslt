<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
  <xsl:variable name="colMenu">
    <xsl:choose>
      <xsl:when test="count(sqroot/header/menus/menu[@code='primaryback']/submenus/submenu)=0">12</xsl:when>
      <xsl:when test="count(sqroot/header/menus/menu[@code='primaryback']/submenus/submenu)=1">12</xsl:when>
      <xsl:when test="count(sqroot/header/menus/menu[@code='primaryback']/submenus/submenu)=2">6</xsl:when>
      <xsl:otherwise>4</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:template match="/">
    <div style="display:none" id="pageName">&#xA0;</div>
    <div style="display:none" id="themeName">&#xA0;</div>

    <script>
      <!-- Ionicons -->
      loadStyle('https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css');
      <!-- Morris chart -->
      //loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/morris/morris.css');
      <!-- jvectormap -->
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/jvectormap/jquery-jvectormap-1.2.2.css');
      <!-- Daterange picker -->
      //loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/daterangepicker/daterangepicker.css');
      <!-- bootstrap wysihtml5 - text editor -->
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css');

      <!--loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/bootstrap/css/bootstrap.min.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/styles/font-awesome-4.7.0/css/font-awesome.min.css');

      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/daterangepicker/daterangepicker.css');

      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/datepicker/datepicker3.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/iCheck/all.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/colorpicker/bootstrap-colorpicker.min.css');
      //loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/loopj-jquery-tokeninput/styles/token-input-facebook.css');
      //loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/loopj-jquery-tokeninput/styles/token-input-mac.css');

      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/timepicker/bootstrap-timepicker.min.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/select2/select2.min.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/admin-LTE/css/AdminLTE.min.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/admin-LTE/css/skins/_all-skins.min.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/styles/custom-me.css');

      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/jQuery/jquery-2.2.3.min.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/bootstrap/js/bootstrap.min.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/input-mask/jquery.inputmask.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/input-mask/jquery.inputmask.date.extensions.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/input-mask/jquery.inputmask.extensions.js');
      loadScript('https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js');

      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/datepicker/bootstrap-datepicker.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/colorpicker/bootstrap-colorpicker.min.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/timepicker/bootstrap-timepicker.min.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/loopj-jquery-tokeninput/src/jquery.tokeninput.js');

      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/slimScroll/jquery.slimscroll.min.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/iCheck/icheck.min.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/fastclick/fastclick.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/upclick/upclick-min.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/custom-me.js');-->



      <!-- jQuery UI 1.11.4 -->
      loadScript('https://code.jquery.com/ui/1.11.4/jquery-ui.min.js');
      <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
      <!-- Morris.js charts -->
      //loadScript('https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js');
      //loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/morris/morris.min.js');
      loadScript('OPHContent/themes/themeONE/scripts/chartjs/Chart.bundle.js');
      <!-- Sparkline -->
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/sparkline/jquery.sparkline.min.js');
      <!-- jvectormap -->
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/jvectormap/jquery-jvectormap-1.2.2.min.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/jvectormap/jquery-jvectormap-world-mill-en.js');
      <!-- jQuery Knob Chart -->
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/knob/jquery.knob.js');
      <!-- daterangepicker -->
      loadScript('https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js');
      //loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/daterangepicker/daterangepicker.js');
      <!-- datepicker -->
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/datepicker/bootstrap-datepicker.js');
      <!-- Bootstrap WYSIHTML5 -->
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js');
      <!-- Slimscroll -->
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/slimScroll/jquery.slimscroll.min.js');
      <!-- FastClick -->
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/fastclick/fastclick.js');
      <!-- AdminLTE App -->
      //loadScript('dist/js/adminlte.min.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/admin-LTE/js/app.min.js');

      <!--$.widget.bridge('uibutton', $.ui.button);-->

      document.getElementById("pageName").innerHTML = getCookie('page');
      document.getElementById("themeName").innerHTML = getCookie('themeFolder');

      document.title='<xsl:value-of select="/sqroot/header/info/title"/>';

      //resetBrowseCookies();

      loadDashboard();

      setCookie('userURL', '<xsl:value-of select="sqroot/header/info/user/userURL"/>', 7);
      setCookie('userName', '<xsl:value-of select="sqroot/header/info/user/userName"/>', 7);
      setCookie('userId', '<xsl:value-of select="sqroot/header/info/user/userId"/>', 7);

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
          <xsl:value-of select="sqroot/header/info/account" />
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
            <xsl:apply-templates select="sqroot/header/menus/menu[@code='sidebar']/submenus/submenu" />
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
            <xsl:choose>
              <xsl:when test="sqroot/header/info/user/userId=''">
                <li>
                  <a href="#" data-toggle="modal" data-target="#login-modal">
                    <span>
                      <ix class="fa fa-sign-in"></ix>&#160;
                    </span>
                    <span>Sign in</span>
                  </a>
                </li>
              </xsl:when>
              <xsl:otherwise>
                <li class="dropdown user user-menu">
                  <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    <img src="OPHContent/{sqroot/header/info/user/userURL}" class="user-image" alt="User Image"/>
                    <span class="hidden-xs">
                      <xsl:value-of select="sqroot/header/info/user/userName"/>
                    </span>
                  </a>
                  <ul class="dropdown-menu">
                    <!-- User image -->
                    <li class="user-header">
                      <img src="OPHContent/{sqroot/header/info/user/userURL}" class="img-circle" alt="User Image"/>

                      <p>
                        <xsl:value-of select="sqroot/header/info/user/userName"/> - Web Developer
                        <small>Member since Nov. 2012</small>
                      </p>
                    </li>
                    <!-- Menu Body -->
                    <li class="user-body">
                      <div class="row">
                        <xsl:apply-templates select="sqroot/header/menus/menu[@code='primaryback']/submenus/submenu" />
                       
                      </div>
                      <!-- /.row -->
                    </li>
                    <!-- Menu Footer-->
                    <li class="user-footer">
                      <div class="pull-left">
                        <a href="?code=profile" class="btn btn-default btn-flat">
                          <span>
                            <ix class="fa fa-user"></ix>
                          </span>&#160;Profile
                        </a>
                      </div>
                      <div class="pull-right">
                        <a href="javascript:signOut()" class="btn btn-default btn-flat">
                          <span>
                            <ix class="fa fa-power-off"></ix>
                          </span>&#160;Sign out
                        </a>
                      </div>
                    </li>
                  </ul>
                </li>
              </xsl:otherwise>
            </xsl:choose>
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
                    <ix class="fa fa-sign-in"></ix>
                  </span>&#160;Sign In
                </button>
              </a>

            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- *** LOGIN MODAL END *** -->
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
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div>
        </div>

      </div>
    </div>
    <!-- *** NOTIFICATION MODAL END -->

    <!-- Left side column. contains the logo and sidebar -->
    <aside  class="main-sidebar">
      <!-- sidebar: style can be found in sidebar.less -->
      <section id="sidebarWrapper" class="sidebar">
        <script>
          $("#searchBox").val(getSearchText());
          var c=getQueryVariable('code');
          try {
          $($('.treeview').children().find('a[href$="'+c+'"]')[0].parentNode.parentNode.parentNode.parentNode.parentNode).addClass('active');
          $($('.treeview').children().find('a[href$="'+c+'"]')[0].parentNode.parentNode.parentNode).addClass('active');
          $($('.treeview').children().find('a[href$="'+c+'"]')[0].parentNode).addClass('active');
          } catch(e) {}
        </script>
        <!-- search form -->
        <!--<form method="get" class="sidebar-form">-->
        <div class="user-panel">
          <div class="pull-left image">
            <img src="OPHContent/{sqroot/header/info/user/userURL}" class="img-circle" alt="User Image" />
          </div>
          <div class="pull-left info">
            <p>
              <xsl:value-of select="sqroot/header/info/user/userName"/>
            </p>
            <a href="#">
              <ix class="fa fa-circle text-success"></ix> Online
            </a>
          </div>
        </div>
        <div class="input-group sidebar-form">
          <input type="text" id="searchBox" name="searchBox" class="form-control" placeholder="Search..." onkeypress="return searchText(event,this.value);" value="" />
          <span class="input-group-btn">
            <button type="submit" name="search" id="search-btn" class="btn btn-flat">
              <ix class="fa fa-search" aria-hidden="true"></ix>
            </button>
          </span>
        </div>
        <!--</form>-->
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu">
          <xsl:apply-templates select="sqroot/header/menus/menu[@code='sidebar']/submenus/submenu[@type='label']" />
        </ul>

      </section>

      <!-- /.sidebar -->
    </aside>
    <!-- Content Wrapper. Contains page content -->
    <div id="contentWrapper" class="content-wrapper">
      &#160;
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
    <div class="control-sidebar-bg">&#160;</div>

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


  <xsl:template match="sqroot/header/menus/menu[@code='primaryback']/submenus/submenu[@type='label']">
    <div class="col-xs-{$colMenu} text-center">
      <a href="{pageURL/.}">
        <xsl:value-of select="caption/." />&#160;
      </a>
    </div>
  </xsl:template>



  <xsl:template match="sqroot/header/menus/menu[@code='sidebar']/submenus/submenu[@type='label']">
    <li>
        <a href="{pageURL/.}">
          <xsl:if test="(icon/fa/.)!=''">
            <span>
              <ix class="fa {icon/fa/.}"></ix>&#160;
            </span>
          </xsl:if>
          <span>
            <xsl:value-of select="caption/." />
          </span>
        </a>
      </li>

  </xsl:template>

</xsl:stylesheet>

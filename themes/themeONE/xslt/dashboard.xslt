<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
  <xsl:variable name="colMenu">
    <xsl:choose>
      <xsl:when test="count(/sqroot/header/menus/menu[@code='primaryback']/submenus/submenu)=0">12</xsl:when>
      <xsl:when test="count(/sqroot/header/menus/menu[@code='primaryback']/submenus/submenu)=1">12</xsl:when>
      <xsl:when test="count(/sqroot/header/menus/menu[@code='primaryback']/submenus/submenu)=2">6</xsl:when>
      <xsl:otherwise>4</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:template match="/">
    <div style="display:none" id="pageName">&#xA0;</div>
    <div style="display:none" id="themeName">&#xA0;</div>

    <script>
      Sideshow.config.language = "oph";
      Sideshow.init();

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

      changeSkinColor();
      $("body").addClass("hold-transition");
      $("body").addClass("sidebar-mini");
      $("body").addClass("fixed");


      <!-- Ionicons -->
      loadStyle('https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css');
      <!-- Morris chart -->
      //loadStyle('OPHContent/cdn/morris/morris.css');
      <!-- jvectormap -->
      loadStyle('OPHContent/cdn/jvectormap/jquery-jvectormap-1.2.2.css');
      <!-- Daterange picker -->
      //loadStyle('OPHContent/cdn/daterangepicker/daterangepicker.css');
      <!-- bootstrap wysihtml5 - text editor -->
      loadStyle('OPHContent/cdn/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css');

      <!-- jQuery UI 1.11.4 -->
      loadScript('https://code.jquery.com/ui/1.11.4/jquery-ui.min.js');
      <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
      <!-- Morris.js charts -->
      //loadScript('https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js');
      //loadScript('OPHContent/cdn/morris/morris.min.js');
      loadScript('OPHContent/cdn/chartjs/Chart.bundle.js');
      <!-- Sparkline -->
      loadScript('OPHContent/cdn/sparkline/jquery.sparkline.min.js');
      <!-- jvectormap -->
      loadScript('OPHContent/cdn/jvectormap/jquery-jvectormap-1.2.2.min.js');
      loadScript('OPHContent/cdn/jvectormap/jquery-jvectormap-world-mill-en.js');
      <!-- jQuery Knob Chart -->
      loadScript('OPHContent/cdn/knob/jquery.knob.js');
      <!-- daterangepicker -->
      loadScript('OPHContent/cdn/moment/moment.min.js');
      //loadScript('OPHContent/cdn/daterangepicker/daterangepicker.js');
      <!-- datepicker -->
      loadScript('OPHContent/cdn/datepicker/bootstrap-datepicker.js');
      <!-- Bootstrap WYSIHTML5 -->
      loadScript('OPHContent/cdn/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js');
      <!-- Slimscroll -->
      loadScript('OPHContent/cdn/slimScroll/jquery.slimscroll.min.js');
      <!-- FastClick -->
      loadScript('OPHContent/cdn/fastclick/fastclick.js');
      <!-- AdminLTE App -->
      //loadScript('dist/js/adminlte.min.js');
      loadScript('OPHContent/cdn/admin-LTE/js/app.min.js');

      <!--$.widget.bridge('uibutton', $.ui.button);-->

      document.getElementById("pageName").innerHTML = getCookie('page');
      document.getElementById("themeName").innerHTML = getCookie('themeFolder');

      document.title='<xsl:value-of select="/sqroot/header/info/title"/>';

      //resetBrowseCookies();

      loadDashboard();

      setCookie('userURL', 'OPHContent/documents/<xsl:value-of select="sqroot/header/info/account" />/<xsl:value-of select="sqroot/header/info/user/userURL"/>', 7);
      setCookie('userName', '<xsl:value-of select="sqroot/header/info/user/userName"/>', 7);
      //setCookie('userId', '<xsl:value-of select="sqroot/header/info/user/userId"/>', 7);

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
        <div class="accordian-body collapse top-menu-div" id="mobilemenupanel" style="color:white; position:absolute; background:#222D32; z-index:100; width:100%; right:0px; top:50px; ">
          <div class="input-group sidebar-form">
            <!--<input type="text" id="searchBox" name="searchBox" class="form-control" placeholder="Search..." onkeypress="return searchText(event,this.value);" value="" />-->
            <span class="input-group-btn">
              <button type="button" name="search" id="search-btn" class="btn btn-flat" onclick="searchText(event);">
                <ix class="fa fa-search" aria-hidden="true"></ix>
              </button>
            </span>
          </div>
          <div class="panel-group" id="accordion2">
            <xsl:apply-templates select="sqroot/header/menus/menu[@code='sidebar']/submenus/submenu" />
          </div>
        </div>
        <div class="navbar-custom-menu">
          <ul class="nav navbar-nav">
            <li>
              <a style="cursor:pointer;" onclick="Sideshow.start();" data-toggle="tooltip" data-placement="bottom" title="Help?">
                <ix class="fa fa-question-circle fa-lg"></ix>
              </a>
            </li>
            <li class="dropdown user user-menu">
              <xsl:choose>
                <xsl:when test="not(sqroot/header/info/user/userId)">
                  <a href="#" data-toggle="modal" data-target="#login-modal">
                    <span>
                      <ix class="fa fa-sign-in"></ix>&#160;
                    </span>
                    <span>Sign in</span>
                  </a>
                </xsl:when>
                <xsl:otherwise>
                  <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
                    <img src="OPHContent/documents/{sqroot/header/info/account}/{sqroot/header/info/user/userURL}" class="user-image" alt="User Image"/>
                    <span class="hidden-xs">
                      <xsl:value-of select="sqroot/header/info/user/userName"/>
                    </span>
                  </a>
                  <ul class="dropdown-menu">
                    <!-- User image -->
                    <li class="user-header">
                      <img src="OPHContent/documents/{sqroot/header/info/account}/{sqroot/header/info/user/userURL}" class="img-circle" alt="User Image"/>
                      <p>
                        <xsl:value-of select="sqroot/header/info/user/userName"/>
                        <small>
                          Active since <xsl:value-of select="sqroot/header/info/user/dateCreate"/>
                        </small>
                      </p>
                    </li>
                    <!-- Menu Body -->
                    <li class="user-body">
                      <div class="row">
                        <xsl:for-each select="sqroot/header/menus/menu[@code='primaryback']/submenus/submenu">
                          <div class="col-xs-{$colMenu} text-center">
                            <a href="{pageURL}">
                              <xsl:value-of select="caption" />&#160;
                            </a>
                          </div>
                        </xsl:for-each>
                        <!--<xsl:apply-templates select="sqroot/header/menus/menu[@code='primaryback']/submenus/submenu" />-->
                      </div>
                    </li>
                    <!-- Menu Footer-->
                    <li class="user-footer">
                      <div class="pull-left">
                        <a href="?code=profile" class="btn btn-default btn-flat">
                          <ix class="fa fa-user"></ix>&#160;Profile
                        </a>
                      </div>
                      <div class="pull-right">
                        <a href="javascript:signOut()" class="btn btn-default btn-flat">
                          <ix class="fa fa-power-off"></ix>&#160;Sign out
                        </a>
                      </div>
                    </li>
                  </ul>
                </xsl:otherwise>
              </xsl:choose>
            </li>
          </ul>
        </div>
      </nav>
    </header>

    <!-- *** LOGIN MODAL ***-->
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
      <section id="sidebarWrapper" class="sidebar">
        <div class="overlay">
          <ix class="fa fa-refresh fa-spin"></ix>
        </div>
      </section>
    </aside>

    <div id="contentWrapper" class="content-wrapper">
      &#160;
    </div>

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

  <xsl:template match="sqroot/header/menus/menu[@code='sidebar']/submenus/submenu">
    <div class="panel top-menu-onphone">
      <a class="top-envi" data-toggle="collapse" data-parent="#accordion2" href="#{@idMenu}">
        <xsl:value-of select="caption/." />&#160;<span class="caret"></span>
      </a>
      <div id="{@idMenu}" class="panel-collapse collapse">
        <ul class="treeview">
          <xsl:if test="(@type)='treeroot'">
            <xsl:apply-templates select="submenus/submenu[@type='treeview']" />&#160;
            <xsl:apply-templates select="submenus/submenu[@type='label']" />&#160;
          </xsl:if>
        </ul>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="sqroot/header/menus/menu[@code='sidebar']/submenus/submenu[@type='treeview']">
    <li>
      <a data-toggle="collapse" data-parent="#accordion{../../@GUID}" href="#{@idMenu}">
        <xsl:value-of select="caption/." />
      </a>
      <div id="{@idMenu}" class="panel-collapse collapse">
        <ul class="panel-group">
          <xsl:apply-templates select="submenus/submenu[@type='treeview']" />&#160;
          <xsl:apply-templates select="submenus/submenu[@type='label']" />&#160;
        </ul>
      </div>
    </li>
  </xsl:template>

  <xsl:template match="submenus/submenu[@type='treeview']">
    <li>
      <a data-toggle="collapse" data-parent="#accordion{../../@GUID}" href="#{@idMenu}">
        <xsl:value-of select="caption/." />
        &#160;
        <span class="caret"></span>
      </a>
      <div id="{@idMenu}" class="panel-collapse collapse">
        <ul class="panel-group">
          <xsl:apply-templates select="submenus/submenu[@type='treeview']" />&#160;
          <xsl:apply-templates select="submenus/submenu[@type='label']" />&#160;
        </ul>
      </div>
    </li>
  </xsl:template>

  <xsl:template match="submenus/submenu[@type='label']">
    <a href="{pageURL/.}" class="top-envi">
      <xsl:value-of select="caption/." />
      &#160;
      <xsl:if test="isPending &gt; 0">
        <ix class="fa fa-asterisk" aria-hidden="true" style="font-size: 8px; position:absolute"></ix>
      </xsl:if>
    </a>
  </xsl:template>

</xsl:stylesheet>

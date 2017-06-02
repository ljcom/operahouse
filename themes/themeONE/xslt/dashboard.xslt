<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
  <xsl:variable name="nbAccountMenu">
    <xsl:choose>
      <xsl:when test="count(sqroot/header/menus/menu[@code='primaryback']/submenus/submenu)>0">
        <xsl:value-of select="12 div count(sqroot/header/menus/menu[@code='primaryback']/submenus/submenu)" />
      </xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>

  </xsl:variable>
  <xsl:template match="/">
    <div style="display:none" id="pageName">&#xA0;</div>
    <div style="display:none" id="themeName">&#xA0;</div>

    <script>
      <!-- Ionicons -->
      loadStyle('https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css');
      <!-- Morris chart -->
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/morris/morris.css');
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
      loadScript('https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/morris/morris.min.js');
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
              <xsl:when test="count(sqroot/header/menus/menu[@code='primaryback']/submenus/submenu)=0">
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
                    <img src="OPHContent/themes/themeONE/images/user2-160x160.jpg" class="user-image" alt="User Image"/>
                    <span class="hidden-xs">
                      <xsl:value-of select="sqroot/header/info/user/userName"/>
                    </span>
                  </a>
                  <ul class="dropdown-menu">
                    <!-- User image -->
                    <li class="user-header">
                      <img src="OPHContent/themes/themeONE/images/user2-160x160.jpg" class="img-circle" alt="User Image"/>

                      <p>
                        <xsl:value-of select="sqroot/header/info/user/userName"/> - Web Developer
                        <small>Member since Nov. 2012</small>
                      </p>
                    </li>
                    <!-- Menu Body -->
                    <li class="user-body">
                      <div class="row">
                        <div class="col-xs-4 text-center">
                          <a href="?code=dashboard">Dashboard</a>
                        </div>
                        <div class="col-xs-4 text-center">
                          <a href="?env=acct">Account</a>
                        </div>
                        <div class="col-xs-4 text-center">
                          <a href="?env=dev">Dev</a>
                        </div>
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
            <img src="OPHContent/themes/themeONE/images/user2-160x160.jpg" class="img-circle" alt="User Image" />
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
          <xsl:apply-templates select="sqroot/header/menus/menu[@code='sidebar']/submenus/submenu" />
        </ul>

      </section>

      <!-- /.sidebar -->
    </aside>
    <!-- Content Wrapper. Contains page content -->
    <div id="contentWrapper" class="content-wrapper">
      <!-- Content Header (Page header) -->
      <section class="content-header">
        <h1>
          Dashboard
          <small>Control panel</small>
        </h1>
        <ol class="breadcrumb">
          <li>
            <a href="#">
              <span>
                <ix class="fa fa-dashboard"></ix>
              </span>&#160;Home
            </a>
          </li>
          <li class="active">Dashboard</li>
        </ol>
      </section>

      <!-- Main content -->
      <section class="content">
        <!-- Small boxes (Stat box) -->
        <div class="row">
          <div class="col-lg-6 col-xs-6">
            <!-- small box -->
            <div class="small-box bg-aqua">
              <div class="inner">
                <h3>150</h3>

                <p>New Orders</p>
              </div>
              <div class="icon">
                <ix class="ion ion-bag"></ix>
              </div>
              <a href="#" class="small-box-footer">
                More info <span>
                  <ix class="fa fa-arrow-circle-right"></ix>
                </span>
              </a>
            </div>
          </div>
          <!-- ./col -->
          <div class="col-lg-6 col-xs-6">
            <!-- small box -->
            <div class="small-box bg-green">
              <div class="inner">
                <h3>
                  53<sup style="font-size: 20px">%</sup>
                </h3>

                <p>Bounce Rate</p>
              </div>
              <div class="icon">
                <ix class="ion ion-stats-bars"></ix>
              </div>
              <a href="#" class="small-box-footer">
                More info <span>
                  <ix class="fa fa-arrow-circle-right"></ix>
                </span>
              </a>
            </div>
          </div>
          <!-- ./col -->
          <div class="col-lg-6 col-xs-6">
            <!-- small box -->
            <div class="small-box bg-yellow">
              <div class="inner">
                <h3>44</h3>

                <p>User Registrations</p>
              </div>
              <div class="icon">
                <ix class="ion ion-person-add"></ix>
              </div>
              <a href="#" class="small-box-footer">
                More info <span>
                  <ix class="fa fa-arrow-circle-right"></ix>
                </span>
              </a>
            </div>
          </div>
          <!-- ./col -->
          <div class="col-lg-6 col-xs-6">
            <!-- small box -->
            <div class="small-box bg-red">
              <div class="inner">
                <h3>65</h3>

                <p>Unique Visitors</p>
              </div>
              <div class="icon">
                <ix class="ion ion-pie-graph"></ix>
              </div>
              <a href="#" class="small-box-footer">
                More info <span>
                  <ix class="fa fa-arrow-circle-right"></ix>
                </span>
              </a>
            </div>
          </div>
          <!-- ./col -->
        </div>
        <!-- /.row -->
        <!-- Main row -->
        <div class="row">
          <!-- Left col -->
          <section class="col-lg-7 connectedSortable">
            <!-- Custom tabs (Charts with tabs)-->
            <div class="nav-tabs-custom">
              <!-- Tabs within a box -->
              <ul class="nav nav-tabs pull-right">
                <li class="active">
                  <a href="#revenue-chart" data-toggle="tab">Area</a>
                </li>
                <li>
                  <a href="#sales-chart" data-toggle="tab">Donut</a>
                </li>
                <li class="pull-left header">
                  <span>
                    <ix class="fa fa-inbox"></ix>
                  </span>&#160;Sales
                </li>
              </ul>
              <div class="tab-content no-padding">
                <!-- Morris chart - Sales -->
                <div class="chart tab-pane active" id="revenue-chart" style="position: relative; height: 300px;">&#160;</div>
                <div class="chart tab-pane" id="sales-chart" style="position: relative; height: 300px;">&#160;</div>
              </div>
            </div>
            <!-- /.nav-tabs-custom -->

            <!-- Chat box -->
            <div class="box box-success">
              <div class="box-header">
                <span>
                  <ix class="fa fa-comments-o"></ix>
                </span>&#160;

                <h3 class="box-title">Chat</h3>

                <div class="box-tools pull-right" data-toggle="tooltip" title="Status">
                  <div class="btn-group" data-toggle="btn-toggle">
                    <button type="button" class="btn btn-default btn-sm active">
                      <ix class="fa fa-square text-green"></ix>
                    </button>
                    <button type="button" class="btn btn-default btn-sm">
                      <ix class="fa fa-square text-red"></ix>
                    </button>
                  </div>
                </div>
              </div>
              <div class="box-body chat" id="chat-box">
                <!-- chat item -->
                <div class="item">
                  <img src="dist/img/user4-128x128.jpg" alt="user image" class="online"/>

                  <p class="message">
                    <a href="#" class="name">
                      <small class="text-muted pull-right">
                        <span>
                          <ix class="fa fa-clock-o"></ix>
                        </span> 2:15
                      </small>
                      Mike Doe
                    </a>
                    I would like to meet you to discuss the latest news about
                    the arrival of the new theme. They say it is going to be one the
                    best themes on the market
                  </p>
                  <div class="attachment">
                    <h4>Attachments:</h4>

                    <p class="filename">
                      Theme-thumbnail-image.jpg
                    </p>

                    <div class="pull-right">
                      <button type="button" class="btn btn-primary btn-sm btn-flat">Open</button>
                    </div>
                  </div>
                  <!-- /.attachment -->
                </div>
                <!-- /.item -->
                <!-- chat item -->
                <div class="item">
                  <img src="dist/img/user3-128x128.jpg" alt="user image" class="offline"/>

                  <p class="message">
                    <a href="#" class="name">
                      <small class="text-muted pull-right">
                        <span>
                          <ix class="fa fa-clock-o"></ix>
                        </span> 5:15
                      </small>
                      Alexander Pierce
                    </a>
                    I would like to meet you to discuss the latest news about
                    the arrival of the new theme. They say it is going to be one the
                    best themes on the market
                  </p>
                </div>
                <!-- /.item -->
                <!-- chat item -->
                <div class="item">
                  <img src="dist/img/user2-160x160.jpg" alt="user image" class="offline"/>

                  <p class="message">
                    <a href="#" class="name">
                      <small class="text-muted pull-right">
                        <span>
                          <ix class="fa fa-clock-o"></ix>
                        </span> 5:30
                      </small>
                      Susan Doe
                    </a>
                    I would like to meet you to discuss the latest news about
                    the arrival of the new theme. They say it is going to be one the
                    best themes on the market
                  </p>
                </div>
                <!-- /.item -->
              </div>
              <!-- /.chat -->
              <div class="box-footer">
                <div class="input-group">
                  <input class="form-control" placeholder="Type message..."/>

                  <div class="input-group-btn">
                    <button type="button" class="btn btn-success">
                      <ix class="fa fa-plus"></ix>
                    </button>
                  </div>
                </div>
              </div>
            </div>
            <!-- /.box (chat box) -->

            <!-- TO DO List -->
            <div class="box box-primary">
              <div class="box-header">
                <span>
                  <ix class="ion ion-clipboard"></ix>
                </span>&#160;

                <h3 class="box-title">To Do List</h3>

                <div class="box-tools pull-right">
                  <ul class="pagination pagination-sm inline">
                    <li>
                      <a href="#">&#171;</a>
                    </li>
                    <li>
                      <a href="#">1</a>
                    </li>
                    <li>
                      <a href="#">2</a>
                    </li>
                    <li>
                      <a href="#">3</a>
                    </li>
                    <li>
                      <a href="#">&#187;</a>
                    </li>
                  </ul>
                </div>
              </div>
              <!-- /.box-header -->
              <div class="box-body">
                <!-- See dist/js/pages/dashboard.js to activate the todoList plugin -->
                <ul class="todo-list">
                  <li>
                    <!-- drag handle -->
                    <span class="handle">
                      <ix class="fa fa-ellipsis-v"></ix>
                      <ix class="fa fa-ellipsis-v"></ix>
                    </span>
                    <!-- checkbox -->
                    <input type="checkbox" value=""/>
                    <!-- todo text -->
                    <span class="text">Design a nice theme</span>
                    <!-- Emphasis label -->
                    <small class="label label-danger">
                      <span>
                        <ix class="fa fa-clock-o"></ix>
                      </span> 2 mins
                    </small>
                    <!-- General tools such as edit or delete-->
                    <div class="tools">
                      <ix class="fa fa-edit"></ix>
                      <ix class="fa fa-trash-o"></ix>
                    </div>
                  </li>
                  <li>
                    <span class="handle">
                      <ix class="fa fa-ellipsis-v"></ix>
                      <ix class="fa fa-ellipsis-v"></ix>
                    </span>
                    <input type="checkbox" value=""/>
                    <span class="text">Make the theme responsive</span>
                    <small class="label label-info">
                      <span>
                        <ix class="fa fa-clock-o"></ix>
                      </span> 4 hours
                    </small>
                    <div class="tools">
                      <ix class="fa fa-edit"></ix>
                      <ix class="fa fa-trash-o"></ix>
                    </div>
                  </li>
                  <li>
                    <span class="handle">
                      <ix class="fa fa-ellipsis-v"></ix>
                      <ix class="fa fa-ellipsis-v"></ix>
                    </span>
                    <input type="checkbox" value=""/>
                    <span class="text">Let theme shine like a star</span>
                    <small class="label label-warning">
                      <span>
                        <ix class="fa fa-clock-o"></ix>
                      </span> 1 day
                    </small>
                    <div class="tools">
                      <ix class="fa fa-edit"></ix>
                      <ix class="fa fa-trash-o"></ix>
                    </div>
                  </li>
                  <li>
                    <span class="handle">
                      <ix class="fa fa-ellipsis-v"></ix>
                      <ix class="fa fa-ellipsis-v"></ix>
                    </span>
                    <input type="checkbox" value=""/>
                    <span class="text">Let theme shine like a star</span>
                    <small class="label label-success">
                      <span>
                        <ix class="fa fa-clock-o"></ix>
                      </span> 3 days
                    </small>
                    <div class="tools">
                      <ix class="fa fa-edit"></ix>
                      <ix class="fa fa-trash-o"></ix>
                    </div>
                  </li>
                  <li>
                    <span class="handle">
                      <ix class="fa fa-ellipsis-v"></ix>
                      <ix class="fa fa-ellipsis-v"></ix>
                    </span>
                    <input type="checkbox" value=""/>
                    <span class="text">Check your messages and notifications</span>
                    <small class="label label-primary">
                      <span>
                        <ix class="fa fa-clock-o"></ix>
                      </span> 1 week
                    </small>
                    <div class="tools">
                      <ix class="fa fa-edit"></ix>
                      <ix class="fa fa-trash-o"></ix>
                    </div>
                  </li>
                  <li>
                    <span class="handle">
                      <ix class="fa fa-ellipsis-v"></ix>
                      <ix class="fa fa-ellipsis-v"></ix>
                    </span>
                    <input type="checkbox" value=""/>
                    <span class="text">Let theme shine like a star</span>
                    <small class="label label-default">
                      <span>
                        <ix class="fa fa-clock-o"></ix>
                      </span> 1 month
                    </small>
                    <div class="tools">
                      <ix class="fa fa-edit"></ix>
                      <ix class="fa fa-trash-o"></ix>
                    </div>
                  </li>
                </ul>
              </div>
              <!-- /.box-body -->
              <div class="box-footer clearfix no-border">
                <button type="button" class="btn btn-default pull-right">
                  <span>
                    <ix class="fa fa-plus"></ix>
                  </span> Add item
                </button>
              </div>
            </div>
            <!-- /.box -->

            <!-- quick email widget -->
            <div class="box box-info">
              <div class="box-header">
                <span>
                  <ix class="fa fa-envelope"></ix>
                </span>&#160;

                <h3 class="box-title">Quick Email</h3>
                <!-- tools box -->
                <div class="pull-right box-tools">
                  <button type="button" class="btn btn-info btn-sm" data-widget="remove" data-toggle="tooltip"
                          title="Remove">
                    <ix class="fa fa-times"></ix>
                  </button>
                </div>
                <!-- /. tools -->
              </div>
              <div class="box-body">
                <form action="#" method="post">
                  <div class="form-group">
                    <input type="email" class="form-control" name="emailto" placeholder="Email to:"/>
                  </div>
                  <div class="form-group">
                    <input type="text" class="form-control" name="subject" placeholder="Subject"/>
                  </div>
                  <div>
                    <textarea class="textarea" placeholder="Message"
                              style="width: 100%; height: 125px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;">&#160;</textarea>
                    <script>$('.textarea').val('');</script>
                  </div>
                </form>
              </div>
              <div class="box-footer clearfix">
                <button type="button" class="pull-right btn btn-default" id="sendEmail">
                  Send
                  <ix class="fa fa-arrow-circle-right"></ix>
                </button>
              </div>
            </div>

          </section>
          <!-- /.Left col -->
          <!-- right col (We are only adding the ID to make the widgets sortable)-->
          <section class="col-lg-5 connectedSortable">

            <!-- Map box -->
            <div class="box box-solid bg-light-blue-gradient">
              <div class="box-header">
                <!-- tools box -->
                <div class="pull-right box-tools">
                  <button type="button" class="btn btn-primary btn-sm daterange pull-right" data-toggle="tooltip"
                          title="Date range">
                    <ix class="fa fa-calendar"></ix>
                  </button>
                  <button type="button" class="btn btn-primary btn-sm pull-right" data-widget="collapse"
                          data-toggle="tooltip" title="Collapse" style="margin-right: 5px;">
                    <ix class="fa fa-minus"></ix>
                  </button>
                </div>
                <!-- /. tools -->

                <ix class="fa fa-map-marker"></ix>

                <h3 class="box-title">
                  Visitors
                </h3>
              </div>
              <div class="box-body">
                <div id="world-map" style="height: 250px; width: 100%;">&#160;</div>
              </div>
              <!-- /.box-body-->
              <div class="box-footer no-border">
                <div class="row">
                  <div class="col-xs-4 text-center" style="border-right: 1px solid #f4f4f4">
                    <div id="sparkline-1">&#160;</div>
                    <div class="knob-label">Visitors</div>
                  </div>
                  <!-- ./col -->
                  <div class="col-xs-4 text-center" style="border-right: 1px solid #f4f4f4">
                    <div id="sparkline-2">&#160;</div>
                    <div class="knob-label">Online</div>
                  </div>
                  <!-- ./col -->
                  <div class="col-xs-4 text-center">
                    <div id="sparkline-3">&#160;</div>
                    <div class="knob-label">Exists</div>
                  </div>
                  <!-- ./col -->
                </div>
                <!-- /.row -->
              </div>
            </div>
            <!-- /.box -->

            <!-- solid sales graph -->
            <div class="box box-solid bg-teal-gradient">
              <div class="box-header">
                <span>
                  <ix class="fa fa-th"></ix>
                </span>&#160;
                <h3 class="box-title">Sales Graph</h3>

                <div class="box-tools pull-right">
                  <button type="button" class="btn bg-teal btn-sm" data-widget="collapse">
                    <ix class="fa fa-minus"></ix>
                  </button>
                  <button type="button" class="btn bg-teal btn-sm" data-widget="remove">
                    <ix class="fa fa-times"></ix>
                  </button>
                </div>
              </div>
              <div class="box-body border-radius-none">
                <div class="chart" id="line-chart" style="height: 250px;">&#160;</div>
              </div>
              <!-- /.box-body -->
              <div class="box-footer no-border">
                <div class="row">
                  <div class="col-xs-4 text-center" style="border-right: 1px solid #f4f4f4">
                    <input type="text" class="knob" data-readonly="true" value="20" data-width="60" data-height="60"
                           data-fgColor="#39CCCC"/>

                    <div class="knob-label">Mail-Orders</div>
                  </div>
                  <!-- ./col -->
                  <div class="col-xs-4 text-center" style="border-right: 1px solid #f4f4f4">
                    <input type="text" class="knob" data-readonly="true" value="50" data-width="60" data-height="60"
                           data-fgColor="#39CCCC"/>

                    <div class="knob-label">Online</div>
                  </div>
                  <!-- ./col -->
                  <div class="col-xs-4 text-center">
                    <input type="text" class="knob" data-readonly="true" value="30" data-width="60" data-height="60"
                           data-fgColor="#39CCCC"/>

                    <div class="knob-label">In-Store</div>
                  </div>
                  <!-- ./col -->
                </div>
                <!-- /.row -->
              </div>
              <!-- /.box-footer -->
            </div>
            <!-- /.box -->

            <!-- Calendar -->
            <div class="box box-solid bg-green-gradient">
              <div class="box-header">
                <span>
                  <ix class="fa fa-calendar"></ix>
                </span>&#160;

                <h3 class="box-title">Calendar</h3>
                <!-- tools box -->
                <div class="pull-right box-tools">
                  <!-- button with a dropdown -->
                  <div class="btn-group">
                    <button type="button" class="btn btn-success btn-sm dropdown-toggle" data-toggle="dropdown">
                      <ix class="fa fa-bars"></ix>
                    </button>
                    <ul class="dropdown-menu pull-right" role="menu">
                      <li>
                        <a href="#">Add new event</a>
                      </li>
                      <li>
                        <a href="#">Clear events</a>
                      </li>
                      <li class="divider"></li>
                      <li>
                        <a href="#">View calendar</a>
                      </li>
                    </ul>
                  </div>&#160;
                  <button type="button" class="btn btn-success btn-sm" data-widget="collapse">
                    <ix class="fa fa-minus"></ix>
                  </button>&#160;
                  <button type="button" class="btn btn-success btn-sm" data-widget="remove">
                    <ix class="fa fa-times"></ix>
                  </button>
                </div>
                <!-- /. tools -->
              </div>
              <!-- /.box-header -->
              <div class="box-body no-padding">
                <!--The calendar -->
                <div id="calendar" style="width: 100%">&#160;</div>
              </div>
              <!-- /.box-body -->
              <div class="box-footer text-black">
                <div class="row">
                  <div class="col-sm-6">
                    <!-- Progress bars -->
                    <div class="clearfix">
                      <span class="pull-left">Task #1</span>
                      <small class="pull-right">90%</small>
                    </div>
                    <div class="progress xs">
                      <div class="progress-bar progress-bar-green" style="width: 90%;">&#160;</div>
                    </div>

                    <div class="clearfix">
                      <span class="pull-left">Task #2</span>
                      <small class="pull-right">70%</small>
                    </div>
                    <div class="progress xs">
                      <div class="progress-bar progress-bar-green" style="width: 70%;">&#160;</div>
                    </div>
                  </div>
                  <!-- /.col -->
                  <div class="col-sm-6">
                    <div class="clearfix">
                      <span class="pull-left">Task #3</span>
                      <small class="pull-right">60%</small>
                    </div>
                    <div class="progress xs">
                      <div class="progress-bar progress-bar-green" style="width: 60%;">&#160;</div>
                    </div>

                    <div class="clearfix">
                      <span class="pull-left">Task #4</span>
                      <small class="pull-right">40%</small>
                    </div>
                    <div class="progress xs">
                      <div class="progress-bar progress-bar-green" style="width: 40%;">&#160;</div>
                    </div>
                  </div>
                  <!-- /.col -->
                </div>
                <!-- /.row -->
              </div>
            </div>
            <!-- /.box -->

          </section>
          <!-- right col -->
        </div>
        <!-- /.row (main row) -->

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

  <xsl:template match="sqroot/header/menus/menu[@code='primaryback']/submenus/submenu">
    <div class="col-xs-{$nbAccountMenu} text-center">
      <a href="{pageURL/.}">
        <xsl:value-of select="caption/." />
      </a>
    </div>
  </xsl:template>



  <xsl:template match="sqroot/header/menus/menu[@code='sidebar']/submenus/submenu">
    <div class="panel top-menu-onphone" style="border-radius:0; margin-top:0;">
      <a class="top-envi" data-toggle="collapse" data-parent="#accordion2" href="#collapse{@GUID}">
        <xsl:value-of select="caption/." />&#160;<span class="caret"></span>
      </a>
      <div id="collapse{@GUID}" class="panel-collapse collapse">
        <ul class="panel-group" id="accordion{@GUID}">
          <xsl:if test="(@type)='treeroot'">
            <xsl:apply-templates select="submenus/submenu[@type='treeview']" />&#160;
            <xsl:apply-templates select="submenus/submenu[@type='label']" />&#160;
          </xsl:if>
        </ul>
      </div>
    </div>
  </xsl:template>
  <xsl:template match="submenus/submenu[@type='treeview']">
    <li>
      <a data-toggle="collapse" data-parent="#accordion{../../@GUID}" href="#collapse{@GUID}">
        <xsl:value-of select="caption/." />
      </a>
      <div id="collapse{@GUID}" class="panel-collapse collapse">
        <ul class="panel-group" id="accordion{@GUID}">
          <xsl:apply-templates select="submenus/submenu[@type='treeview']" />&#160;
          <xsl:apply-templates select="submenus/submenu[@type='label']" />&#160;
        </ul>
      </div>
    </li>
  </xsl:template>
  <xsl:template match="submenus/submenu[@type='label']">
    <li>
      <a href="{pageURL/.}">
        <xsl:value-of select="caption/." />
      </a>
    </li>
  </xsl:template>

  <xsl:template match="sqroot/header/menus/menu[@code='sidebar']/submenus/submenu">
    <xsl:variable name="className">
      <xsl:choose>
        <xsl:when test="(@type)='treeroot'">treeview main-menu-a</xsl:when>
        <xsl:when test="(@type)='label'">header</xsl:when>
      </xsl:choose>
    </xsl:variable>

    <li class="{$className}">
      <xsl:choose>
        <xsl:when test="(pageURL/.)!=''">
          <a href="{pageURL/.}">
            <xsl:if test="(icon/fa/.)!=''">
              <span>
                <ix class="fa {icon/fa/.}"></ix>&#160;
              </span>
            </xsl:if>
            <span>
              <xsl:value-of select="caption/." />
            </span>
            <xsl:if test="(@type)='treeroot'">
              <span class="pull-right-container">
                <ix class="fa fa-angle-left pull-right"></ix>
              </span>
            </xsl:if>
          </a>
          <xsl:if test="(@type)='treeroot'">
            <ul class="treeview-menu browse-left-sidebar">
              <xsl:apply-templates select="submenus/submenu[@type='treeview']" />&#160;
              <xsl:apply-templates select="submenus/submenu[@type='label']" />&#160;
            </ul>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="caption/." />&#160;
        </xsl:otherwise>
      </xsl:choose>
    </li>

  </xsl:template>

  <xsl:template match="submenus/submenu[@type='treeview']">
    <li class="treeview">
      <a href="{pageURL/.}">
        <span>
          <xsl:if test="(icon/fa/.)!=''">
            <ix class="fa {icon/fa/.}"></ix>&#160;
          </xsl:if>
          <xsl:value-of select="caption/." />&#160;
        </span>
        <span class="pull-right-container">
          <ix class="fa fa-angle-left pull-right"></ix>
        </span>
      </a>
      <ul class="treeview-menu browse-left-sidebar" >
        <xsl:apply-templates select="submenus/submenu[@type='treeview']" />&#160;
        <xsl:apply-templates select="submenus/submenu[@type='label']" />&#160;
      </ul>
    </li>

  </xsl:template>

  <xsl:template match="submenus/submenu[@type='label']">
    <script>//label</script>
    <li>
      <a href="{pageURL/.}">
        <span>
          <xsl:if test="(icon/fa/.)!=''">
            <ix class="fa {icon/fa/.}"></ix>&#160;
          </xsl:if>
          <xsl:value-of select="caption/." />&#160;
        </span>
      </a>
    </li>
  </xsl:template>
</xsl:stylesheet>

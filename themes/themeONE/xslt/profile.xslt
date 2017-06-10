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
    <script>
      
      loadScript('OPHContent/themes/themeONE/scripts/admin-LTE/js/app.min.js');

      //loadContent();
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
                <xsl:apply-templates select="sqroot/header/menus/menu[@code='primaryback']" />
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
                    <img src="OPHContent/themes/themeONE/images/user2-160x160.jpg" class="user-image" alt="User Image"/>
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
          <xsl:apply-templates select="sqroot/header/menus/menu[@code='sidebar']/submenus/submenu" />
        </ul>

      </section>


      <!-- /.sidebar -->
    </aside>
    <!-- Content Wrapper. Contains page content -->
    <div id="contentWrapper" class="content-wrapper">
      <section class="content-header">
        <h1>
          User Profile
        </h1>
        <ol class="breadcrumb">
          <li>
            <a href="#">
              <span>
                <ix class="fa fa-dashboard"></ix>
              </span> Home
            </a>
          </li>
          <li>
            <a href="#">Account</a>
          </li>
          <li class="active">User profile</li>
        </ol>
      </section>

      <!-- Main content -->
      <section class="content">

        <div class="row">
          <div class="col-md-3">

            <!-- Profile Image -->
            <div class="box box-primary">
              <div class="box-body box-profile">
                <img class="profile-user-img img-responsive img-circle" src="OPHContent/{sqroot/header/info/user/userURL}" alt="User profile picture"/>

                <h3 class="profile-username text-center">
                  <xsl:value-of select="sqroot/header/info/user/userName"/>
                </h3>

                <p class="text-muted text-center">Software Engineer</p>

                <ul class="list-group list-group-unbordered">
                  <li class="list-group-item">
                    <b>Followers</b>
                    <a class="pull-right">1,322</a>
                  </li>
                  <li class="list-group-item">
                    <b>Following</b>
                    <a class="pull-right">543</a>
                  </li>
                  <li class="list-group-item">
                    <b>Friends</b>
                    <a class="pull-right">13,287</a>
                  </li>
                </ul>

                <a href="#" class="btn btn-primary btn-block">
                  <b>Follow</b>
                </a>
              </div>
              <!-- /.box-body -->
            </div>
            <!-- /.box -->

            <!-- About Me Box -->
            <div class="box box-primary">
              <div class="box-header with-border">
                <h3 class="box-title">About Me</h3>
              </div>
              <!-- /.box-header -->
              <div class="box-body">
                <strong>
                  <span>
                    <ix class="fa fa-book margin-r-5"></ix>
                  </span> Education
                </strong>

                <p class="text-muted">
                  B.S. in Computer Science from the University of Tennessee at Knoxville
                </p>

                <hr/>

                <strong>
                  <span>
                    <ix class="fa fa-map-marker margin-r-5"></ix>
                  </span> Location
                </strong>

                <p class="text-muted">Malibu, California</p>

                <hr/>

                <strong>
                  <span>
                    <ix class="fa fa-pencil margin-r-5"></ix>
                  </span> Skills
                </strong>

                <p>
                  <span class="label label-danger">UI Design</span>
                  <span class="label label-success">Coding</span>
                  <span class="label label-info">Javascript</span>
                  <span class="label label-warning">PHP</span>
                  <span class="label label-primary">Node.js</span>
                </p>

                <hr/>

                <strong>
                  <span>
                    <ix class="fa fa-file-text-o margin-r-5"></ix>
                  </span> Notes
                </strong>

                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam fermentum enim neque.</p>
              </div>
              <!-- /.box-body -->
            </div>
            <!-- /.box -->
          </div>
          <!-- /.col -->
          <div class="col-md-9">
            <div class="nav-tabs-custom">
              <ul class="nav nav-tabs">
                <li class="active">
                  <a href="#activity" data-toggle="tab">Activity</a>
                </li>
                <li>
                  <a href="#timeline" data-toggle="tab">Timeline</a>
                </li>
                <li>
                  <a href="#settings" data-toggle="tab">Settings</a>
                </li>
              </ul>
              <div class="tab-content">
                <div class="active tab-pane" id="activity">
                  <!-- Post -->
                  <div class="post">
                    <div class="user-block">
                      <img class="img-circle img-bordered-sm" src="../../dist/img/user1-128x128.jpg" alt="user image"/>
                      <span class="username">
                        <a href="#">Jonathan Burke Jr.</a>
                        <a href="#" class="pull-right btn-box-tool">
                          <ix class="fa fa-times"></ix>
                        </a>
                      </span>
                      <span class="description">Shared publicly - 7:30 PM today</span>
                    </div>
                    <!-- /.user-block -->
                    <p>
                      Lorem ipsum represents a long-held tradition for designers,
                      typographers and the like. Some people hate it and argue for
                      its demise, but others ignore the hate as they create awesome
                      tools to help create filler text for everyone from bacon lovers
                      to Charlie Sheen fans.
                    </p>
                    <ul class="list-inline">
                      <li>
                        <a href="#" class="link-black text-sm">
                          <span>
                            <ix class="fa fa-share margin-r-5"></ix>
                          </span> Share
                        </a>
                      </li>
                      <li>
                        <a href="#" class="link-black text-sm">
                          <span>
                            <ix class="fa fa-thumbs-o-up margin-r-5"></ix>
                          </span> Like
                        </a>
                      </li>
                      <li class="pull-right">
                        <a href="#" class="link-black text-sm">
                          <span>
                            <ix class="fa fa-comments-o margin-r-5"></ix>
                          </span> Comments
                          (5)
                        </a>
                      </li>
                    </ul>

                    <input class="form-control input-sm" type="text" placeholder="Type a comment"/>
                  </div>
                  <!-- /.post -->

                  <!-- Post -->
                  <div class="post clearfix">
                    <div class="user-block">
                      <img class="img-circle img-bordered-sm" src="../../dist/img/user7-128x128.jpg" alt="User Image"/>
                      <span class="username">
                        <a href="#">Sarah Ross</a>
                        <a href="#" class="pull-right btn-box-tool">
                          <ix class="fa fa-times"></ix>
                        </a>
                      </span>
                      <span class="description">Sent you a message - 3 days ago</span>
                    </div>
                    <!-- /.user-block -->
                    <p>
                      Lorem ipsum represents a long-held tradition for designers,
                      typographers and the like. Some people hate it and argue for
                      its demise, but others ignore the hate as they create awesome
                      tools to help create filler text for everyone from bacon lovers
                      to Charlie Sheen fans.
                    </p>

                    <form class="form-horizontal">
                      <div class="form-group margin-bottom-none">
                        <div class="col-sm-9">
                          <input class="form-control input-sm" placeholder="Response"/>
                        </div>
                        <div class="col-sm-3">
                          <button type="submit" class="btn btn-danger pull-right btn-block btn-sm">Send</button>
                        </div>
                      </div>
                    </form>
                  </div>
                  <!-- /.post -->

                  <!-- Post -->
                  <div class="post">
                    <div class="user-block">
                      <img class="img-circle img-bordered-sm" src="../../dist/img/user6-128x128.jpg" alt="User Image"/>
                      <span class="username">
                        <a href="#">Adam Jones</a>
                        <a href="#" class="pull-right btn-box-tool">
                          <ix class="fa fa-times"></ix>
                        </a>
                      </span>
                      <span class="description">Posted 5 photos - 5 days ago</span>
                    </div>
                    <!-- /.user-block -->
                    <div class="row margin-bottom">
                      <div class="col-sm-6">
                        <img class="img-responsive" src="../../dist/img/photo1.png" alt="Photo"/>
                      </div>
                      <!-- /.col -->
                      <div class="col-sm-6">
                        <div class="row">
                          <div class="col-sm-6">
                            <img class="img-responsive" src="../../dist/img/photo2.png" alt="Photo"/>
                            <br/>
                            <img class="img-responsive" src="../../dist/img/photo3.jpg" alt="Photo"/>
                          </div>
                          <!-- /.col -->
                          <div class="col-sm-6">
                            <img class="img-responsive" src="../../dist/img/photo4.jpg" alt="Photo"/>
                            <br/>
                            <img class="img-responsive" src="../../dist/img/photo1.png" alt="Photo"/>
                          </div>
                          <!-- /.col -->
                        </div>
                        <!-- /.row -->
                      </div>
                      <!-- /.col -->
                    </div>
                    <!-- /.row -->

                    <ul class="list-inline">
                      <li>
                        <a href="#" class="link-black text-sm">
                          <span>
                            <ix class="fa fa-share margin-r-5"></ix>
                          </span> Share
                        </a>
                      </li>
                      <li>
                        <a href="#" class="link-black text-sm">
                          <span>
                            <ix class="fa fa-thumbs-o-up margin-r-5"></ix>
                          </span> Like
                        </a>
                      </li>
                      <li class="pull-right">
                        <a href="#" class="link-black text-sm">
                          <span>
                            <ix class="fa fa-comments-o margin-r-5"></ix>
                          </span> Comments
                          (5)
                        </a>
                      </li>
                    </ul>

                    <input class="form-control input-sm" type="text" placeholder="Type a comment"/>
                  </div>
                  <!-- /.post -->
                </div>
                <!-- /.tab-pane -->
                <div class="tab-pane" id="timeline">
                  <!-- The timeline -->
                  <ul class="timeline timeline-inverse">
                    <!-- timeline time label -->
                    <li class="time-label">
                      <span class="bg-red">
                        10 Feb. 2014
                      </span>
                    </li>
                    <!-- /.timeline-label -->
                    <!-- timeline item -->
                    <li>
                      <ix class="fa fa-envelope bg-blue"></ix>
                    </li>
                    <li>
                      <div class="timeline-item">
                        <span class="time">
                          <span>
                            <ix class="fa fa-clock-o"></ix>
                          </span> 12:05
                        </span>

                        <h3 class="timeline-header">
                          <a href="#">Support Team</a> sent you an email
                        </h3>

                        <div class="timeline-body">
                          Etsy doostang zoodles disqus groupon greplin oooj voxy zoodles,
                          weebly ning heekya handango imeem plugg dopplr jibjab, movity
                          jajah plickers sifteo edmodo ifttt zimbra. Babblely odeo kaboodle
                          quora plaxo ideeli hulu weebly balihoo...
                        </div>
                        <div class="timeline-footer">
                          <a class="btn btn-primary btn-xs">Read more</a>
                          <a class="btn btn-danger btn-xs">Delete</a>
                        </div>
                      </div>
                    </li>
                    <!-- END timeline item -->
                    <!-- timeline item -->
                    <li>
                      <ix class="fa fa-user bg-aqua"></ix>
                    </li>
                    <li>
                      <div class="timeline-item">
                        <span class="time">
                          <span>
                            <ix class="fa fa-clock-o"></ix>
                          </span> 5 mins ago
                        </span>
                        <span>

                        </span>

                        <h3 class="timeline-header no-border">
                          <a href="#">Sarah Young</a> accepted your friend request
                        </h3>
                      </div>
                    </li>
                    <!-- END timeline item -->
                    <!-- timeline item -->
                    <li>
                      <ix class="fa fa-comments bg-yellow"></ix>
                    </li>
                    <li>
                      <div class="timeline-item">
                        <span class="time">
                          <span>
                            <ix class="fa fa-clock-o"></ix>
                          </span> 27 mins ago
                        </span>
                        <span>

                        </span>

                        <h3 class="timeline-header">
                          <a href="#">Jay White</a> commented on your post
                        </h3>

                        <div class="timeline-body">
                          Take me to your leader!
                          Switzerland is small and neutral!
                          We are more like Germany, ambitious and misunderstood!
                        </div>
                        <div class="timeline-footer">
                          <a class="btn btn-warning btn-flat btn-xs">View comment</a>
                        </div>
                      </div>
                    </li>
                    <!-- END timeline item -->
                    <!-- timeline time label -->
                    <li class="time-label">
                      <span class="bg-green">
                        3 Jan. 2014
                      </span>
                    </li>
                    <!-- /.timeline-label -->
                    <!-- timeline item -->
                    <li>
                      <ix class="fa fa-camera bg-purple"></ix>
                    </li>
                    <li>
                      <div class="timeline-item">
                        <span class="time">
                          <span>
                            <span>
                              <ix class="fa fa-clock-o"></ix>
                            </span> 2 days ago
                          </span>
                        </span>


                        <h3 class="timeline-header">
                          <a href="#">Mina Lee</a> uploaded new photos
                        </h3>

                        <div class="timeline-body">
                          <img src="http://placehold.it/150x100" alt="..." class="margin"/>
                          <img src="http://placehold.it/150x100" alt="..." class="margin"/>
                          <img src="http://placehold.it/150x100" alt="..." class="margin"/>
                          <img src="http://placehold.it/150x100" alt="..." class="margin"/>
                        </div>
                      </div>
                    </li>
                    <!-- END timeline item -->
                    <li>
                      <ix class="fa fa-clock-o bg-gray"></ix>
                    </li>
                  </ul>
                </div>
                <!-- /.tab-pane -->

                <div class="tab-pane" id="settings">
                  <form class="form-horizontal">
                    <div class="form-group">
                      <label for="inputName" class="col-sm-2 control-label">Name</label>

                      <div class="col-sm-10">
                        <input type="email" class="form-control" id="inputName" placeholder="Name"/>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputEmail" class="col-sm-2 control-label">Email</label>

                      <div class="col-sm-10">
                        <input type="email" class="form-control" id="inputEmail" placeholder="Email"/>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputName" class="col-sm-2 control-label">Name</label>

                      <div class="col-sm-10">
                        <input type="text" class="form-control" id="inputName" placeholder="Name"/>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputExperience" class="col-sm-2 control-label">Experience</label>

                      <div class="col-sm-10">
                        <textarea class="form-control" id="inputExperience" placeholder="Experience">&#160;</textarea>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputSkills" class="col-sm-2 control-label">Skills</label>

                      <div class="col-sm-10">
                        <input type="text" class="form-control" id="inputSkills" placeholder="Skills"/>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="col-sm-offset-2 col-sm-10">
                        <div class="checkbox">
                          <label>
                            <input type="checkbox"/>
                            I agree to the <a href="#">terms and conditions</a>
                          </label>
                        </div>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="col-sm-offset-2 col-sm-10">
                        <button type="submit" class="btn btn-danger">Submit</button>
                      </div>
                    </div>
                  </form>
                </div>
                <!-- /.tab-pane -->
              </div>
              <!-- /.tab-content -->
            </div>
            <!-- /.nav-tabs-custom -->
          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->

      </section>
    </div>
    <!-- /.content-wrapper -->
    <footer class="main-footer">
      <div class="pull-right hidden-xs">
        <b>Version</b> 4.0
      </div>
      <strong>
        Copyright &#169; 2016 <a href="#">Operahouse</a>.
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

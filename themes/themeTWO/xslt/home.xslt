<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
    <script>
      <!--loadStyle('OPHContent/themes/themeTWO/scripts/jquery-ui/jquery-ui.css');
      loadStyle('OPHContent/themes/themeTWO/scripts/bootstrap/css/bootstrap.min.css');
      loadStyle('OPHContent/themes/themeTWO/scripts/font-awesome/css/font-awesome.min.css');
      loadStyle('OPHContent/themes/themeTWO/scripts/selectbox/select_option1.css');
      loadStyle('OPHContent/themes/themeTWO/scripts/rs-plugin/css/settings.css');
      loadStyle('OPHContent/themes/themeTWO/scripts/rs-plugin/css/settings.css');
      loadStyle('OPHContent/themes/themeTWO/scripts/owl-carousel/owl.carousel.css');
      loadStyle('OPHContent/themes/themeTWO/styles/font-oxygen.css');
      loadStyle('OPHContent/themes/themeTWO/styles/icon-font.min.css');
      loadStyle('OPHContent/themes/themeTWO/styles/style.css');
      loadStyle('OPHContent/themes/themeTWO/styles/default.css');-->

      <!--loadScript('OPHContent/themes/themeTWO/scripts/jquery.1.11.3.jquery.min.js');
      loadScript('OPHContent/themes/themeTWO/scripts/jquery-ui/jquery-ui.js');
      loadScript('OPHContent/themes/themeTWO/scripts/rs-plugin/js/jquery.themepunch.tools.min.js');
      loadScript('OPHContent/themes/themeTWO/scripts/rs-plugin/js/jquery.themepunch.revolution.min.js');
      loadScript('OPHContent/themes/themeTWO/scripts/selectbox/jquery.selectbox-0.1.3.min.js');
      loadScript('OPHContent/themes/themeTWO/scripts/countdown/jquery.syotimer.js');
      loadScript('OPHContent/themes/themeTWO/scripts/bootstrap/js/bootstrap.min.js');

      //ada di home_browse_feature
      loadScript('OPHContent/themes/themeTWO/scripts/owl-carousel/owl.carousel.js');
      loadScript('OPHContent/themes/themeTWO/scripts/js/custom.js');
      loadScript('OPHContent/themes/themeTWO/scripts/custom-me.js');-->


      LoadNewPart('home_browse', 'contentWrapper', 'home', '','');
      changeColorMenuFront();
    </script>
    <!-- Page script -->

    <!--before loadpage-->
    <!-- Message -->
    <div id="popupMsg" class="alert alert-warning" style="background:#47BAC1; color:white; position:fixed; z-index:1000; top:5%;  right:3%; width:350px; margin:0 auto; display:none">
      <button type="button" class="close" onclick="hidePopUp('popupMsg')" aria-hidden="true" style="color:white; opacity:1;">
        x
      </button>
      <!--<span class="glyphicon glyphicon-record">&#xA0;</span>
      <strong>&#xA0;</strong>
      <hr class="message-inner-separator" />-->
      <p style="color:white;" id="popupMsgContent">
        Notification
      </p>
    </div>

    <!--LOGIN MODAL-->
    <div class="modal fade login-modal" id="login" tabindex="-1" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h3 class="modal-title">log in</h3>
          </div>
          <div class="modal-body">
            <form action="" method="POST" role="form">
              <div class="form-group">
                <label for="">User ID</label>
                <input type="text" class="form-control" id="userid" onkeypress="loginkeypressFront(event)"/>
              </div>
              <div class="form-group">
                <label for="">Password</label>
                <input type="password" class="form-control" id="pwd" onkeypress="loginkeypressFront(event)"/>
              </div>
              <div class="alert alert-danger" id="loginNotif" style="display:none;height:35px;padding-top:8px;">
                <span class="glyphicon glyphicon-exclamation-sign">&#xA0;</span>
                <span id="loginNotifMsg">&#xA0;</span>
              </div>

              <div class="checkbox">
                <label>
                  <input type="checkbox" id="rememberme"/> Remember Me
                </label>
              </div>
              <a class="btn btn-primary btn-block" onclick ="signInFrontEnd()">log in</a>
              <a href="index.aspx?code=login2" class="btn btn-link btn-block">Get New Password ?</a>
            </form>
          </div>
        </div>
      </div>
    </div>

    <!--Loading Screen-->
    <!--
    <div id="content-loader">
      <div class="loader" style="">
        &#xA0;
      </div>
    </div>-->

    <!--Stop Loading Screen-->
    <!--script>
      $( document ).ajaxStop(function() {
      $("#content-loader").show("slow").delay(500).fadeOut();
      if ($("#LimitUser > span").html() != undefined) if ( $("#LimitUsers").html()!= undefined) document.getElementById("LimitUsers").innerHTML = $("#LimitUser > span").html();
      
      });
    </script-->

    <!--HEADER-->
    <div class="header clearfix headerV3">
      <!-- TOPBAR -->
      <div class="topBar">
        <div class="container">
          <div class="row">
            <div class="col-md-6 hidden-sm hidden-xs">
              &#xA0;
            </div>
            <div class="col-md-6 col-xs-12">
              <ul class="list-inline pull-right top-right">
                <li class="account-login" id="loginbuttons">
                  Loading Please Wait...
                  <script>
                    var username = '<xsl:value-of select="sqroot/header/info/user/userName/." />';
                    topbutton(username);
                  </script>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>

      <!-- NAV TOP -->
      <div class="navTop text-center">
        <div class="container">
          <div class="navbar-header">
            <a class="navbar-brand" href="javascript:void(0)">
              <img src="OPHContent/themes/themeTWO/images/logo2.png" style="width:200px;" alt="logo" />
            </a>
          </div>
          <div class="navTop-middle" >
            <div class="searchBox" style="margin-left:15%; width:75%">
              <span class="input-group" style="border-left:1px #cccccc solid;">
                <input type="text" id="searchText" class="form-control" placeholder="Search…" aria-describedby="basic-addon2" onkeypress="searchkeypressFront(event)" />
                <button type="submit" class="input-group-addon" onclick="searchFront()">
                  <ix class="fa fa-search"></ix>
                </button>
              </span>
            </div>
          </div>
          <div class="dropdown cart-dropdown" id="carttop" style="margin-left:5px">
            Loading Please Wait...
            <script>
              var filterkey = "pcsoGUID = '" +  getCookie("cartID") + "'";
              LoadNewPart('home_browse_cart_top', 'carttop', 'tapcs1deta', filterkey, '');
            </script>
          </div>
        </div>
      </div>

      <nav class="navbar navbar-main navbar-default nav-V3" role="navigation">
        <div class="container">
          <div class="nav-category dropdown">
            <a href="javascript:void(0)" class="dropdown-toggle"  data-toggle="collapse" data-target="#demo5">
              <span class="resize-font-12px">Category &amp; Brand</span>
              <button type="button">
                <span class="icon-bar">&#xA0;</span>
                <span class="icon-bar">&#xA0;</span>
                <span class="icon-bar">&#xA0;</span>
              </button>
            </a>
            <div class="" id="demo5" style="color:white; position:absolute; background:#white; z-index:100; width:100%; right:0px; top:50px; overflow:hidden !important; overflow-y:scroll !important; max-height:520px !important;">
              <xsl:apply-templates select="sqroot/header/filters/filter" />
            </div>


          </div>
          <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"> &#xA0;</span>
              <span class="icon-bar"> &#xA0;</span>
              <span class="icon-bar"> &#xA0;</span>
            </button>
          </div>

          <!-- Collect the nav links, forms, and other content for toggling -->
          <div class="collapse navbar-collapse navbar-ex1-collapse">
            <ul class="nav navbar-nav">
              <xsl:apply-templates select="sqroot/header/menus/menu[@code='primaryfront']/submenus/submenu" />
              <script type="text/javascript">
                if (getCookie("isLogin") == "0"){
                $('.needlogin').attr('href','.login-modal')
                }
              </script>
            </ul>
          </div>
          <!-- /.navbar-collapse -->
        </div>
      </nav>

    </div>

    <div  id="contentWrapper" class="content-wrapper">
      a
    </div>

    <!-- COPY RIGHT -->
    <div class="copyRight clearfix">
      <div class="container">
        <div class="row">
          <div class="col-sm-7 col-xs-12">
            <p>
              © 2016 Copyright <a style="color:white" href="http://www.loreal.com/">L'oreal Indonesia</a>
            </p>
          </div>
          <div class="col-sm-5 col-xs-12">
            <p class="poweredby">
              Powered By <a href="http://operahouse.systems/" style="color:white">OPERAHOUSE.SYSTEMS</a>
            </p>
          </div>
        </div>
      </div>
    </div>

    <!--Stop Loading Screen-->
    <script>
      showtheLimit();
    </script>

  </xsl:template>


  <xsl:template match="sqroot/header/menus/menu[@code='primaryfront']/submenus/submenu">
    <li class="dropdown">
      <xsl:choose>
        <xsl:when test="(@type)='treeroot'">
          <a href="{pageURL/.}" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" id="prim-{caption/.}">
            <xsl:value-of select="caption/." />
          </a>
          <ul class="dropdown-menu dropdown-menu-right">
            <xsl:apply-templates select="submenus/submenu[@type='treeview']" />
          </ul>
        </xsl:when>
        <xsl:when test="(@type)='label'">
          <a href="{pageURL/.}" id="prim-{caption/.}">
            <xsl:value-of select="caption/." />
          </a>
        </xsl:when>
      </xsl:choose>
    </li>
  </xsl:template>


  <xsl:template match="submenus/submenu[@type='treeview']">
    <li>
      <a  class="needlogin" data-toggle="modal" href="{pageURL/.}">
        <xsl:value-of select="caption/." />
      </a>
    </li>
  </xsl:template>

  <!--filters-->
  <xsl:template match="sqroot/header/filters/filter">
    <div class="panel-group">
      <p class="resize-font-10px" style="color:white; background:#37acb2;  display:block; font-size:15px; padding:5px 10px;  margin-bottom:0px;">
        Choose By <xsl:value-of select="caption/." />
      </p>
      <div class="panel panel-default">
        <div class="accordian-body collapse in top-menu-div product-menu" id="demo6" style="">
          <div class="panel-group" id="accordion2">
            <!-- SIDEBAR -->
            <!--<xsl:apply-templates select="sqroot/header/menus/menu[@code='catagory']/submenus/submenu" />-->
            <div id="{caption/.}Menu">
              <script>
                if (getQueryVariable("GUID") == undefined){
                var xslfile = '<xsl:value-of select="caption/." />';
                var id = '<xsl:value-of select="caption/." />'+'Menu';
                var code = '<xsl:value-of select="code/." />';
                var prnt = '<xsl:value-of select="@Parent" /> is null';
                LoadNewPart('home_browse_menu_sidebar', id, code, prnt, '', '1', '200', 'id asc');
                }
              </script>
            </div>
          </div>
        </div>
      </div>

    </div>
  </xsl:template>
</xsl:stylesheet>

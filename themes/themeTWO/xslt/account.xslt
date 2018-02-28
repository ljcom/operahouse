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
      loadStyle('OPHContent/themes/themeTWO/styles/default.css')

      loadScript('OPHContent/themes/themeTWO/scripts/jquery.1.11.3.jquery.min.js');
      loadScript('OPHContent/themes/themeTWO/scripts/jquery-ui/jquery-ui.js');
      loadScript('OPHContent/themes/themeTWO/scripts/rs-plugin/js/jquery.themepunch.tools.min.js');
      loadScript('OPHContent/themes/themeTWO/scripts/rs-plugin/js/jquery.themepunch.revolution.min.js');
      loadScript('OPHContent/themes/themeTWO/scripts/selectbox/jquery.selectbox-0.1.3.min.js');
      loadScript('OPHContent/themes/themeTWO/scripts/countdown/jquery.syotimer.js');
      loadScript('OPHContent/themes/themeTWO/scripts/custom-me.js');-->

      loadScript('OPHContent/themes/themeTWO/scripts/bootstrap/js/bootstrap.min.js');
      loadScript('OPHContent/themes/themeTWO/scripts/owl-carousel/owl.carousel.js');
      loadScript('OPHContent/themes/themeTWO/scripts/js/custom.js');


      if (getQueryVariable("GUID") != undefined &amp;&amp; getQueryVariable("GUID") != '' &amp;&amp; getQueryVariable("code").toLowerCase() =='causerfron'){
      ChangePages('_profile', 'contentAccount');
      }else if (getQueryVariable("code")=='causeraddr'){
      ChangePages('_address', 'contentAccount');
      }else if (getQueryVariable("code").toLowerCase() =='tapcs3'){
      if (getQueryVariable("GUID") != undefined &amp;&amp; getQueryVariable("GUID") != '') {
      //var GUID = "PCSOGUID = '" + getQueryVariable("GUID") +"'";
      var GUID = "PCSOGUID = '" + getCookie("cartID") +"'";

      LoadNewPartView('account_form_orders', 'contentAccount', 'tapcs3');
      }
      else{
      var filterkey = "carolGUID = '<xsl:value-of select="sqroot/header/info/user/userGUID/." />' and status != '0'";
          LoadNewPart('account_browse_orders', 'contentAccount', 'tapcs3', filterkey, '');
        }
      }else if (getQueryVariable("code")=='wish'){
      ChangePages('_wishlist', 'contentAccount');
      }else{
      ChangePages('', 'contentAccount')
      }
      changeColorMenuFront();
      

    </script>
    <!-- Page script -->
    <input type="hidden" value="{sqroot/header/info/user/userGUID/.}" id="hiddenUsrGUID" />
    <input type="hidden" value="{sqroot/header/info/user/userName/.}" id="hiddenUsrName" />
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
                <li class="searchBox">
                  <a href="#"><ix class="fa fa-search"></ix></a>
                  <ul class="dropdown-menu dropdown-menu-right">
                    <li>
                      <span class="input-group">
                        <input type="text" id="searchText" class="form-control" placeholder="Search…" aria-describedby="basic-addon2" onkeypress="searchkeypressFront(event)" />
                        <button type="submit" class="input-group-addon" onclick="searchFront()">Submit</button>
                      </span>
                    </li>
                  </ul>
                </li>
                <li class="dropdown cart-dropdown" id="carttop">
                  Loading Please Wait...
                  <script>
                    var filterkey = "pcsoGUID = '" +  getCookie("cartID") + "'"
                    LoadNewPart('cart_top', 'carttop', 'tapcs1deta', filterkey, '');
                  </script>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>

      <!-- NAVBAR -->
      <nav class="navbar navbar-main navbar-default" role="navigation">
        <div class="container">
          <!-- Brand and toggle get grouped for better mobile display -->
          <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="javascript:goHome();">
              <img src="OPHContent/themes/themeTWO/images/logo2.png" style="width:200px;" alt="logo" />
            </a>
          </div>

          <!-- Collect the nav links, forms, and other content for toggling -->
          <div class="collapse navbar-collapse navbar-ex1-collapse">
            <ul class="nav navbar-nav navbar-right">
              <xsl:apply-templates select="sqroot/header/menus/menu[@code='primaryfront']/submenus/submenu" />
            </ul>
          </div>
          <!-- /.navbar-collapse -->
        </div>
      </nav>
    </div>

    <!-- LIGHT SECTION -->
    <section class="lightSection clearfix pageHeader">
      <div class="container">
        <div class="row">
          <div class="col-xs-6">
            <div class="page-title">
              <h2>ACCOUNT</h2>
            </div>
          </div>
          <div class="col-xs-6">
            <ol class="breadcrumb pull-right">
              <li>
                <a href="?">Home</a>
              </li>
              <li class="active">Account Dashboard</li>
            </ol>
          </div>
        </div>
      </div>
    </section>
    
    <div  id="contentWrapper" class="content-wrapper">
      <!-- MAIN CONTENT SECTION -->
      <section class="mainContent clearfix userProfile" >
        <div class="container">
          <div class="row">
            <!--SECONDARY MENU-->
            <div class="col-xs-12">
              <div class="btn-group" role="group" aria-label="...">
                <xsl:apply-templates select="sqroot/header/menus/menu[@code='Account']/submenus/submenu" />
              </div>
            </div>

            <!-- CONTENT-->
            <div class="row" id="contentAccount">
              a
            </div>
          </div>
        </div>
      </section>
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
          <!--<div class="col-sm-5 col-xs-12">
            <p class="poweredby">
              Powered By <a href="http://operahouse.systems/" style="color:white">OPERAHOUSE.SYSTEMS</a>
            </p>
          </div>-->
        </div>
      </div>
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
                  <input type="checkbox" /> Remember Me
                </label>
              </div>
              <a class="btn btn-primary btn-block" onclick ="signInFrontEnd()">log in</a>
              <a href="index.aspx?code=login2" class="btn btn-link btn-block">Get New Password ?</a>
            </form>
          </div>
        </div>
      </div>
    </div>

    <div class="modal fade limit-modal" id="limitmodal" tabindex="-1" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h3 class="modal-title">Remaining Limit</h3>
          </div>
          <div class="modal-body" id="limitmodalbody">
            Loading Please Wait...
          </div>
        </div>
      </div>
    </div>
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
    
    <!--Loading Screen--><!--
    <div id="content-loader">
      <div class="loader" style="">
        &#xA0;
      </div>
    </div>-->

    <!--Stop Loading Screen-->
    <script>
      //$( document ).ajaxStop(function() {
      //$("#content-loader").show("slow").delay(500).fadeOut();
      //if ($("#LimitUser").html() != undefined) if ( $("#LimitUsers").html()!= undefined) document.getElementById("LimitUsers").innerHTML = $("#LimitUser").html();
      //});
    </script>
  </xsl:template>
  
  <!--primary menu-->
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
  
  <!--treeview-->
  <xsl:template match="submenus/submenu[@type='treeview']">
    <li>
      <a href="{pageURL/.}">
        <xsl:value-of select="caption/." />
      </a>
    </li>
  </xsl:template>
  
  <!--secondary menu-->
  <xsl:template match="sqroot/header/menus/menu[@code='Account']/submenus/submenu">
      <xsl:choose>
        <xsl:when test="(@type)='treeroot'">
          
        </xsl:when>
        <xsl:when test="(@type)='label' and (caption/.)='Profile'">
          <a href="{pageURL/.}{../../../../info/user/userGUID/.}" class="btn btn-default {@active}">
            <span style="margin-right:10px;"><ix class="{icon/fa/.}" aria-hidden="true"></ix></span> <xsl:value-of select="caption/." />
          </a>
        </xsl:when>
        <xsl:when test="(@type)='label' and (caption/.)!='Profile'">
          <a href="{pageURL/.}" class="btn btn-default {@active}">
            <span style="margin-right:10px;">
              <ix class="{icon/fa/.}" aria-hidden="true"></ix>
            </span>
            <xsl:value-of select="caption/." />
          </a>
        </xsl:when>
      </xsl:choose>
  </xsl:template>

</xsl:stylesheet>

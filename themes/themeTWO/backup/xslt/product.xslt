<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
  
  <xsl:template match="/">
    <script>
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/jquery-ui/jquery-ui.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/bootstrap/css/bootstrap.min.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/font-awesome/css/font-awesome.min.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/selectbox/select_option1.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/rs-plugin/css/settings.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/owl-carousel/owl.carousel.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/styles/font-oxygen.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/styles/icon-font.min.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/styles/style.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/styles/default.css')

      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/jquery.1.11.3.jquery.min.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/jquery-ui/jquery-ui.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/bootstrap/js/bootstrap.min.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/rs-plugin/js/jquery.themepunch.tools.min.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/rs-plugin/js/jquery.themepunch.revolution.min.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/owl-carousel/owl.carousel.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/selectbox/jquery.selectbox-0.1.3.min.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/countdown/jquery.syotimer.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/js/custom.js');
      
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/custom-me.js');

      var bpageno = getCookie("bpageno");
      var showpage = getCookie("showpage");
      var bSearchText = getQueryVariable("bSearchText");
      var sortOrder = getCookie("sortOrder");

      if (bpageno == '' || bpageno == undefined) {bpageno = 1 ;}
      if (showpage == '' || showpage == undefined) {showpage = 21 ;}
      if (bSearchText == '' || bSearchText == undefined) {bSearchText = '' ;}
      if (sortOrder == '' || sortOrder == undefined) {sortOrder = '' ;}

      if (getQueryVariable("GUID") != undefined &amp;&amp; getQueryVariable("GUID")){
      loadContent2('contentWrapper');
      }else{
      if (getQueryVariable("type") == 'list'){
      LoadNewPart('product_browse_list', 'contentBrowse', 'maprodfron', '', bSearchText, bpageno, showpage, 'Name Asc');
      }else{
      LoadNewPart('product_browse', 'contentBrowse', 'maprodfron', '', bSearchText, bpageno, showpage, 'Name Asc');
      }
      }

      setCookie("bpageno", "1", 0, 1, 0);
      setCookie("showpage", "21", 0, 1, 0);
      setCookie("bSearchText", "", 0, 1, 0);
      setCookie("sortOrder", "", 0, 1, 0);

    </script>
    <!-- Page script -->
    
    <!--before loadpage-->
    <!-- Message -->
    <div id="popupMsg" class="alert alert-warning" style="background:#47BAC1; color:white; position:fixed; z-index:1000; top:5%;  right:3%; width:350px; margin:0 auto; display:none">
      <button type="button" class="close" onclick="hidePopUp('popupMsg')" aria-hidden="true" style="color:white; opacity:1;">
        x
      </button>
      <span class="glyphicon glyphicon-record">&#xA0;</span>
      <strong>Notification</strong>
      <hr class="message-inner-separator" />
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
                  <input type="checkbox" /> Remember Me
                </label>
              </div>
              <a class="btn btn-primary btn-block" onclick ="signIn()">log in</a>
              <button type="button" class="btn btn-link btn-block">Forgot Password?</button>
            </form>
          </div>
        </div>
      </div>
    </div>

    <!--Loading Screen-->
    <div id="content-loader">
      <div class="loader" style="">
        &#xA0;
      </div>
    </div>

    <!--Stop Loading Screen-->
    <script>
      $( document ).ajaxStop(function() {

      if ($(".productBox").length == '0' &amp;&amp; $(".maskingImage").length == '0') {
      $("div#contentBrowse" ).html("No item for selected category");
      }
      $("#content-loader").show("slow").delay(500).fadeOut();

      });
    </script>
    
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
                    var filterkey = "pcsoGUID = '" +  getCookie("cartID") + "'";
                    LoadNewPart('cart_top', 'carttop', 'tapcs1deta', filterkey, '', '', '');
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
              <span class="icon-bar"> &#xA0;</span>
              <span class="icon-bar"> &#xA0;</span>
              <span class="icon-bar"> &#xA0;</span>
            </button>
            <a class="navbar-brand" href="index.aspx?code=home" >
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
              <h2 id="PageTitle">Product</h2>
            </div>
          </div>
          <!--<div class="col-xs-6">
            <ol class="breadcrumb pull-right" id="breadcrumbs">
              <li>
                <a href="index.aspx?code=home">Home</a>
              </li>
              <li class="active">Product</li>
            </ol>
          </div>-->
        </div>
      </div>
    </section>
    
    <!--CONTENT WRAPPER-->
    <div  id="contentWrapper" class="content-wrapper">
      <!-- MAIN CONTENT SECTION -->
      <section class="mainContent clearfix productsContent" >
        <div class="container">
          <div class="row">
            <div class="col-md-3 col-sm-4 col-xs-12 sideBar">
              <xsl:apply-templates select="sqroot/header/filters/filter" />
             
            </div>
            <div class="col-md-9 col-sm-8 col-xs-12">
              <div class="row filterArea">
                <div class="col-xs-6" style="font-size:8px;">
                  <select name="guiest_id1" id="guiest_id1" class="select-drop" onchange="SortingBy('product', 'contentBrowse', getCode())">
                    <option value="name asc">Default sorting</option>
                    <option value="id asc">Order By Item Code</option>
                    <option value="Price Desc">Sort from the highest price</option>
                    <option value="Price Asc">Sort from the lowest price</option>
                  </select>
                </div>
                <div class="col-xs-6">
                  <div class="btn-group pull-right" role="group">
                    <button type="button" class="btn btn-default" id="gridtab" onclick="productChangeView('browse', 'contentBrowse')">
                      <span><ix class="fa fa-th" aria-hidden="true"></ix></span><span>Grid</span>
                    </button>
                    <button type="button" class="btn btn-default" id="listtab" onclick="productChangeView('browse_list', 'contentBrowse')">
                      <span><ix class="fa fa-th-list" aria-hidden="true"></ix></span><span>List</span> 
                   </button>
                  </div>
                </div>
              </div>
              <div id="contentBrowse">
                Loading Please wait...
              </div>      
            </div>
          </div>
        </div>
      </section>   
    </div>
   
    
    <!-- LIGHT SECTION -->
    <section class="lightSection clearfix">
      <div class="container">
        <div class="row">
          <!--<div class="col-xs-12">
            <div class="owl-carousel partnersLogoSlider">
              <div class="slide">
                <div class="partnersLogo clearfix">
                  <img src="OPHContent/themes/themeTWO/images/home/partners/partner-01.png" alt="partner-img" />
                </div>
              </div>
              <div class="slide">
                <div class="partnersLogo clearfix">
                  <img src="OPHContent/themes/themeTWO/images/home/partners/partner-02.png" alt="partner-img" />
                </div>
              </div>
              <div class="slide">
                <div class="partnersLogo clearfix">
                  <img src="OPHContent/themes/themeTWO/images/home/partners/partner-03.png" alt="partner-img" />
                </div>
              </div>
              <div class="slide">
                <div class="partnersLogo clearfix">
                  <img src="OPHContent/themes/themeTWO/images/home/partners/partner-04.png" alt="partner-img" />
                </div>
              </div>
              <div class="slide">
                <div class="partnersLogo clearfix">
                  <img src="OPHContent/themes/themeTWO/images/home/partners/partner-05.png" alt="partner-img" />
                </div>
              </div>
              <div class="slide">
                <div class="partnersLogo clearfix">
                  <img src="OPHContent/themes/themeTWO/images/home/partners/partner-01.png" alt="partner-img" />
                </div>
              </div>
              <div class="slide">
                <div class="partnersLogo clearfix">
                  <img src="OPHContent/themes/themeTWO/images/home/partners/partner-02.png" alt="partner-img" />
                </div>
              </div>
              <div class="slide">
                <div class="partnersLogo clearfix">
                  <img src="OPHContent/themes/themeTWO/images/home/partners/partner-03.png" alt="partner-img" />
                </div>
              </div>
            </div>
          </div>-->
        </div>
      </div>
    </section>
    
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
    
   
  </xsl:template>
  
   <!--SIDEBAR CATAGORY-->
  <xsl:template match="sqroot/header/menus/menu[@code='catagory']/submenus/submenu">
    <div class="panel top-menu-onphone" style="border-radius:0; margin-top:0;">
      <!--<a class="top-envi" data-toggle="collapse" data-parent="#accordion2" href="{pageURL/.}">-->
      <a class="top-envi" data-toggle="collapse" href="{pageURL/.}">
        <ix>
          <img src="{icon/img/.}" style="width:15px; margin-right:8px;" />
        </ix> 
        <xsl:value-of select="caption/." />
        <xsl:choose>
          <xsl:when test="(@mode)='treeroot'">
            <span class="fa fa-plus" style="position:absolute; right:15px; top:18px; font-size:12px; color:#4c4c4c"></span>
          </xsl:when>
        </xsl:choose>
      </a>
      <xsl:choose>
        <xsl:when test="(@mode)='treeroot'">
          <div id="{id/.}" class="panel-collapse collapse">
            <ul>
              <xsl:apply-templates select="submenus/submenu[@mode='treeview']" />
            </ul>
          </div>
        </xsl:when>
      </xsl:choose>
    </div>
  </xsl:template>
  
  <!--SIDEBAR BRAND-->
  <xsl:template match="sqroot/header/menus/menu[@code='brand']/submenus/submenu">
    <div class="panel top-menu-onphone" style="border-radius:0; margin-top:0;">
      <!--<a class="top-envi" data-toggle="collapse" data-parent="#accordion2" href="{pageURL/.}"  >-->
      <a class="top-envi" data-toggle="collapse" href="{pageURL/.}">
        <span href="#" title="{link/.}" onclick="goToRef(this, '{link/.}')">
          <ix>
            <img src="{icon/img/.}" style="width:15px; margin-right:8px;" />
          </ix>
          <xsl:value-of select="caption/." /><br />
          <span style="margin-left:24px;"><xsl:value-of select="link/." /><br /></span>
        </span>
        <xsl:choose>
          <xsl:when test="(@mode)='treeroot'">
            <span class="fa fa-plus" style="position:absolute; right:15px; top:30px; font-size:12px; color:#4c4c4c" ></span>
          </xsl:when>
        </xsl:choose>
      </a>
      <div id="{id/.}" class="panel-collapse collapse">
        <ul>
          <xsl:apply-templates select="submenus/submenu[@mode='treeview']" />
        </ul>
      </div>
    </div>
  </xsl:template>
  
  <!--SIDEBAR Treeview-->
  <xsl:template match="submenus/submenu[@mode='treeview']">
    <xsl:choose>
      <xsl:when test="submenus!=''">
        <li>
          <a data-toggle="collapse" href="{pageURL/.}" class="top-envi-lv2"><span style="margin-right:10px; font-size:9px;">➤</span> <xsl:value-of select="caption/." />
            <xsl:choose>
              <xsl:when test="submenus!=''">
                <span class="fa fa-plus" style="position:absolute; right:15px; top:16px;"></span>
              </xsl:when>
            </xsl:choose>
          </a>
          <xsl:choose>
            <xsl:when test="submenus!=''">
              <div id="{id/.}" class="panel-collapse collapse">
                <ul>
                  <xsl:apply-templates select="submenus/submenu[@mode='treeview']" />
                </ul>
              </div>
            </xsl:when>
          </xsl:choose>
        </li>
      </xsl:when>
      <xsl:otherwise>
        <li>
          <a href="{pageURL/.}"><span style="margin-right:10px; font-size:9px;">➤</span> <xsl:value-of select="caption/." /> </a>
        </li>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!--primary front menu-->
  <xsl:template match="sqroot/header/menus/menu[@code='primaryfront']/submenus/submenu">
    <li class="dropdown">
      <xsl:choose>
        <xsl:when test="(@mode)='treeroot'">
          <a href="{pageURL/.}" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
            <xsl:value-of select="caption/." />
          </a>
          <ul class="dropdown-menu dropdown-menu-right">
            <xsl:apply-templates select="submenus/submenu[@mode='treeview']" />
          </ul>
        </xsl:when>
        <xsl:when test="(@mode)='label'"><a href="{pageURL/.}"><xsl:value-of select="caption/." /></a></xsl:when>
      </xsl:choose>
    </li>
  </xsl:template>
  
  <xsl:template match="submenus/submenu[@mode='treeview']">
    <li>
      <a class="needlogin" data-toggle="modal" href="{pageURL/.}"><xsl:value-of select="caption/." /></a>
    </li>
  </xsl:template>

  <!--filters-->
  <xsl:template match="sqroot/header/filters/filter">
    <div class="panel panel-default">
      <div class="panel-heading"><xsl:value-of select="caption/." /></div>
      <div class="accordian-body collapse in top-menu-div product-menu" id="demo5">
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
                LoadNewPart('catagory', id, code, prnt, '', '', '');
              }
            </script>       
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>

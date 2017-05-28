<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">

    <!-- BANNER -->
    <div class="container">
      <div class="bannercontainer bannerV4">
        <div class="fullscreenbanner-container">
          <div class="fullscreenbanner">
            <ul id="sliderloc">
              <span id="loadingslider">Loading Please Wait...</span>
              <xsl:apply-templates select="sqroot/header/menus/menu[@code='slider']/submenus/submenu" />
              <!--<script>
                LoadNewPart('home_browse_slider', 'sliderloc', 'maSLDRIMGE', "SLDRGUID ='5F5A7C4F-17F8-48CA-A179-AEF41DFA099F'", '', '', '', 'imgCaption asc');
              </script>-->
            </ul>
          </div>
        </div>
      </div>

    </div>

    <!-- CONTENT SECTION -->
    <section class="content clearfix">
      <div class="container">

        <!-- FEATURE COLLECTION SECTION -->
        <div class="row featuredCollection version2 version3">
          <xsl:apply-templates select="sqroot/header/menus/menu[@code='slider2']/submenus/submenu" />
        </div>
        <div class="categorySection">
          <div class="row" id="featurehome">
            <script>
              LoadNewPart('home_browse_feature', 'featurehome', 'mactgrhome', '', '');
            </script>
          </div>
        </div>
      </div>
    </section>


  </xsl:template>
  
  <!--slider1-->
  <xsl:template match="sqroot/header/menus/menu[@code='slider']/submenus/submenu">
   <li data-transition="slidehorizontal" data-slotamount="5" data-masterspeed="700"  data-title="Slide 3" class="homeslider" style="display:none;">
      <img src="OPHContent/documents/{/sqroot/header/info/account/.}/{pageURL/.}" onerror="this.src='ophcontent/themes/themeTWO/images/white.png'" alt="slidebg1" data-bgfit="cover" data-bgposition="center center" data-bgrepeat="no-repeat" />
      <div class="slider-caption slider-captionV4">
         <xsl:if test="link/. != ''">
            <div class="tp-caption rs-caption-4 sft"
              data-hoffset="0"
              data-x="550"
              data-y="400"
              data-speed="800"
              data-start="3500"
              data-easing="Power4.easeOut"
              data-endspeed="300"
              data-endeasing="Power1.easeIn"
              data-captionhidden="off">
              <span class="page-scroll">
                <a href="index.aspx?code=maprodfron&amp;{link/.}" class="btn primary-btn">
                  Klik Disini<ix class="glyphicon glyphicon-chevron-right"></ix>
                </a>
              </span>
            </div>
          </xsl:if>
        
      </div>
    </li>
  </xsl:template>
  
  <!--slider2-->
  <xsl:template match="sqroot/header/menus/menu[@code='slider2']/submenus/submenu">
    <xsl:variable name="oriDesc" select="MenuDescription/." />

    <div class="col-sm-6 col-xs-12" >
      <div style=" background:#F1E39A; padding:10px" class="banner2">
        <div class="row">
          <div class="col-sm-6" style="text-align:center;">
            <img src="OPHContent/documents/{/sqroot/header/info/account/.}/{pageURL/.}" onerror="this.src='ophcontent/themes/themeTWO/images/white.png'" alt="image" />
          </div>
          <div class="col-sm-6 col-xs-12" >
            <h3>
              <a href="{icon_url/.}" style="color:black; font-weight:bold;">
                <xsl:value-of select="caption/." />
              </a>
            </h3>
            <p>
              <xsl:choose>
                <xsl:when test="string-length(MenuDescription/.) &gt; 100">
                  <xsl:value-of select="concat(substring($oriDesc, 1, 100), '...')" />
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$oriDesc" />
                </xsl:otherwise>
              </xsl:choose>
            </p>
            <xsl:if test="link/. != ''">
              <a href="index.aspx?code=maprodfron&amp;{link/.}" class="btn btn-border">Shop Now</a>
            </xsl:if>
          </div>
        </div>

      </div>
      <!--<div class="slide" style="background:#F1E39A; margin-bottom:20px; padding:10px;">
        <div class="row">
          <div class="col-sm-6 col-xs-12">
            <div class="productImage" style="background:#F1E39A">
              <div class="banner2">
                <img src="{pageURL/.}" />
              </div>
            </div>
          </div>
          <div class="col-sm-6 col-xs-12" >
            <h3>
              <a href="{icon_url/.}" style="color:black; font-weight:bold;">
                <xsl:value-of select="caption/." />
              </a>
            </h3>
            <p>
              <xsl:choose>
                <xsl:when test="string-length(MenuDescription/.) &gt; 100">
                  <xsl:value-of select="concat(substring($oriDesc, 1, 100), '...')" />
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$oriDesc" />
                </xsl:otherwise>
              </xsl:choose>
            </p>
            <xsl:if test="link/. != ''">
              <a href="index.aspx?code=maprodfron&amp;{link/.}" class="btn btn-border">Shop Now</a>
            </xsl:if>
          </div>
        </div>
      </div>-->
    </div>
  </xsl:template>
</xsl:stylesheet>

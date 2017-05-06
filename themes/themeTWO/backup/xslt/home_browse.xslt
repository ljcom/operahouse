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
            <ul>
              <span id="loadingslider">Loading Please Wait...</span>
              <xsl:apply-templates select="sqroot/header/menus/menu[@code='slider']/submenus/submenu" />
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
      <img src="{pageURL/.}" alt="slidebg1" data-bgfit="cover" data-bgposition="center center" data-bgrepeat="no-repeat" />
      <div class="slider-caption slider-captionV4">
        <div class="tp-caption rs-caption-3 sft"
          data-hoffset="0"
          data-x="300"
          data-y="240"
          data-speed="1000"
          data-start="3000"
          data-easing="Power4.easeOut"
          data-endspeed="300"
          data-endeasing="Power1.easeIn"
          data-captionhidden="on">
          <xsl:if test="@type = 'sliderwithbutton'">
            <xsl:value-of select="MenuDescription/." />
          </xsl:if>
        </div>
         <xsl:if test="@type = 'sliderwithbutton'">
            <div class="tp-caption rs-caption-4 sft"
              data-hoffset="0"
              data-x="300"
              data-y="350"
              data-speed="800"
              data-start="3500"
              data-easing="Power4.easeOut"
              data-endspeed="300"
              data-endeasing="Power1.easeIn"
              data-captionhidden="off">
              <span class="page-scroll">
                <a href="#" class="btn primary-btn">
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
    <div class="col-sm-6 col-xs-12">
      <div class="slide">
        <div class="productImage" style="background:#F1E39A">
          <div style="width:100px; height:100px;">
            <img src="{pageURL/.}" />
          </div>
        </div>
        <div class="productCaption clearfix text-right">
          <h3>
            <a href="{icon_url/.}"><xsl:value-of select="caption/." /></a>
          </h3>
          <p><xsl:value-of select="MenuDescription/." /></p>
          <a href="{icon_url/.}" class="btn btn-border">Shop Now</a>
        </div>
      </div>
    </div>
  </xsl:template>
</xsl:stylesheet>

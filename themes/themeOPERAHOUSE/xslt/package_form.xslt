<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:template match="/">
    
    <xsl:apply-templates select="sqroot/body/bodyContent"/>

    <xsl:if test="sqroot/body/bodyContent/form/info/GUID !='00000000-0000-0000-0000-000000000000'">
      <xsl:apply-templates select="sqroot/body/bodyContent/form/children"/>
     
    </xsl:if>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent">
    <!--this is slider-->
    <div class="ms-hero-page-override ms-hero-img-city ms-hero-bg-primary no-pb overflow-hidden ms-bg-fixed">
      <div class="container">
        <div class="text-center color-white">
          <xsl:apply-templates select="form"/>
          
          <!--<h1 class="no-m ms-site-title color-white center-block ms-site-title-lg mt-2 animated zoomInDown animation-delay-5">
            <span>Operahouse</span> Systems
          </h1>
          <p class="lead lead-lg color-white text-center center-block mt-2 mw-800  fw-300 animated fadeInUp animation-delay-7">
            Discover our projects and the rigorous process of creation. Our principles are creativity, design, experience and knowledge.

          </p>
          <a href="javascript:void(0)" class="btn btn-raised btn-lg btn-warning animated flipInX animation-delay-20">
            Start Now - Its Free
          </a>
          <div class="img-browser-container mt-6">
            <img src="OPHContent/themes/{/sqroot/header/info/themeFolder}/assets/img/demo/safariBig1.png" alt="" class="img-responsive center-block index-1 img-browser animated slideInUp"/>
          </div>-->
        </div>
      </div>
    </div>
    
  </xsl:template>

  <xsl:template match="form">
    <xsl:apply-templates select="formPages/formPage[@pageNo&lt;9]"/>
  </xsl:template>


  <xsl:template match="formSections">
    <xsl:apply-templates select="formSection"/>
  </xsl:template>

  <xsl:template match="formSection ">
    <xsl:apply-templates select="formCols"/>
  </xsl:template>


  <xsl:template match="formCols">
    <xsl:apply-templates select="formCol"/>
  </xsl:template>

  <xsl:template match="formCol">

    <xsl:apply-templates select="formRows"/>

  </xsl:template>

  <xsl:template match="formRows">
    <xsl:apply-templates select="formRow"/>

  </xsl:template>

  <xsl:template match="formRow ">
    <xsl:choose>
      <xsl:when test="@rowNo = '1'">
        <h1 class="no-m ms-site-title color-white center-block ms-site-title-lg mt-2 animated zoomInDown animation-delay-5">
          <xsl:apply-templates select="fields"/>
        </h1>
      </xsl:when>
      <xsl:when test="@rowNo = '2'">
        <p class="lead lead-lg color-white text-center center-block mt-2 mw-800 fw-300 animated fadeInUp animation-delay-7">
          <xsl:apply-templates select="fields"/>
        </p>
        <a href="index.aspx?code=orders&amp;launch=orders&amp;package={/sqroot/body/bodyContent/form/info/GUID/.}" class="btn btn-raised btn-warning  animated fadeInUp animation-delay-7" style="margin-top:20px;">
          <i class="zmdi zmdi-account-add"></i>  
          Start Free Trial
        </a>
      </xsl:when>
      
      <xsl:when test="@rowNo = '3'">
        <div class="img-browser-container mt-6" style="margin-top:20px !important;">
          <xsl:apply-templates select="fields"/>
        </div>
      </xsl:when>
      
     
    </xsl:choose>
  </xsl:template>

  <xsl:template match="fields">
    <xsl:apply-templates select="field"/>
  </xsl:template>

  <xsl:template match="field">
    <xsl:apply-templates select="textBox"/>
    <xsl:apply-templates select="mediaBox"/>
  </xsl:template>

  <xsl:template match="textBox">
    <xsl:value-of select="value/."/>
  </xsl:template>


  <xsl:template match="mediaBox">
    <img src="{value/.}" alt="" class="img-responsive center-block index-1 img-browser animated slideInUp" />
  </xsl:template>


  <xsl:template match="sqroot/body/bodyContent/form/children">

    <xsl:apply-templates select="child"/>
  </xsl:template>

  <xsl:template match="child">
      <input type="hidden" id="PKID" value="child{code/.}"/>
      <input type="hidden" id="filter{code/.}" value="{parentkey/.}='{/sqroot/body/bodyContent/form/info/GUID/.}'"/>
      <input type="hidden" id="parent{code/.}" value="{parentkey/.}"/>
      <input type="hidden" id="PKName" value="{parentkey/.}"/>
      <script>

        //xmldoc = "OPHCORE/api/default.aspx?code=<xsl:value-of select ="code/."/>&amp;mode=browse&amp;sqlFilter=<xsl:value-of select ="parentkey/."/>='<xsl:value-of select ="/sqroot/body/bodyContent/form/info/GUID/."/>'"
        //showXML('child<xsl:value-of select ="code/."/>', xmldoc, xsldoc + "_childBrowse.xslt", true, true, function () {});

        var code='<xsl:value-of select ="code/."/>';
        var parentKey='<xsl:value-of select ="parentkey/."/>';
        var GUID='<xsl:value-of select ="/sqroot/body/bodyContent/form/info/GUID/."/>';

        loadChild(code, parentKey, GUID);
      </script>

      <div id="child{code/.}{/sqroot/body/bodyContent/form/info/GUID/.}">
        &#160;
      </div>
  </xsl:template>

</xsl:stylesheet>



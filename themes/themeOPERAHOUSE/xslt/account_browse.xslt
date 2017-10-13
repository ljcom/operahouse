<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:template match="/">
    <script>
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/assets/js/app.min.js');

      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/assets/js/ecommerce.js');
    </script>
  
  <div class="material-background"></div>
  <div class="container">
    <!--this is Banner1-->
    <div class="text-center mb-6">
      <h1 class="no-m ms-site-title color-white center-block ms-site-title-lg mt-2 animated zoomInDown animation-delay-5">Account</h1>
      <p class="lead lead-lg color-white text-center center-block mt-2 mb-4 mw-800 text-uppercase fw-300 animated fadeInUp animation-delay-7">
        Manage Your Account Or 
        <a href="index.aspx?code=account&amp;GUID=00000000-0000-0000-0000-000000000000" class="btn btn-raised btn-primary" style="padding:10px 10px;">
          <i class="zmdi zmdi-account-add"></i>  
          Add 
        </a> New Account Now !
        <!--<span class="colorStar">rigorous process</span> of creation. Our principles are creativity, design, experience and knowledge.-->
      </p>
    </div>

    <!--this is content-->
    <div class="row">
      <div class="col-md-12">
        <div class="row text-center">
          <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row" />
          
        </div>
      </div>
    </div>
  </div>
         
  </xsl:template>


  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
    <div class="col-md-4 col-sm-6">
      <div class="card card-primary" style="margin-top:30px;">
        <div class="card-block text-center">
          <a href="javascript:void(0)" class="btn btn-primary btn-raised btn-card-float left wow zoomInDown index-2">
            <xsl:value-of select ="fields/field[@caption = 'AccountId']/."/>
          </a>
          <h4 class="color-primary">
            <xsl:value-of select ="fields/field[@caption = 'CompanyName']/."/>
          </h4>
          <p style="height:100px; text-overflow: ellipsis;">
            <xsl:value-of select ="fields/field[@caption = 'CompanyDescription']/."/> 
          </p>
          <a href="index.aspx?code={/sqroot/body/bodyContent/browse/info/code/.}&amp;GUID={@GUID}" class="btn btn-primary">
            <i class="zmdi zmdi-edit"></i> Edit 
          </a>
          <a href="javascript:void(0)" class="btn btn-primary btn-raised">
            <i class="zmdi zmdi-globe"></i> Open
          </a>
        </div>
      </div>
    </div>
    <!-- item -->
    
  </xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:template match="/">

    <div class="wrap ms-hero-img-coffee  ms-bg-fixed ms-hero-bg-primary">
      <div class="container">
        <h1 class="color-white text-center mb-4">Your Package</h1>
        <div class="row">
          <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row"/>
        </div>
        <div class="text-center color-white mw-800 center-block mt-4">
          <p class="lead lead-lg">To complete your company's needs.</p>
          <a href="javascript:void(0)" class="btn btn-raised btn-white color-info wow flipInX animation-delay-8">
            <i class="fa fa-space-shuttle"></i> GET MORE
          </a>
        </div>
      </div>
    </div>
    
   
  </xsl:template>

  <!--package section-->
  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
 
    <div class="col-lg-3 col-md-6 col-sm-6">
      <div class="card card-info card-block text-center wow zoomInUp animation-delay-3">
        <!--<p class="counter">
          <xsl:value-of select ="fields/field[@caption = 'NoOfUsers']/."/> Users
        </p>-->
        
        <i class="fa fa-4x fa-group color-info"></i>
        <h4 class="mt-2 no-mb uppercase">
          <a href="#">
            <xsl:value-of select ="fields/field[@caption = 'Package']/."/>
          </a>
        </h4>
        <a href="index.aspx?code={/sqroot/body/bodyContent/browse/info/code/.}&amp;GUID={@GUID}" class="btn btn-primary" style="padding:10px 15px;">
          <i class="zmdi zmdi-edit"></i> Edit
        </a>
        <a href="javascript:void(0)" class="btn btn-primary btn-raised" style="padding:10px 15px;">
          <i class="zmdi zmdi-globe"></i> Open
        </a>
      </div>
    </div>
    
  </xsl:template>

  
  
</xsl:stylesheet>

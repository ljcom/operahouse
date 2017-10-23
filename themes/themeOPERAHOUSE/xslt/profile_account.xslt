<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:template match="/">

    <div class="wrap ms-hero-img-coffee  ms-bg-fixed ms-hero-bg-primary">
      <div class="container">
        <h1 class="color-white text-center mb-4">Your Account</h1>
        <div class="row">
          <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row"/>
        </div>
        <div class="text-center color-white mw-800 center-block mt-4">
          <p class="lead lead-lg">Need a new account for other companies?</p>
          <a href="javascript:void(0)" class="btn btn-raised btn-white color-info wow flipInX animation-delay-8">
            <i class="fa fa-plus"></i> ADD MORE
          </a>
        </div>
      </div>
    </div>


  </xsl:template>

  <!--package section-->
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

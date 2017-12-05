<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:template match="/">

    <div class="">
      <div class="container">
        <div class="text-center">
          <h2 class="no-m ms-site-title color-primary center-block ms-site-title-lg mt-2 animated zoomInDown animation-delay-5">
            <xsl:value-of select ="/sqroot/header/info/title/."/>
          </h2>
          <p class="lead lead-lg color-default text-center center-block mt-2 mb-2 mw-800 text-uppercase fw-300 animated fadeInUp animation-delay-7">
            <xsl:value-of select ="/sqroot/header/info/code/additionalDesc/."/>
          </p>
        </div>
        <div class="row">
          <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row"/>
          
          <div class="col-md-4 col-sm-6">
            <div style="min-height:300px;padding-top:35%; text-align:center" >
              <a href="index.aspx?env=front&amp;code=Account&amp;GUID=00000000-0000-0000-0000-000000000000" class="btn btn-raised btn-white color-info wow flipInX animation-delay-5">
                <i class="fa fa-plus"></i> CREATE NEW ACCOUNT
              </a>
            </div>

          </div>
        </div>
        <!--<div class="text-center color-white mw-800 center-block mt-4">
          <p class="lead lead-lg">Need a new account for other companies?</p>
          <a href="index.aspx?env=front&amp;code=Account&amp;GUID=00000000-0000-0000-0000-000000000000" class="btn btn-raised btn-white color-info wow flipInX animation-delay-8">
            <i class="fa fa-plus"></i> CREATE NEW ACCOUNT
          </a>
        </div>-->
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
          <a href="{fields/field[@caption = 'pageURL']/.}" target="new" class="btn btn-primary btn-raised">
            <i class="zmdi zmdi-globe"></i> Go To
          </a>
        </div>
      </div>
    </div>
    <!-- item -->

  </xsl:template>




</xsl:stylesheet>

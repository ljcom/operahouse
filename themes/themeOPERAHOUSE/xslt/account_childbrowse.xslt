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
        </div>
        <!--<div class="text-center color-white mw-800 center-block mt-4">
          <p class="lead lead-lg">To complete your company's needs.</p>
          <a href="javascript:void(0)" class="btn btn-raised btn-white color-info wow flipInX animation-delay-8">
            <i class="fa fa-space-shuttle"></i> GET MORE
          </a>
        </div>-->
      </div>
    </div>

    <div class="modal modal-primary" id="childmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel6">
      <div class="modal-dialog animated zoomIn animated-3x" role="document">
        <div class="modal-content">
          <div id="childmodalcontent">
            
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <!--package section-->
  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
 
    <div class="col-lg-4 col-md-4 col-sm-6">
      <div class="card card-info card-block text-center wow zoomInUp animation-delay-3">
        <!--<p class="counter">
          <xsl:value-of select ="fields/field[@caption = 'NoOfUsers']/."/> Users
        </p>-->
        <span class="ms-icon ms-icon-sm" style="position:absolute; top:0px; right:10px;" title="delete" onclick="executeFunction('{/sqroot/header/info/code/id/.}', '{@GUID}', 'delete', '')">
          <i class="fa fa-close"></i> 
        </span>
        <!--<a href="javascript:void(0)" class="btn-circle btn-circle-sm btn-circle-primary" style="position:absolute; top:-10px; right:10px;">
          <i class="fa fa-delete"></i> test
        </a>-->
        <!--<i class="fa fa-4x fa-microchip"></i>-->
        <h4 class="mt-2 no-mb" style="height:50px; font-weight:bold;">
          
            <xsl:value-of select ="fields/field[@caption = 'Package']/."/>
          
        </h4>
        <h4 class="mt-2 no-mb" style="height:30px;">

          <xsl:value-of select ="fields/field[@caption = 'PackagePrice']/."/>

        </h4>
        <!--<a href="javascript:void(0)" data-toggle="modal" data-target="#childmodal">
          <i class="zmdi zmdi-edit"></i> Change Plan
        </a>-->
        <a href="javascript:void(0)" class="btn btn-primary btn-raised" style="padding:10px 15px;" onclick="LoadNewPartView('account_childbrowse_modal', 'childmodalcontent', 'accountdetail', '{@GUID}');" data-toggle="modal" data-target="#childmodal">
          <i class="zmdi zmdi-globe"></i> Change Plan
        </a>
      </div>
    </div>
    
  </xsl:template>


  
  
</xsl:stylesheet>

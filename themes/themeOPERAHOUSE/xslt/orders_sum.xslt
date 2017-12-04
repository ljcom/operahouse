<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:template match="/">

    <div class="card card-default animated fadeInUp animation-delay-7">
      <div class="card-header" style="background:#EFE9F4">
        <i class="fa fa-list-alt" aria-hidden="true"></i>
        <xsl:value-of select ="/sqroot/header/info/code/name/."/>
      </div>
      <div class="card-block">
          <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row"/>
       
        <!--<h3>
                  <strong>Total:</strong>
                  <span class="color-success">$2456.45</span>
                </h3>-->
        <a href="javascript:void(0)" class="btn btn-raised btn-primary btn-block btn-raised mt-2 no-mb">
          <i class="zmdi zmdi-shopping-cart-plus"></i> Purchase
        </a>
      </div>
    </div>
  </xsl:template>



  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
    <ul class="list-unstyled">
      <xsl:apply-templates select="fields/field"/>
    </ul>
  </xsl:template>


  <xsl:template match="fields/field">
    <li>
      <strong> <xsl:value-of select ="@title"/> : </strong>
      <xsl:value-of select ="."/>
    </li>
  </xsl:template>



</xsl:stylesheet>

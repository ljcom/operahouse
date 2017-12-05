<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:template match="/">

    <div class="container mt-4">
      <div class="card card-primary animated fadeInUp animation-delay-7">
        <div class="row" style="padding:0 40px;">
          <div class="text-center">
            <h2 class="no-m ms-site-title color-primary center-block ms-site-title-lg mt-2 animated zoomInDown animation-delay-5">
              <xsl:value-of select ="/sqroot/header/info/title/."/>
            </h2>
            <p class="lead lead-lg color-default text-center center-block mt-2 mb-2 mw-800 text-uppercase fw-300 animated fadeInUp animation-delay-7">
              <xsl:value-of select ="/sqroot/header/info/code/additionalDesc/."/>
            </p>
          </div>
          <div class="bs-example mt-4">
            <div class="table-responsive">
              <div class="card">
                <table class="table table-condensed ">
                  <thead>
                    <tr>
                      <xsl:apply-templates select="sqroot/body/bodyContent/browse/header/column"/>
                      <th  style="background:#03A9F4; color:#FFF; width:200px; text-align:center">Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row"/>
                  </tbody>
                </table>
              </div>
            </div>
            <!-- /.table-responsive -->
          </div>
        </div>
      </div>
     
      
    </div>


  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/header/column">
    <th style="background:#03A9F4; color:#FFF;">
      <xsl:value-of select ="titleCaption/."/>
    </th>
  </xsl:template>


  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
    <tr>
      <xsl:apply-templates select="fields/field"/>
      <td align="center">
        <a href="javascript:void(0)" class="btn-circle btn-circle-s btn-circle-primary" onclick="" title="VIEW TRANSACTION">
          <i class="fa fa-search-plus"></i>
        </a>
        <a href="javascript:void(0)" class="btn-circle btn-circle-s btn-circle-primary" onclick="" title="PRINT">
          <i class="fa fa-print"></i>
        </a>
      </td>
    </tr>
  </xsl:template>


  <xsl:template match="fields/field">
    <td>
      <xsl:value-of select ="."/>
    </td>
  </xsl:template>



</xsl:stylesheet>

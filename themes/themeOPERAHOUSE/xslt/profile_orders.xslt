<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:template match="/">

    <div class="container mt-4">
      <div class="card card-primary animated fadeInUp animation-delay-7">
        <div class="row" style="padding:30px;">
          <h2 class="color-primary text-center mb-4">HISTORY ORDERS</h2>
          <div class="bs-example mt-4">
            <div class="table-responsive">
              <div class="card">
                <table class="table table-condensed ">
                  <thead>
                    <tr>
                      <xsl:apply-templates select="sqroot/body/bodyContent/browse/header/column"/>
                      <th  style="background:#03A9F4; color:#FFF; width:200px;">Action</th>
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
      <td></td>
    </tr>
  </xsl:template>


  <xsl:template match="fields/field">
    <td>
      <xsl:value-of select ="."/>
    </td>
  </xsl:template>



</xsl:stylesheet>

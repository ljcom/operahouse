<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:template match="/">

    
      <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row"/>
      
   
  </xsl:template>


  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
    <xsl:if test="(fields/field[@caption = 'sectionAlign']/.)='1 - Right'">
      <section class="wrap mt-6 wow fadeInUp animation-delay-4" style="padding:0">
        <div class="container">
          <div class="panel-body">
            <div class="tab-content mt-4">
              <div class="row">
                <div class="col-md-6 col-lg-5 col-md-push-6 col-lg-push-7">
                  <ul class="list-unstyled hand-list">
                    <li class="animated fadeInLeft animation-delay-2 ">
                      <xsl:apply-templates select="fields/field[@caption != 'sectionImg']"/>
                    </li>
                  </ul>
                </div>
                <div class="col-md-6 col-lg-7 col-md-pull-6 col-lg-pull-5">
                  <xsl:apply-templates select="fields/field[@caption = 'sectionImg']"/>

                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </xsl:if>
    <xsl:if test="(fields/field[@caption = 'sectionAlign']/.)='2 - Left'">
      <section class="wrap mt-6 wow fadeInUp animation-delay-4" style="padding:0">
        <div class="container" >
          <div class="panel-body">
            <div class="tab-content mt-4">
              <div class="row">
                <div class="col-md-6 col-lg-7 col-md-push-6 col-lg-push-5">
                  <xsl:apply-templates select="fields/field[@caption = 'sectionImg']"/>
                </div>
                <div class="col-md-6 col-lg-5 col-md-pull-6 col-lg-pull-7">
                  <ul class="list-unstyled hand-list">
                    <li class="animated fadeInLeft animation-delay-2">
                      <xsl:apply-templates select="fields/field[@caption != 'sectionImg']"/>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </xsl:if>

  </xsl:template>


  <xsl:template match="fields/field">
    <xsl:choose>
      <xsl:when test="@caption = 'sectionTitle'">
          <h2 class="no-mt color-primary no-mb"><xsl:value-of select ="."/></h2>
      </xsl:when>
      <xsl:when test="@caption = 'sectionDescription'">
        <p>
          <xsl:value-of select ="."/>
        </p>
      </xsl:when>
      <xsl:when test="@caption = 'sectionText'">
        <p style="color:#938f8f; text-align:justify">
          <xsl:value-of select ="."/>
        </p>
      </xsl:when>
    
    </xsl:choose>
  </xsl:template>


  <xsl:template match="fields/field[@caption = 'sectionImg']">
    <img class="img-responsive animated zoomInDown animation-delay-3" src="{.}" />
  </xsl:template>
  
</xsl:stylesheet>

<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
    <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row" />
  </xsl:template>
  
  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
    <!--image src-->
    <xsl:choose>
      <xsl:when test="(fields/field[@caption = 'PARNBRANGUID']/.) ='a' ">
        
      </xsl:when>
      <xsl:otherwise>
        <div class="panel top-menu-onphone" style="border-radius:0; margin-top:0;">
          <!--<a class="top-envi" data-toggle="collapse" data-parent="#accordion2" href="{pageURL/.}">-->
          <a class="top-envi" data-toggle="collapse" href="{pageURL/.}">
            <!--<ix>
              <img src="{icon/img/.}" style="width:15px; margin-right:8px;" />
            </ix>-->
            <span style="margin-right:10px; font-size:9px;">➤</span>
            <xsl:value-of select="fields/field[@caption = 'Name']/." />
          </a>
        </div>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>
</xsl:stylesheet>

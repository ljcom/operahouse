<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
    <span style="border-bottom:1px solid white; padding-bottom:5px;" id="theLimit">Remaining limit : Rp. <xsl:value-of select="format-number(sqroot/body/bodyContent/browse/content/row/fields/field[@caption = 'limit']/., '#,##0', 'dot-dec')"/></span>
    <br/>
  </xsl:template>

</xsl:stylesheet>

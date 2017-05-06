<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  <xsl:template match="/">
    <xsl:apply-templates select="sqroot"/>
  </xsl:template>

  <xsl:template match="sqroot">
    <xsl:apply-templates select="option"/>
  </xsl:template>

  <xsl:template match="option">
    <option value="{value}">
      <xsl:value-of select="caption"/>
    </option>
  </xsl:template>


</xsl:stylesheet>

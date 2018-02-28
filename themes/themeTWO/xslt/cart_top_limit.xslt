<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />


  <xsl:template match="/">
    <!--<span style="border-bottom:1px solid white; padding-bottom:5px;" id="theLimit">
      Remaining limit : Rp. 
      <xsl:value-of select="format-number(sqroot/body/bodyContent/browse/content/row/fields/field[@caption = 'limit']/., '#,##0', 'dot-dec')"/>
    </span>
    <br/>-->
    <!--<span style="padding-bottom:5px;" id="theLimit">
      <a href=".limit-modal" data-toggle="modal" style=" font-size:12px; padding:0; margin:0;">
        Check Your Remaining Limit Here >>
      </a>
    </span>-->
    <table class="table">
      <thead>
        <tr>
          <xsl:apply-templates select="sqroot/body/bodyContent/browse/header/column" />
        </tr>
      </thead>
      <tbody>
        <tr>
          <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row" />
        </tr>
      </tbody>
    </table>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/header/column">

    <xsl:choose>
      <xsl:when test="(/sqroot/header/custompermissions/custompermission/allowchangepayment/.) = 0">
        <xsl:if test="(@fieldName)!='limitPointBalance'">
          <th style="width:{@width}px;  background:#47BAC1; color:white;">
            <xsl:value-of select="translate(titleCaption/., $smallcase, $uppercase)" />
          </th>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <th style="width:{@width}px;  background:#47BAC1; color:white;">
          <xsl:value-of select="translate(titleCaption/., $smallcase, $uppercase)" />
        </th>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>


  <xsl:template match="sqroot/body/bodyContent/browse/content/row">

    <tr>
      <xsl:apply-templates select="fields/field" />
    </tr>

  </xsl:template>

  <xsl:template match="fields/field">
    <xsl:variable name="tbContent">
      <xsl:choose>
        <xsl:when test="@digit = 0 and .!=''">
          <xsl:value-of select="format-number(., '#,##0', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 1 and .!=''">
          <xsl:value-of select="format-number(., '#,##0.0', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 2 and .!=''">
          <xsl:value-of select="format-number(., '#,##0.00', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 3 and .!=''">
          <xsl:value-of select="format-number(., '#,##0.000', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 4 and .!=''">
          <xsl:value-of select="format-number(., '#,##0.0000', 'dot-dec')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="(/sqroot/header/custompermissions/custompermission/allowchangepayment/.) = 0">
        <xsl:if test="(@caption)!='limitPointBalance'">
          <td>
            <xsl:value-of select="$tbContent" />
          </td>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <td>
          <xsl:value-of select="$tbContent" />
        </td>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

</xsl:stylesheet>

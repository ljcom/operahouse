<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
      <h4>Unpaid Orders</h4>
      <div class="table-responsive">
        <table class="table">
          <thead>
            <tr>
                <xsl:apply-templates select="sqroot/body/bodyContent/browse/header/column" />
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row" />
          </tbody>
        </table>
      </div>
       

  </xsl:template>
   <xsl:template match="sqroot/body/bodyContent/browse/header/column">
    <th style="width:{@width}px">
      <xsl:value-of select="translate(., $smallcase, $uppercase)" />
    </th>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
    <tr>
      <xsl:apply-templates select="fields/field" />
      <td>
        <a href="#" class="btn btn-default" onclick="location.href='index.aspx?env=front&amp;code=tapcs1&amp;GUID={@GUID}';">View</a>
        <a href="#" class="btn btn-default"  onclick="deleteRow('tapcso', '{@GUID}');">Delete</a>
      </td>
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
    <td>
       <xsl:choose>
        <xsl:when test="(@caption)='customstat' and (.) = 'Pending'">
         <span class="label label-warning"><xsl:value-of select="." /></span>
        </xsl:when>
        <xsl:when test="(@caption)='customstat' and (.) = 'Approved'">
         <span class="label label-success"><xsl:value-of select="." /></span>
        </xsl:when>
        <xsl:when test="(@caption)='customstat' and (.) = 'Rejected'">
         <span class="label label-danger"><xsl:value-of select="." /></span>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$tbContent" />
        </xsl:otherwise>
      </xsl:choose>
    </td>
  </xsl:template>
</xsl:stylesheet>

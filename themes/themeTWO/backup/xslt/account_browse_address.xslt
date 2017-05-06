<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
   <div class="col-xs-12">
      <div class="innerWrapper">
        <div class="orderBox myAddress">
          <h4>My Address</h4>
          <div class="table-responsive">
            <table class="table">
              <thead>
                <tr>
                  <xsl:apply-templates select="sqroot/body/bodyContent/browseaddr/header/column[@mandatory=0]" />
                  <th>ACTION</th>
                </tr>
              </thead>
              <tbody>
                <xsl:apply-templates select="sqroot/body/bodyContent/browseaddr/content/row" />
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>   
   

  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browseaddr/header/column[@mandatory=0]">
    <th style="width:{@width}px">
      <xsl:value-of select="translate(., $smallcase, $uppercase)" />
    </th>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browseaddr/content/row">
    <tr>
      <xsl:apply-templates select="field" />
      <td>
        <div class="btn-group" role="group">
          <button type="button" class="btn btn-default">
            <ix class="fa fa-pencil" aria-hidden="true"></ix>
          </button>
          <button type="button" class="btn btn-default">
            <ix class="fa fa-times" aria-hidden="true"></ix>
          </button>
        </div>
      </td>
    </tr>
                 
  </xsl:template>
  <xsl:template match="field">
    <td>
      <xsl:value-of select="." />
    </td>
  </xsl:template>
</xsl:stylesheet>

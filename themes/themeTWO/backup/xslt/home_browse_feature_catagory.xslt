﻿<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
  
  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>
  
  <xsl:template match="/">
    <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row" />
    <script>
      var cartid = getCookie('cartID');
      $(".cartidclass" ).val(cartid);
    </script>
  </xsl:template>
  

  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
    <xsl:choose>
      <xsl:when test="(@code)='ctgrfron'">
        <li>
          <a href="?code=maprodfron&amp;bSearchText={@GUID}">
            <xsl:value-of select="fields/field[@caption = 'Name']/."/>
          </a>
        </li>
      </xsl:when>
      <xsl:when test="(@code)='maprodfron'">
        <div class="imageBox">
          <div class="productImage clearfix">
            <a href="single-product.html">
              <div style="height:150px; text-align:center;">
                <img style="max-height:130px;; width:auto; margin:0 auto;" src="{fields/field[@caption = 'productphotos']/.}" alt="Image" />
              </div>
            </a>
            <div class="productMasking">
              <ul class="list-inline btn-group" role="group" style="text-align:center">
                <!--<li><a data-toggle="modal" href=".login-modal" class="btn btn-default"><ix class="fa fa-heart"></ix></a></li>-->
                <li>
                  <form method="post" id="productform_{@GUID}">
                    <!--untuk insert dipaksa ada input-->
                    <input type="hidden" id="cartID" class="cartidclass" name="cartID" value="" />
                    <input type="hidden" name="Availaible" value="1" />
                    <input type="hidden" name="EVENPSKUGUID" value="{@GUID}" />
                    <input type="hidden" value="{fields/field[@caption = 'PRODGUID']/.}" name="PRODGUID"/>
                    <input type="hidden" name="price" value="{fields/field[@caption = 'price']/.}" />
                    <a onclick="AddToCart('{../../info/code/.}', 'productform_{@GUID}')" class="btn btn-default">
                      <ix class="fa fa-shopping-cart"></ix>
                    </a>
                  </form>
                </li>
                <li>
                  <a data-toggle="modal" href="index.aspx?code=maprodfron&amp;GUID={@GUID}" class="btn btn-default">
                    <ix class="fa fa-search"></ix>
                  </a>
                </li>
              </ul>
            </div>
          </div>
          <div class="productCaption clearfix">
            <a href="index.aspx?code=maprodfron&amp;GUID={@GUID}">
              <h5 style="height:30px;">
                <xsl:value-of select="fields/field[@caption = 'ID']/." /> - <xsl:value-of select="fields/field[@caption = 'Name']/." /><br />
              </h5>
            </a>
            <!--<p style="margin:0; padding:0;">
            Code : <xsl:value-of select="fields/field[@caption = 'ID']/." />
            </p>-->
            <p style="margin:0; padding:0;">
              Division : <xsl:value-of select="fields/field[@caption = 'divisionName']/." />
            </p>
            <h3>Rp. <xsl:value-of select="format-number(fields/field[@caption = 'price']/., '#,##0', 'dot-dec')" /> </h3>
          </div>
        </div>
    
      </xsl:when>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>

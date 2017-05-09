﻿<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>
  
  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
    <script>
       setCookie("browsetype", "browse", 0, 1, 0);
    </script>
    <div class="row">
      <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row" />
    </div>

    <div  class="row">
      <div class="col-xs-12">
        <ul class="pagination pagination-sm" id="paginationprod">
          <script>
            createPaging('<xsl:value-of select="sqroot/body/bodyContent/browse/info/TotalRows/." />', 'product', 'contentBrowse');
          </script>
        </ul>
      </div>
    </div>

    <script>
      var cartid = getCookie('cartID');
      $(".cartidclass" ).val(cartid);
    </script>
  </xsl:template>
  
  <!--Data Content-->
  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
    <!--image src-->
    <xsl:variable name="imageprod">
      <xsl:value-of select="fields/field[@caption = 'productphotos']/." />
    </xsl:variable>
    
    <div class="col-sm-4 col-xs-12">
      <div class="productBox">
        <div class="productImage clearfix">
          <div style="height:250px; text-align:center">
            <img style="max-height:200px;  width: auto;" src="{$imageprod}" alt="products-img" class="productgridimage"/>
          </div>
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
                  <a onclick="AddToCart('{../../info/code/.}', 'productform_{@GUID}')" class="btn btn-default" >
                    <ix class="fa fa-shopping-cart"></ix>
                  </a>
                </form>
               
              </li>
              <!--<li><a class="btn btn-default" data-toggle="modal" href=".quick-view" ><ix class="fa fa-eye"></ix></a></li>-->
              <li><a class="btn btn-default"  href="index.aspx?code=maprodfron&amp;GUID={@GUID}" ><ix class="fa fa-eye"></ix></a></li>
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
          <xsl:choose>
            <xsl:when test="(fields/field[@caption = 'evenname']/.)!='Website online'">
              <span class="sticker"><xsl:value-of select="fields/field[@caption = 'evenname']/." /></span>
            </xsl:when>
          </xsl:choose>

          <xsl:choose>
            <xsl:when test="(fields/field[@caption = 'evenname']/.)!='Website online'">
              <span class="sticker">
                <xsl:value-of select="fields/field[@caption = 'evenname']/." />
              </span>
            </xsl:when>
          </xsl:choose>
          <xsl:choose>
            <xsl:when test="(fields/field[@caption = 'discount']/.)!= '0'">
              <span class="sticker" style="top:30px; font-size:18px; padding:5px 5px;">
                <xsl:value-of select="fields/field[@caption = 'discount']/." />% OFF
              </span>
            </xsl:when>
          </xsl:choose>
          <div style="height:40px;">
            <!--<xsl:choose>
              <xsl:when test="(fields/field[@caption = 'discount']/.)!= '0'">
                <h3 style="text-decoration:line-through; font-size:12px;">Rp. <xsl:value-of select="format-number(fields/field[@caption = 'price']/., '#,##0', 'dot-dec')" /></h3>
                <h3 style="font-size:20px;">Rp. <xsl:value-of select="format-number(fields/field[@caption = 'priceDiscount']/., '#,##0', 'dot-dec')" /></h3>
              </xsl:when>
              <xsl:otherwise>
                <h3 style="font-size:20px;">Rp. <xsl:value-of select="format-number(fields/field[@caption = 'price']/., '#,##0', 'dot-dec')" /></h3>
              </xsl:otherwise>
            </xsl:choose>-->
            <h3 style="font-size:20px;">
              Rp. <xsl:value-of select="format-number(fields/field[@caption = 'price']/., '#,##0', 'dot-dec')" />
            </h3>
          </div>
        </div>
      </div>
    </div>

  </xsl:template>

</xsl:stylesheet>
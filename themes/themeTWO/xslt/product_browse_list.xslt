<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>


  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
    <script>
      setCookie("browsetype", "browse_list", 0, 1, 0);
    </script>
    <div class="row productListSingle">
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

  <!--SIDEBAR CATAGORY-->
  <xsl:template match="sqroot/header/menus/menu[@code='categories']/submenus/submenu">
    <div class="panel top-menu-onphone" style="border-radius:0; margin-top:0;">
      <!--<a class="top-envi" data-toggle="collapse" data-parent="#accordion2" href="{pageURL/.}">-->
      <a class="top-envi" data-toggle="collapse" href="{pageURL/.}">
        <ix>
          <img src="{icon/img/.}" style="width:15px; margin-right:8px;" />
        </ix>
        <xsl:value-of select="caption/." />
        <xsl:choose>
          <xsl:when test="(@mode)='treeroot'">
            <span class="fa fa-plus" style="position:absolute; right:15px; top:18px; font-size:12px; color:#4c4c4c"></span>
          </xsl:when>
        </xsl:choose>
      </a>
      <xsl:choose>
        <xsl:when test="(@mode)='treeroot'">
          <div id="{id/.}" class="panel-collapse collapse">
            <ul>
              <xsl:apply-templates select="submenus/submenu[@mode='treeview']" />
            </ul>
          </div>
        </xsl:when>
      </xsl:choose>
    </div>
  </xsl:template>

  <!--SIDEBAR BRAND-->
  <xsl:template match="sqroot/header/menus/menu[@code='brand']/submenus/submenu">
    <div class="panel top-menu-onphone" style="border-radius:0; margin-top:0;">
      <!--<a class="top-envi" data-toggle="collapse" data-parent="#accordion2" href="{pageURL/.}"  >-->
      <a class="top-envi" data-toggle="collapse" href="{pageURL/.}">
        <span href="#" title="{link/.}" onclick="goToRef(this, '{link/.}')">
          <ix>
            <img src="{icon/img/.}" style="width:15px; margin-right:8px;" />
          </ix>
          <xsl:value-of select="caption/." />
          <br />
          <span style="margin-left:24px;">
            <xsl:value-of select="link/." />
            <br />
          </span>
        </span>
        <xsl:choose>
          <xsl:when test="(@mode)='treeroot'">
            <span class="fa fa-plus" style="position:absolute; right:15px; top:30px; font-size:12px; color:#4c4c4c" ></span>
          </xsl:when>
        </xsl:choose>
      </a>
      <div id="{id/.}" class="panel-collapse collapse">
        <ul>
          <xsl:apply-templates select="submenus/submenu[@mode='treeview']" />
        </ul>
      </div>
    </div>
  </xsl:template>

  <!--SIDEBAR Treeview-->
  <xsl:template match="submenus/submenu[@mode='treeview']">
    <xsl:choose>
      <xsl:when test="submenus!=''">
        <li>
          <a data-toggle="collapse" href="{pageURL/.}" class="top-envi-lv2">
            <span style="margin-right:10px; font-size:9px;">➤</span>
            <xsl:value-of select="caption/." />
            <xsl:choose>
              <xsl:when test="submenus!=''">
                <span class="fa fa-plus" style="position:absolute; right:15px; top:16px;"></span>
              </xsl:when>
            </xsl:choose>
          </a>
          <xsl:choose>
            <xsl:when test="submenus!=''">
              <div id="{id/.}" class="panel-collapse collapse">
                <ul>
                  <xsl:apply-templates select="submenus/submenu[@mode='treeview']" />
                </ul>
              </div>
            </xsl:when>
          </xsl:choose>
        </li>
      </xsl:when>
      <xsl:otherwise>
        <li>
          <a href="{pageURL/.}">
            <span style="margin-right:10px; font-size:9px;">➤</span>
            <xsl:value-of select="caption/." />
          </a>
        </li>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
   <!--Data Content-->
  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
    <!--image src-->
    <xsl:variable name="imageprod">OPHContent/documents/kitashop/<xsl:value-of select="fields/field[@caption = 'productphotos']/." />
    </xsl:variable>
    
    <div class="col-xs-12">
      <div class="media">
        <div class="media-left">
          <div style="height:200px; text-align:center">
            <img style="height:90%;  width: auto; margin:0 auto;" class="media-object" src="{$imageprod}" alt="Image" onerror="this.src='ophcontent/themes/themeTWO/images/white.png'" />
          </div>
          <span class="maskingImage"><a href="index.aspx?env=front&amp;code=maprodfron&amp;GUID={@GUID}" class="btn viewBtn">View</a></span>
        </div>
        <div class="media-body">
          <h4 class="media-heading"><a href="index.aspx?env=front&amp;code=maprodfron&amp;GUID={@GUID}">
            <xsl:value-of select="fields/field[@caption = 'ID']/." /> - <xsl:value-of select="fields/field[@caption = 'Name']/." /></a>
          </h4>
          <!--<p style="margin:0; padding:0;">
            Code : <xsl:value-of select="fields/field[@caption = 'ID']/." />
          </p>-->
          <p style="margin:0; padding:0;">
            <!--Division : <xsl:value-of select="fields/field[@caption = 'divisionName']/." />-->
            Sign : <xsl:value-of select="fields/field[@caption = 'SignatureName']/." />
          </p>
          <xsl:choose>
            <xsl:when test="(fields/field[@caption = 'evenname']/.)!='Website online'">
              <span class="sticker"><xsl:value-of select="fields/field[@caption = 'evenname']/." /></span>
            </xsl:when>
          </xsl:choose>
           <!--<xsl:choose>
            <xsl:when test="(fields/field[@caption = 'discount']/.)!= '0'">
               <span class="sticker" style="top:30px; font-size:18px; padding:5px 5px;"><xsl:value-of select="fields/field[@caption = 'discount']/." />% OFF</span>
            </xsl:when>
          </xsl:choose>-->
          <p><xsl:value-of select="fields/field[@caption = 'Description']/." /></p>
          <div style="height:40px;">
            <xsl:choose>
              <xsl:when test="(fields/field[@caption = 'discount']/.)!= '0'">
                <span style="text-decoration:line-through; font-size:12px; margin:0">Rp. <xsl:value-of select="format-number(fields/field[@caption = 'price']/., '#,##0', 'dot-dec')" /></span><br />
                <!--<h3 style="font-size:20px; margin:0">Rp. <xsl:value-of select="format-number(fields/field[@caption = 'priceDiscount']/., '#,##0', 'dot-dec')" /></h3>-->
                <span style="font-size:20px;">
                  Rp. <xsl:value-of select="format-number(fields/field[@caption = 'priceDiscount']/., '#,##0', 'dot-dec')" />
                   <span style="font-size:12px; color:white; padding:5px; margin-top:-30px !important; margin-left:10px; background:#47bac1;"><xsl:value-of select="fields/field[@caption = 'discount']/." />%</span><br />
                
                </span>
                
              </xsl:when>
               <xsl:when test="(fields/field[@caption = 'price']/.) != (fields/field[@caption = 'priceDiscount']/.)">
                 <span style="text-decoration:line-through; font-size:12px; margin:0">Rp. <xsl:value-of select="format-number(fields/field[@caption = 'price']/., '#,##0', 'dot-dec')" /></span><br />
                <!--<h3 style="font-size:20px; margin:0">Rp. <xsl:value-of select="format-number(fields/field[@caption = 'priceDiscount']/., '#,##0', 'dot-dec')" /></h3>-->
                <span style="font-size:20px;">
                  Rp. <xsl:value-of select="format-number(fields/field[@caption = 'priceDiscount']/., '#,##0', 'dot-dec')" />
                </span>
              </xsl:when>
              <xsl:otherwise>
                <span style="font-size:20px; margin:0">Rp. <xsl:value-of select="format-number(fields/field[@caption = 'price']/., '#,##0', 'dot-dec')" /></span>
              </xsl:otherwise>
            </xsl:choose>
            <!--<h3 style="font-size:20px; margin:0">Rp. <xsl:value-of select="format-number(fields/field[@caption = 'price']/., '#,##0', 'dot-dec')" /></h3>-->
          </div>
          <div class="btn-group" role="group">
            <form method="post" id="productform_{@GUID}">
              <!--untuk insert dipaksa ada input-->
              <input type="hidden" class="cartidclass" name="cartID" value="" />
              <input type="hidden" name="Availaible" value="1" />
              <input type="hidden" name="EVENPSKUGUID" value="{@GUID}" />
              <input type="hidden" value="{fields/field[@caption = 'PRODGUID']/.}" name="PRODGUID"/>
              <input type="hidden" name="price" value="{fields/field[@caption = 'price']/.}" />
              <a onclick="AddToCart('{../../info/code/.}', 'productform_{@GUID}')" class="btn btn-default">
                <span style="font-size:20px;"><ix class="fa fa-shopping-cart"></ix></span>
              </a>
            </form>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>
  
</xsl:stylesheet>

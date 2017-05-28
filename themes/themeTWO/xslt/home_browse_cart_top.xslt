<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
    <div id="LimitUsers" class="hidden-xs" style="margin-top:-18px;"> &#xA0; </div>
    <a href="#" class="dropdown-toggle shop-cart" data-toggle="dropdown" style="">
      <ix class="fa fa-shopping-cart" style="border-left:white solid 5px; z-index:-1px">&#xA0;
        <!--<span id="totalcart" style="position:absolute; top:2px; background:red; left:30px; font-size:10px; width:10px; text-align:center; padding:2px;">0</span>-->
      </ix>
      <span class="hidden-xs">
        <span id="cartTotalQty" class="cart-total">Your Cart (0)</span>
        <br/>
        <span id="cartTotalSales" class="cart-price "> Rp. 0</span>
        
        <br/>
      </span>
    </a>
    <ul class="dropdown-menu dropdown-menu-right">
      <li>
        <span id="LimitUser"> &#xA0; </span><br/>
        Item(s) in your carts
      </li>
      <script>
        var hostGUIDcek = '<xsl:value-of select="sqroot/header/info/user/hostGUID/." />';
        var hostGUID = "hostGUID = '<xsl:value-of select="sqroot/header/info/user/hostGUID/." />'";
        if (hostGUIDcek != ''){
        LoadNewPart('cart_top_limit', 'LimitUser', 'causerlimt', hostGUID, '', '', '');
        }
      </script>
      <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row"/>
      <li>
        <div class="btn-group" role="group" aria-label="..." id="buttoncarttop" >
          <a href="" id="carttop_Shopping" style="background:#f4f4f4; width:125px; padding:5px; color:black; text-align:center; font-size:14px;">Shopping Cart</a>
          <a href="" id="carttop_Checkout"  class="needlogin" data-toggle="modal" style="background:#f4f4f4; width:125px; padding:5px; color:black; text-align:center; font-size:14px;">Checkout</a>
          <script>
            var cartID = getCookie("cartID");
            document.getElementById("carttop_Shopping").href = 'index.aspx?env=front&amp;code=tapcs1&amp;GUID='+cartID;
            document.getElementById("carttop_Checkout").href = 'index.aspx?env=front&amp;code=tapcs2&amp;GUID='+cartID;
            var TotalSales = '<xsl:value-of select="sqroot/body/bodyContent/browse/content/row/fields/field[@caption = 'TotalSales']" />';
            var FTotalSales = '<xsl:value-of select="format-number(sqroot/body/bodyContent/browse/content/row/fields/field[@caption = 'TotalSales'], '#,##0', 'dot-dec')" />';
            var TotalQty = '<xsl:value-of select="sqroot/body/bodyContent/browse/content/row/fields/field[@caption = 'TotalQty']" />';
            var FTotalQty = '<xsl:value-of select="format-number(sqroot/body/bodyContent/browse/content/row/fields/field[@caption = 'TotalQty'], '#,##0', 'dot-dec')" />';

            if(TotalSales != '' &amp;&amp; TotalQty != ''){
            document.getElementById("cartTotalSales").innerHTML = 'Rp. '+FTotalSales;
            document.getElementById("cartTotalQty").innerHTML = 'Your Cart ('+FTotalQty+')';

            if (getCookie("isLogin") == "0"){
            $('.needlogin').attr('href','.login-modal')
            }
            document.getElementById("totalcart").innerHTML = $('.itemincart').length;



            }

          </script>
          <!--<button type="button" class="btn btn-default" onclick="location.href='?code=pcs1=GUID={sqroot/body/bodyContent/browse/content/row[@GUID]}';">Shopping Cart</button>
        <button type="button" class="btn btn-default" onclick="location.href='checkout-step-1.html';">Checkout</button>-->
        </div>
      </li>
    </ul>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
    <li>
      <a href="?code=maprodfron&amp;GUID={fields/field[@caption = 'EVENPSKUGUID']/.}">
        <div class="media">
          <div style="height:50px; width:50px; float:left; margin-right:10px; overflow:hidden; text-align:center; background:white; border:2px solid #37acb2; ">
            <img style="max-height:35px; margin-top:5px; width: auto;" src="OPHContent/documents/{/sqroot/header/info/account/.}/{fields/field[@caption = 'productphotos']}" onerror="this.src='ophcontent/themes/themeTWO/images/white.png'" alt="products-img" />
          </div>
          <div class="media-body">
            <h5 class="media-heading itemincart" style="width:200px; overflow-wrap: break-word;">
              <span style="font-size:12px;">
                <xsl:value-of select="fields/field[@caption = 'productname']"/>
              </span>
              <br/>
              <span style="font-size:10px;">
                items (<xsl:value-of select="fields/field[@caption = 'Qty']"/>) <br/>
                Rp. <span>
                  <xsl:value-of select="format-number(fields/field[@caption = 'TotalPrice']/., '#,##0', 'dot-dec')" />
                </span>
              </span>
            </h5>
          </div>
        </div>
      </a>
    </li>
  </xsl:template>
</xsl:stylesheet>

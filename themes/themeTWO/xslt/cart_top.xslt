<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
    <a href="javascript:void(0)" class="dropdown-toggle" data-toggle="dropdown">
      <span style="margin-right:5px; font-size:18px;">
        <ix class="fa fa-shopping-cart">
          <span id="totalcart" style="position:absolute; top:2px; background:red; left:30px; font-size:10px; width:10px; text-align:center; padding:2px; display:none;">0</span>
        </ix>
        
      </span>
      <span class="hidden-xs" id="cartTotalSales"> Rp. 0 </span>
      
    </a>
  
    <ul class="dropdown-menu dropdown-menu-right">
      <li>
        <script>
          var hostGUIDcek = '<xsl:value-of select="sqroot/header/info/user/hostGUID/." />';
          var hostGUID = "hostGUID = '<xsl:value-of select="sqroot/header/info/user/hostGUID/." />'";
          if (hostGUIDcek != ''){
          function runloadnewpart() {
          LoadNewPart('cart_top_limit', 'limitmodalbody', 'causerlimt', hostGUID, '', '', '');
          }
          }
        </script>
        <xsl:if test="sqroot/header/info/user/hostGUID/. != ''">
          <a href=".limit-modal" data-toggle="modal" style=" font-size:12px; padding:0; margin:0;" onclick="runloadnewpart()">
            Check Your Remaining Limit Here >>
          </a>
        </xsl:if>
        <br/>
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
      <li style="display:block;">
        <div class="font-arial" style="color:white; text-align:right; display:block; width:300px; padding-right:30px" id="cartTotalSales2">Total in Cart : Rp. 0 </div>
      </li>
      <li>
        <div class="btn-group" role="group" aria-label="..." id="buttoncarttop" >
          <xsl:choose>
            <xsl:when test="(sqroot/body/bodyContent/browse/info/TotalRows/.) &gt; 3">
              <div style=" margin: 0px auto; text-align: center; display: block;">
                <a href="" id="carttop_Shopping" style="text-align:center; margin:0 auto; background:#f4f4f4; width:80px; padding:5px; color:black; text-align:center; font-size:12px; margin-bottom:10px;">View More</a>
              </div>
            </xsl:when>
          </xsl:choose>
        <div style=" margin: 0px auto; text-align: center; display: block;">
          <a href="" id="carttop_Shopping" style="background:#f4f4f4; width:115px; padding:5px; color:black; text-align:center; font-size:12px;">Shopping Cart</a>
          <a href="" id="carttop_Checkout" class="needlogin" data-toggle="modal" style="background:#f4f4f4; width:115px; padding:5px; color:black; text-align:center; font-size:12px;">Checkout</a>
        </div>
          <script>
            var cartID = getCookie("cartID");
            document.getElementById("carttop_Shopping").href = 'index.aspx?env=front&amp;code=tapcs1&amp;GUID='+cartID;
            document.getElementById("carttop_Checkout").href = 'index.aspx?env=front&amp;code=tapcs2&amp;GUID='+cartID;
            var TotalSales = '<xsl:value-of select="sqroot/body/bodyContent/browse/content/row/fields/field[@caption = 'TotalSales']" />';
            var FTotalSales = '<xsl:value-of select="format-number(sqroot/body/bodyContent/browse/content/row/fields/field[@caption = 'TotalSales'], '#,##0', 'dot-dec')" />';
            if(TotalSales != ''){
            document.getElementById("cartTotalSales").innerHTML = 'Rp. '+FTotalSales;
            document.getElementById("cartTotalSales2").innerHTML = 'Total in Cart : Rp. '+FTotalSales;
            }

            if (getCookie("isLogin") == "0"){
            $('.needlogin').attr('href','.login-modal')
            }
            var totalrows = '<xsl:value-of select="sqroot/body/bodyContent/browse/info/TotalRows/." />';
            if (totalrows != '0') {
            $('#totalcart').css('display', 'block');
            document.getElementById("totalcart").innerHTML = totalrows;
            }
            else {$('#totalcart').css('display', 'none');}
          </script>
          <!--<button type="button" class="btn btn-default" onclick="location.href='index.aspx?env=front&amp;code=pcs1=GUID={sqroot/body/bodyContent/browse/content/row[@GUID]}';">Shopping Cart</button>
        <button type="button" class="btn btn-default" onclick="location.href='checkout-step-1.html';">Checkout</button>-->
        </div>
      </li>
    </ul>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
    <li>
      <a href="index.aspx?env=front&amp;code=maprodfron&amp;GUID={fields/field[@caption = 'EVENPSKUGUID']/.}">
        <div class="media">
          <div style="height:50px; width:50px; float:left; margin-right:10px; overflow:hidden; text-align:center; background:white; border:2px solid #37acb2; ">
            <img style="max-height:35px; margin-top:5px; width:auto;" src="OPHContent/documents/{/sqroot/header/info/account/.}/{fields/field[@caption = 'productphotos']}" alt="products-img" />
          </div>
          <div class="media-body">
            <h5 class="media-heading itemincart" style="width:200px; overflow-wrap: break-word;">
              <span style="font-size:12px;"><xsl:value-of select="fields/field[@caption = 'productname']"/></span> <br/>
              <span style="font-size:10px;">items ( <xsl:value-of select="fields/field[@caption = 'Qty']"/> ) <br/>
              Rp. <span><xsl:value-of select="format-number(fields/field[@caption = 'TotalPrice']/., '#,##0', 'dot-dec')" /></span>
            </span>
            </h5>
          </div>
        </div>
      </a>
    </li>
  </xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>


  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>
  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
    <!-- MAIN CONTENT SECTION -->
    <section class="mainContent clearfix">
      <div class="container">
          <div class="row singleProduct">
            <div class="col-xs-12">
              <div class="media">
                <div class="media-left productSlider" id="productsliders">
                  Loading Please Wait...
                </div>
                <div class="media-body">
                  <ul class="list-inline">
                    <li>
                      <a onclick="goToProductBrowse()" href="#" style="color:black;" >
                        <span><ix class="fa fa-reply" aria-hidden="true"></ix>
                        </span> Continue Shopping
                      </a>
                    </li>
                  </ul>
                  <form action="#" method="post" id="productform">
                    <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row" />
                    <span class="input-group" style="margin-bottom:20px;">
                      <input type="number" id="Availaible" class="form-control" name="Availaible" style="width:70px;text-align:center" value="1" min="1" />
                    </span>
                    <div class="btn-area">
                      <a class="btn btn-primary btn-block" onclick="AddToCart('maPRODFRON', 'productform')">
                        Add to cart <span style="margin-left:50px; font-size:20px;"><ix class="fa fa-angle-right" aria-hidden="true"></ix></span>
                      </a>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
          <div class="row productsContent" id="relatedProduct" style="display:none;">
            Loading Please Wait...
          </div>
      </div>
    </section>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
    <!--image src-->
    <xsl:variable name="imageprod">
      OPHContent/documents/<xsl:value-of select="sqroot/header/info/account/." />/<xsl:value-of select="fields/field[@caption = 'productphotos']/." />
    </xsl:variable>
    <input type="hidden" id="EVENPSKUGUID" name="EVENPSKUGUID" value="{@GUID}" />
    <input type="hidden" id="cartID" name="cartID" value="" />
    <script>
      document.getElementById("cartID").value = getCookie("cartID");
      document.getElementById("productform").action = document.getElementById("productform").action+getCookie("cartID");
    </script>
    <h2 id="productNames" style="margin-bottom:20px;">
      <xsl:value-of select="fields/field[@caption = 'ID']/." /> - <xsl:value-of select="fields/field[@caption = 'Name']/." /><br />
    </h2>
    <p class="font-arial" style="margin:0; padding:0;  font-size:18px; color:black; margin-bottom:10px;">
      Signature : <span  style="color:#232323;"><xsl:value-of select="fields/field[@caption = 'SignatureName']/." /></span>
    </p>
    <p class="font-arial" style="margin:0; padding:0;  font-size:18px; color:black; margin-bottom:10px;">
      Brand : <span  style="color:#232323;"><xsl:value-of select="fields/field[@caption = 'BrandName']/." /></span>
    </p>
    <xsl:choose>
      <xsl:when test="(fields/field[@caption = 'evenname']/.)!='Website online'">
        <p class="font-arial" style="font-size:18px; color:#232323;">
         Event : <span  style="color:#232323;"><xsl:value-of select="fields/field[@caption = 'evenname']/." /></span>
        </p>
      </xsl:when>
    </xsl:choose>
    <p class="font-arial" style="font-size:18px; color:black; margin-bottom:10px;">
      Stock Available : <xsl:value-of select="fields/field[@caption = 'Availaible']/." />
    </p>
    <div style="margin-bottom:10px">
      <span class="font-arial" style="font-size:18px; color:black; margin-right:10px ">Price :</span>
      <xsl:choose>
        <xsl:when test="(fields/field[@caption = 'discount']/.)!= '0'">
          <span class="font-arial" style="font-size:20px; ">
            Rp. <xsl:value-of select="format-number(fields/field[@caption = 'priceDiscount']/., '#,##0', 'dot-dec')" />
            <span style="font-size:12px; color:white; padding:5px; margin-left:10px; background:#47bac1;">
              <xsl:value-of select="fields/field[@caption = 'discount']/." />%
            </span>
          </span>
          <br />
          <span class="font-arial" style="text-decoration:line-through; font-size:12px; margin-left:64px;">
            Rp. <xsl:value-of select="format-number(fields/field[@caption = 'price']/., '#,##0', 'dot-dec')" />
          </span>
        </xsl:when>
        <xsl:when test="(fields/field[@caption = 'price']/.) != (fields/field[@caption = 'priceDiscount']/.)">
          <span class="font-arial" style="font-size:20px; ">
            Rp. <xsl:value-of select="format-number(fields/field[@caption = 'priceDiscount']/., '#,##0', 'dot-dec')" />
          </span>
          <br />
          <span class="font-arial" style="text-decoration:line-through; font-size:12px; margin-left:64px;">
            Rp. <xsl:value-of select="format-number(fields/field[@caption = 'price']/., '#,##0', 'dot-dec')" />
          </span>
        </xsl:when>
        <xsl:otherwise>
          <span class="font-arial" style="font-size:20px;">
            Rp. <xsl:value-of select="format-number(fields/field[@caption = 'price']/., '#,##0', 'dot-dec')" />
          </span>
        </xsl:otherwise>
      </xsl:choose>
      <!--<h3 style="font-size:20px;">
              Rp. <xsl:value-of select="format-number(fields/field[@caption = 'price']/., '#,##0', 'dot-dec')" />
            </h3>-->
    </div>

    <p class="font-arial" style="font-size:18px; color:black;">
      Description : <br/>
      <span style="font-size:14px; color:#232323; text-align: justify; display:block;">
        <xsl:value-of select="fields/field[@caption = 'Description']/." />
      </span>
    </p>
    <input type="hidden" value="{fields/field[@caption = 'PRODGUID']/.}" id="PRODGUID" name="PRODGUID"/>
    <div style="display:none" id="CTGRGUIDs">
      &#xA0;<xsl:value-of select="fields/field[@caption = 'CTGRGUID']/." /></div>
    <script>
      var filter = "PRODGUID = '"+  document.getElementById("PRODGUID").value +"'" ;
      LoadNewPart('product_browse_child', 'productsliders', 'maprodfronfoto', filter, ''); 
      var x = document.getElementById("PageTitle");
      //x.innerHTML = '<xsl:value-of select="fields/field[@caption = 'ID']/." /> - <xsl:value-of select="fields/field[@caption = 'Name']/." />';
      x.innerHTML = '';
      x.style.fontSize = '14px';
      <!--x.innerHTML = '<xsl:apply-templates select="/sqroot/body/bodyContent/form/formPages/formPage[pageNo='1']/formSections/formSection[sectionNo='1']/formCols/formCol[colNo='1']/formRows/formRow[rowNo='1']/fields/field/textBox/value/." />';-->
              
   
      var searchtext = document.getElementById('CTGRGUIDs').innerHTML;
      var filter = "PRODGUID != " + "'" + document.getElementById('PRODGUID').value + "'";
      LoadNewPart('product_form_related', 'relatedProduct', 'maprodfron', filter, searchtext, '1', '4');
    </script>
  </xsl:template>
</xsl:stylesheet>

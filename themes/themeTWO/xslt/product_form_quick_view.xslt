<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>


  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>
  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
    <div class="media-left">
      <img class="media-object" src="img/products/quick-view/quick-view-01.jpg" alt="Image" />
    </div>
    <div class="media-body">
      
      <div class="btn-area">
        <a class="btn btn-primary btn-block" onclick="AddToCart('{../../../../../../info/state/code/.}', 'productform')">
          Add to cart <span style="margin-left:50px; font-size:20px;"><ix class="fa fa-angle-right" aria-hidden="true"></ix></span>
        </a>
      </div>
    </div>
 
  </xsl:template>
  
  <xsl:template match="sqroot/body/bodyContent/form/formPages/formPage">
    <xsl:if test="@pageNo='1'">
      <xsl:apply-templates select="formSections/formSection" />
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="formSections/formSection">
     <xsl:apply-templates select="formCols/formCol" />
  </xsl:template>
  
  <xsl:template match="formCols/formCol">
    <ul class="list-inline">
      <li>
        <a href="?code=maprodfron" style="color:black;">
          <span><ix class="fa fa-reply" aria-hidden="true"></ix>
          </span> Continue Shopping
        </a>
      </li>
      <!--<li>
        <a href="#">
          <span><ix class="fa fa-plus" aria-hidden="true"></ix>
          </span> Share This
        </a>
      </li>-->
    </ul>
    <!--<form action="../../../../OPHCore/api/default.aspx?mode=save&amp;code={../../../../../../info/state/code/.}" method="post">-->
    <form action="#" method="post" id="productform">
   
      <input type="hidden" id="EVENPSKUGUID" name="EVENPSKUGUID" value="{../../../../../../info/GUID/.}" />
      <input type="hidden" id="cartID" name="cartID" value="" />
      <script>
        document.getElementById("cartID").value = getCookie("cartID");
        document.getElementById("productform").action = document.getElementById("productform").action+getCookie("cartID");
      </script>
      <xsl:apply-templates select="formRows/formRow" />
      <span class="input-group" style="margin-bottom:20px;">
        <input type="number" id="Availaible" class="form-control" name="Availaible" style="width:70px;text-align:center" value="1" min="1" />
      </span>
      <div class="btn-area">
        <a class="btn btn-primary btn-block" onclick="AddToCart('{../../../../../../info/state/code/.}', 'productform')">
          Add to cart <span style="margin-left:50px; font-size:20px;"><ix class="fa fa-angle-right" aria-hidden="true"></ix></span>
        </a>
      </div>
    </form>
  </xsl:template>
  
  <xsl:template match="formRows/formRow">
    <xsl:if test="fields/field[@fieldName = 'Name']">
      <h2 id="productNames">
        <!--<xsl:value-of select="fields/field[@fieldName = 'Name']/textBox/value/." />-->
        asca
      </h2>
    </xsl:if>
    <xsl:if test="fields/field[@fieldName = 'ID']">
      <script>
        document.getElementById('productNames').innerHTML = '<xsl:value-of select="fields/field[@fieldName = 'ID']/textBox/value/." />' + ' - ' + document.getElementById('productNames').innerHTML
      </script>
      <!--<p style="margin:0; padding:0">
        Code : <xsl:value-of select="fields/field[@fieldName = 'ID']/textBox/value/." />
      </p>-->
    </xsl:if>
     <!--<xsl:if test="fields/field[@fieldName = 'divisionName']">
      <p style="margin:0; padding:0;  font-size:20px; color:black; margin-bottom:10px;">
        Division : <xsl:value-of select="fields/field[@fieldName = 'divisionName']/textBox/value/." />
      </p>
    </xsl:if>-->
    <xsl:if test="fields/field[@fieldName = 'SignatureName']">
      <p style="margin:0; padding:0;  font-size:20px; color:black; margin-bottom:10px;">
        Signature : <xsl:value-of select="fields/field[@fieldName = 'SignatureName']/textBox/value/." />
      </p>
    </xsl:if>
    <xsl:if test="fields/field[@fieldName = 'BrandName']">
      <p style="margin:0; padding:0;  font-size:20px; color:black; margin-bottom:10px;">
        Brand : <xsl:value-of select="fields/field[@fieldName = 'BrandName']/textBox/value/." />
      </p>
    </xsl:if>
    <xsl:if test="fields/field[@fieldName = 'priceDiscount']">
      <h3>
        Rp. <xsl:value-of select="format-number(fields/field[@fieldName = 'priceDiscount']/textBox/value/., '#,##0', 'dot-dec')" />
      </h3>
      <input type="hidden" id="price" name="price" value="{fields/field[@fieldName = 'price']/textBox/value/.}" />
    </xsl:if>
    <xsl:if test="fields/field[@fieldName = 'Description']">
      <p  style="font-size:20px; color:black;">
        Description : <br/>
        <span style="font-size:16px; color:black;"><xsl:value-of select="fields/field[@fieldName = 'Description']/textBox/value/." />
        </span>
      </p>
    </xsl:if>
    <xsl:if test="fields/field[@fieldName = 'Availaible']">
      <p  style=" font-size:20px; color:black;">
        Stock Availaible : <xsl:value-of select="fields/field[@fieldName = 'Availaible']/textBox/value/." />
      </p>
    </xsl:if>
    <xsl:if test="fields/field[@fieldName = 'PRODGUID']">
       <input type="hidden" value="{fields/field[@fieldName = 'PRODGUID']/textBox/value/.}" id="PRODGUID" name="PRODGUID"/>
    </xsl:if>
    <xsl:if test="fields/field[@fieldName = 'CTGRGUID']">
       <div style="display:none" id="CTGRGUIDs"><xsl:value-of select="fields/field[@fieldName = 'CTGRGUID']/textBox/value/." /></div>
    </xsl:if>
  </xsl:template>

  <!--Children-->
  <xsl:template match="sqroot/body/bodyContent/form/children">
     <script>
      var filter = "<xsl:value-of select="child/parentkey/." /> = '"+  document.getElementById("PRODGUID").value +"'" ;
       LoadNewPart('product_browse_child', 'productsliders', 'maprodfronfoto', filter, '');
      <!--alert(filter);-->
    </script>
  </xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
    <div id="carousel" class="carousel slide" data-ride="carousel">
      <div class="carousel-inner" >
        <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row" />
        <!--<xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row" />-->
        
        <!--<div class="item active" data-thumb="0">
          <img src="{sqroot/body/bodyContent/form/formPages/formPage[@pageNo='1']/formSections/formSection[@sectionNo = '1']/formCols/formCol[@colNo = '1']/formRows/formRow[@rowNo='4']/fields/field[@fieldName = 'productphotos']/textBox/value/.}" />
        </div>
        <div class="item" data-thumb="1">
          <img src="OPHContent/themes/themeTwo/images/product/eye/HYPERSHARP-WING-det1.jpg" />
        </div>-->
              
      </div>
    </div>
    <div class="clearfix">
      <div id="thumbcarousel" class="carousel slide" data-interval="false">
        <div class="carousel-inner" id="tempr">
        </div>
        <a class="left carousel-control" href="#thumbcarousel" role="button" data-slide="prev">
          <span class="glyphicon glyphicon-chevron-left"></span>
        </a>
        <a class="right carousel-control" href="#thumbcarousel" role="button" data-slide="next">
          <span class="glyphicon glyphicon-chevron-right"></span>
        </a>
      </div>
    </div>
      
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
    <xsl:variable name="active">

    </xsl:variable>
    <xsl:choose>
      <xsl:when test="(fields/field[@caption = 'isPP']/.) = '1'">
        <div class="item active" data-thumb="0" style="text-align:center !important; height:400px;">
          <img style="margin:0 auto;  height:100%;  width: auto;" src="OPHContent/documents/{/sqroot/header/info/account/.}/{fields/field[@caption = 'Attachment']/.}" onerror="this.src='ophcontent/themes/themeTWO/images/white.png'" alt="image" />
        </div>
        <script>
          document.getElementById('tempr').innerHTML = document.getElementById('tempr').innerHTML + '<div style="height:100px;" data-target="#carousel" data-slide-to="{fields/field[@caption = 'FotoID']/.}" class="thumb">
            <img style="margin:0 auto; height:100%; width: auto;"  src="OPHContent/documents/{/sqroot/header/info/account/.}/{fields/field[@caption = 'Attachment']/.}" onerror="this.src='ophcontent/themes/themeTWO/images/white.png'" alt="image" />
          </div>';
        </script>
      </xsl:when>
      <xsl:otherwise>
        <div class="item" data-thumb="1"  style="height:400px;">
          <img  style="margin:0 auto; height:100%; width: auto;" src="OPHContent/documents/{/sqroot/header/info/account/.}/{fields/field[@caption = 'Attachment']/.}" />
        </div>
        <script>
          document.getElementById('tempr').innerHTML = document.getElementById('tempr').innerHTML + '<div style="height:100px;"> data-target="#carousel" data-slide-to="{fields/field[@caption = 'FotoID']/.}" class="thumb">
            <img style="margin:0 auto; height:100%; width: auto;"  src="OPHContent/documents/{/sqroot/header/info/account/.}/{fields/field[@caption = 'Attachment']/.}" onerror="this.src='ophcontent/themes/themeTWO/images/white.png'" alt="image"/>
          </div>';
        </script>
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:template>
</xsl:stylesheet>

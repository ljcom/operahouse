<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
    <script>
      <!--loadScript('https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js');
      loadScript('OPHContent/themes/themeTWO/scripts/jquery-ui/jquery-ui.js');
      loadScript('OPHContent/themes/themeTWO/scripts/rs-plugin/js/jquery.themepunch.tools.min.js');
      loadScript('OPHContent/themes/themeTWO/scripts/rs-plugin/js/jquery.themepunch.revolution.min.js');
      loadScript('OPHContent/themes/themeTWO/scripts/selectbox/jquery.selectbox-0.1.3.min.js');
      loadScript('OPHContent/themes/themeTWO/scripts/countdown/jquery.syotimer.js');
      loadScript('OPHContent/themes/themeTWO/scripts/custom-me.js');-->

      loadScript('OPHContent/themes/themeTWO/scripts/bootstrap/js/bootstrap.min.js');
      loadScript('OPHContent/themes/themeTWO/scripts/owl-carousel/owl.carousel.js');
      loadScript('OPHContent/themes/themeTWO/scripts/js/custom.js');

      $('.homeslider').css('display', 'block');
      $('#loadingslider').remove();
    </script>
    <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row" />
  </xsl:template>
  

  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
   <div class="col-md-6 col-xs-12">
      <div class="category-content">
        <div class="category-top">
          <div class="category-menu text-center">
            <h2 class="category-title"><xsl:value-of select="fields/field[@caption = 'Name']/."/>  </h2>
            <ul id="{@GUID}_catagories">
              Loading Please Wait...
              <script>
                var id = '<xsl:value-of select="@GUID" />'+'_catagories';
                var search = '<xsl:value-of select="@GUID" />';
                LoadNewPart('home_browse_feature_catagory', id, 'mactgrfron', '', search);
              </script>
            </ul>
          </div>
          <div class="category-Slider" id="prod-feature_{@GUID}">
            <div class="owl-carousel categorySlider" >
              <div class="item" style="height:400px;">
                <img style="max-height:300px;  width:auto;  margin:0 auto; " src="OPHContent/themes/themeTWO/images/product/1_{fields/field[@caption = 'Name']/.}.jpg" onerror="this.src='ophcontent/themes/themeTWO/images/white.png'" alt="Image" />
              </div>
              <div class="item" style="height:400px;">
                <img style="max-height:300px; width:auto;  margin:0 auto;" src="OPHContent/themes/themeTWO/images/product/2_{fields/field[@caption = 'Name']/.}.jpg" onerror="this.src='ophcontent/themes/themeTWO/images/white.png'" alt="Image" />
              </div>
              <div class="item" style="height:400px;">
                <img style="max-height:300px; width:auto; margin:0 auto;" src="OPHContent/themes/themeTWO/images/product/3_{fields/field[@caption = 'Name']/.}.jpg" onerror="this.src='ophcontent/themes/themeTWO/images/white.png'" alt="Image" />
              </div>
            </div>
          </div>
          <div class="category-bottom" id="productfeature_{@GUID}">
            Loading Please wait...
           
          </div>
          <script>
            var search2 = '<xsl:value-of select="@GUID" />';
            var id = 'productfeature_<xsl:value-of select="@GUID" />';
            LoadNewPart('home_browse_feature_catagory', id, 'maprodfron', '', search2, '1', '3' , 'availaible desc');
          </script>
        </div>
      </div>
    </div>
  </xsl:template>
</xsl:stylesheet>

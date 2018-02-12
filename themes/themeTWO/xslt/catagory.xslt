<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
  <xsl:variable name="code">
     <xsl:value-of select="sqroot/header/info/code/id/." />

  </xsl:variable>
  
  <xsl:template match="/">
      
    <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row" />
  </xsl:template>
  
  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
    <!--image src-->
    <xsl:choose>
      <xsl:when test="((fields/field[@caption = 'PARNCTGRGUID']/.) !='' or (fields/field[@caption = 'PARNBRANGUID']/.) !='') and (fields/field[@caption = 'isParent']/.) ='1' ">
        <li>
          <div class="panel-group">
            <a id="{@GUID}_a" data-toggle="collapse" href="#{@GUID}_menu" class="top-envi-lv2"  onclick="LoadNewPart('catagory', '{@GUID}_menus', '{$code}', '', '{@GUID}', '1', '200');  changePlusMinus(this); findParent(2, '{@GUID}');">
              <!--<span style="margin-right:10px; font-size:9px; ">➤</span>-->
              <span style="width:70%; display:inline-table; line-height:14px;" onclick="goToAnotherPage('index.aspx?code=maprodfron&amp;bSearchText={@GUID}'); clearCookies();">
                <xsl:value-of select="fields/field[@caption = 'Name']/." />
              </span>
              <xsl:apply-templates select="fields/field[@caption = 'isParent']" />
              <xsl:choose>
                <xsl:when test="(fields/field[@caption = 'Link']/.) !=''">
                  <br/>
                  <br/>
                  <span data-toggle="tooltip" title="Go to this Link" onclick="NewTabAnotherPage('http://{fields/field[@caption = 'Link']/.}')" style="font-size:10px; margin-left:22px; ">
                    <xsl:value-of select="fields/field[@caption = 'Link']/." />
                  </span>
                </xsl:when>
              </xsl:choose>
            </a>

            <div id="{@GUID}_menu" class="panel-collapse collapse">
              <xsl:if test="$code = 'MaCTGRFRON'">
                <input type="hidden" id="parent_{@GUID}" value="{fields/field[@caption = 'PARNCTGRGUID']/.}"/>
              </xsl:if>
              <xsl:if test="$code = 'MaBRANFRON'">
                <input type="hidden" id="parent_{@GUID}" value="{fields/field[@caption = 'PARNBRANGUID']/.}"/>
              </xsl:if>
              <ul id="{@GUID}_menus">
                <script>
                  var url = document.URL;
                  var GUID = '<xsl:value-of select="@GUID"/>';
                  var ctgrGUID = getQueryVariable("bSearchText");
                  var code = '<xsl:value-of select="$code"/>';
                  var id =  GUID+'_menu'
                  var parn1 = getCookie('parentctgr1');

                  if (ctgrGUID != undefined &amp;&amp; ctgrGUID != ''){
                    var n = GUID.includes(ctgrGUID);
                    if (n)  {
                      LoadNewPart('catagory', GUID+'_menus', code, '', GUID, '1', '200');
                      var parent = '';
                      parent = document.getElementById('parent_'+GUID).value

                      if (document.getElementById(id).className == "panel-collapse collapse") document.getElementById(id).className = 'panel-collapse collapse in';
                      else  document.getElementById(id).className = 'panel-collapse collapse';

                      if (document.getElementById(parent+'_menu').className == "panel-collapse collapse") document.getElementById(parent+'_menu').className = 'panel-collapse collapse in';
                      else  document.getElementById(parent+'_menu').className = 'panel-collapse collapse';
                      
                       var plusbtn = document.getElementById('plus-button-<xsl:value-of select="@GUID"/>');
                        if (plusbtn.className == 'fa fa-plus plus-button') {plusbtn.className = 'fa fa-minus plus-button'}
                        else {plusbtn.className = 'fa fa-plus plus-button'}
                        
                         document.getElementById(ctgrGUID+'_a').style.background = '#f9f9f9';

                    }

                  }
                  if (parn1 != undefined &amp;&amp; parn1 != ''){
                    var n2 = GUID.includes(parn1);
                    if (n2)  {
                      LoadNewPart('catagory', GUID+'_menus', code, '', GUID, '1', '200');
                      var parent = '';
                      parent = document.getElementById('parent_'+GUID).value

                      if (document.getElementById(id).className == "panel-collapse collapse") document.getElementById(id).className = 'panel-collapse collapse in';
                      else  document.getElementById(id).className = 'panel-collapse collapse';

                      if (document.getElementById(parent+'_menu').className == "panel-collapse collapse") document.getElementById(parent+'_menu').className = 'panel-collapse collapse in';
                      else  document.getElementById(parent+'_menu').className = 'panel-collapse collapse';
                      
                       var plusbtn = document.getElementById('plus-button-<xsl:value-of select="@GUID"/>');
                        if (plusbtn.className == 'fa fa-plus plus-button') {plusbtn.className = 'fa fa-minus plus-button'}
                        else {plusbtn.className = 'fa fa-plus plus-button'}
                        
                        //document.getElementById(parn1+'_a').style.background = '#f9f9f9';
                  }

                  }
                </script>
              </ul>
            </div>
          </div>
        </li>
      </xsl:when>
      <xsl:when test="((fields/field[@caption = 'PARNCTGRGUID']/.) !='' or (fields/field[@caption = 'PARNBRANGUID']/.) !='') and (fields/field[@caption = 'isParent']/.) ='0' ">
        <li>
          <a id="{@GUID}_a" data-toggle="collapse" href="#{@GUID}_menu" class="top-envi-lv2" onclick="goToAnotherPage('index.aspx?code=maprodfron&amp;bSearchText={@GUID}');  clearCookies(); changePlusMinus(this); findParent(3, '{@GUID}')">
            <!--<span style="margin-right:10px; font-size:9px;">➤</span>--> 
            <xsl:value-of select="fields/field[@caption = 'Name']/." />
          </a>
          <div id="{@GUID}_menu" class="panel-collapse collapse">
            <xsl:if test="$code = 'MaCTGRFRON'">
              <input type="hidden" id="parent_{@GUID}" value="{fields/field[@caption = 'PARNCTGRGUID']/.}"/>
            </xsl:if>
            <xsl:if test="$code = 'MaBRANFRON'">
              <input type="hidden" id="parent_{@GUID}" value="{fields/field[@caption = 'PARNBRANGUID']/.}"/>
            </xsl:if>
            <ul id="{@GUID}_menus">
              <script>
                var url = document.URL;
                var GUID = '<xsl:value-of select="@GUID"/>';
                var ctgrGUID = getQueryVariable("bSearchText");
                var code = '<xsl:value-of select="$code"/>';
                var id =  GUID+'_menu'
                if (ctgrGUID != undefined &amp;&amp; ctgrGUID != ''){
                  document.getElementById(ctgrGUID+'_a').style.background = '#f9f9f9';
                }
              </script>
            </ul>
          </div>
        </li>
      </xsl:when>
      <xsl:otherwise>
        <div class="panel-group">
          <div class="panel panel-default top-menu-onphone" style="border-radius:0; margin-top:0;" >
            <a id="{@GUID}_a" class="top-envi" data-toggle="collapse" href="#{@GUID}_menu" data-parent="#accordion2"  onclick="LoadNewPart('catagory', '{@GUID}_menus', '{$code}', '', '{@GUID}', '1', '200');  changePlusMinus(this);">

              <span onclick="goToAnotherPage('index.aspx?env=front&amp;code=maprodfron&amp;bSearchText={@GUID}'); clearCookies();">
                <xsl:value-of select="fields/field[@caption = 'Name']/." />
              </span>
              <xsl:apply-templates select="fields/field[@caption = 'isParent']" />
            </a>
            <div class="panel-collapse collapse" id="{@GUID}_menu">
              <xsl:if test="$code = 'MaCTGRFRON'">
                <input type="hidden" id="parent_{@GUID}" value="{fields/field[@caption = 'PARNCTGRGUID']/.}"/>
              </xsl:if>
              <xsl:if test="$code = 'MaBRANFRON'">
                <input type="hidden" id="parent_{@GUID}" value="{fields/field[@caption = 'PARNBRANGUID']/.}"/>
              </xsl:if>
              <ul id="{@GUID}_menus">
                <script>
                  var url = document.URL;
                  var GUID = '<xsl:value-of select="@GUID"/>';
                  var ctgrGUID = getQueryVariable("bSearchText");
                  var code = '<xsl:value-of select="$code"/>';
                  var id =  GUID+'_menu'
                  var parn2 = getCookie('parentctgr2');
                 
                  
                  if (ctgrGUID != undefined &amp;&amp; ctgrGUID != ''){
                    var n = GUID.includes(ctgrGUID);
                    if (n == true )  {
                    LoadNewPart('catagory', GUID+'_menus', code, '', GUID, '1', '200');
                        if (document.getElementById(id).className == "panel-collapse collapse") document.getElementById(id).className = 'panel-collapse collapse in';
                        else document.getElementById(id).className = 'panel-collapse collapse';
                        var plusbtn = document.getElementById('plus-button-<xsl:value-of select="@GUID"/>');
                        if (plusbtn.className == 'fa fa-plus plus-button') {plusbtn.className = 'fa fa-minus plus-button'}
                        else {plusbtn.className = 'fa fa-plus plus-button'}
                        document.getElementById(ctgrGUID+'_a').style.background = '#f9f9f9';
                       
                    }
                  }
                  if(parn2 != '' &amp;&amp; parn2 != undefined){

                  var n2 = GUID.includes(parn2);
                  if (n2 == true)  {
                    LoadNewPart('catagory', GUID+'_menus', code, '', GUID, '1', '200');
                    $( document ).ajaxStop(function() {
                      if (document.getElementById(id).className == "panel-collapse collapse") document.getElementById(id).className = 'panel-collapse collapse in';
                      else document.getElementById(id).className = 'panel-collapse collapse';
                      var plusbtn = document.getElementById('plus-button-<xsl:value-of select="@GUID"/>');
                      if (plusbtn.className == 'fa fa-plus plus-button') {plusbtn.className = 'fa fa-minus plus-button'}
                      else {plusbtn.className = 'fa fa-plus plus-button'}
                      //document.getElementById(parn2+'_a').style.background = '#f9f9f9';
                    });
                    }
                  }
                </script>
              </ul>
            </div>
          </div>
        </div>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template match="fields/field[@caption = 'isParent']">
    <xsl:choose>
      <xsl:when test="(.) ='1' ">
        <span class="fa fa-plus plus-button" id="plus-button-{../../@GUID}" style="position:absolute; right:15px; top:18px; font-size:12px; color:#4c4c4c">&#xA0;</span>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>

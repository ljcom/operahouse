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
        <li style="border-bottom:none;">
          <a data-toggle="collapse" href="#{@GUID}_menu" class="top-envi-lv2"  onclick="LoadNewPart('home_browse_menu_sidebar', '{@GUID}_menus', '{$code}', '', '{@GUID}', '1' , '200'); changePlusMinus(this);">
            <!--<span style="margin-right:10px; font-size:9px; ">➤</span>-->
            <span style="width:70%; display:inline-table; line-height:14px;" onclick="goToAnotherPage('index.aspx?env=front&amp;code=maprodfron&amp;bSearchText={@GUID}')">
              <xsl:value-of select="fields/field[@caption = 'Name']/." />
            </span>
            <xsl:apply-templates select="fields/field[@caption = 'isParent']" />
            <xsl:choose>
              <xsl:when test="(fields/field[@caption = 'Link']/.) !=''">
                <br/><br/><span data-toggle="tooltip" title="Go to this Link" onclick="NewTabAnotherPage('http://{fields/field[@caption = 'Link']/.}')" style="font-size:10px; margin-left:0px;">
                  <xsl:value-of select="fields/field[@caption = 'Link']/." />
                </span>
              </xsl:when>
            </xsl:choose>
          </a>

          <div id="{@GUID}_menu" class="panel-collapse collapse">
            <ul id="{@GUID}_menus">
            </ul>
          </div>
        </li>
      </xsl:when>
      <xsl:when test="((fields/field[@caption = 'PARNCTGRGUID']/.) !='' or (fields/field[@caption = 'PARNBRANGUID']/.) !='') and (fields/field[@caption = 'isParent']/.) ='0' ">
        <li>
          <a data-toggle="collapse" href="#{@GUID}_menu" class="top-envi-lv2" style="padding-left:45px !important;" onclick="goToAnotherPage('index.aspx?env=front&amp;code=maprodfron&amp;bSearchText={@GUID}'); changePlusMinus(this);">
            <!--<span style="margin-right:10px; font-size:9px;">➤</span>-->
            <xsl:value-of select="fields/field[@caption = 'Name']/." />
          </a>
          <div id="{@GUID}_menu" class="panel-collapse collapse">
            <ul id="{@GUID}_menus">
            </ul>
          </div>
        </li>
      </xsl:when>
      <xsl:otherwise>
        <div class="panel top-menu-onphone" style="border-radius:0; margin-top:0;" >
          <!--<a class="top-envi" data-toggle="collapse" data-parent="#accordion2" href="{pageURL/.}">-->
          <a class="top-envi" data-toggle="collapse" href="#{@GUID}_menu" data-parent="#accordion2"  onclick="LoadNewPart('home_browse_menu_sidebar', '{@GUID}_menus', '{$code}', '', '{@GUID}', '1' , '200'); changePlusMinus(this);">
            <!--<ix>
              <img src="{icon/img/.}" style="width:15px; margin-right:8px;" />
            </ix>-->
            <!--<span style="margin-right:10px; font-size:9px;">➤</span>-->
            <span onclick="goToAnotherPage('index.aspx?env=front&amp;code=maprodfron&amp;bSearchText={@GUID}')">
              <xsl:value-of select="fields/field[@caption = 'Name']/." />
            </span>
            <xsl:apply-templates select="fields/field[@caption = 'isParent']" />
            <!--<span class="fa fa-plus" style="position:absolute; right:15px; top:18px; font-size:12px; color:#4c4c4c"></span>-->
          </a>
          <div class="panel-collapse collapse" id="{@GUID}_menu">
            <ul id="{@GUID}_menus">

            </ul>
          </div>
        </div>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template match="fields/field[@caption = 'isParent']">
    <xsl:choose>
      <xsl:when test="(.) ='1' ">
        <span class="fa fa-plus plus-button" style="position:absolute; right:15px; top:18px; font-size:12px; color:#4c4c4c">&#xA0;</span>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>
  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
    <script>
      $("#searchBox").val(getSearchText());
      var c=getQueryVariable('code').toLowerCase();
      try {
      $($('.treeview').children().find('a[href$="='+c+'"]')[0].parentNode.parentNode.parentNode.parentNode.parentNode).addClass('active');
      $($('.treeview').children().find('a[href$="='+c+'"]')[0].parentNode.parentNode.parentNode).addClass('active');
      $($('.treeview').children().find('a[href$="='+c+'"]')[0].parentNode).addClass('active');
      } catch(e) {}
    </script>
    <!-- search form -->
    <!--<form method="get" class="sidebar-form">-->
    <div class="user-panel">
      <div class="pull-left image">
        <img src="OPHContent/documents/{sqroot/header/info/account}/{sqroot/header/info/user/userURL}" class="img-circle" alt="User Image" />
      </div>
      <div class="pull-left info">
        <p>
          <xsl:value-of select="sqroot/header/info/user/userName"/>
        </p>
        <a href="#">
          <ix class="fa fa-circle text-success"></ix> Online
        </a>
      </div>
    </div>
    <div class="input-group sidebar-form">
      <input type="text" id="searchBox" name="searchBox" class="form-control" placeholder="Search..." onkeypress="return searchText(event,this.value);" value="" />
      <span class="input-group-btn">
        <button type="button" name="search" id="search-btn" class="btn btn-flat" onclick="searchText(event);">
          <ix class="fa fa-search" aria-hidden="true"></ix>
        </button>
      </span>
    </div>
    <!--</form>-->
    <!-- sidebar menu: : style can be found in sidebar.less -->
    <ul class="sidebar-menu">
      <xsl:apply-templates select="sqroot/header/menus/menu[@code='sidebar']/submenus/submenu" />
    </ul>
  </xsl:template>

  <xsl:template match="sqroot/header/menus/menu[@code='sidebar']/submenus/submenu">
    <xsl:variable name="className">
      <xsl:choose>
        <xsl:when test="(@type)='treeroot'">treeview main-menu-a</xsl:when>
        <xsl:when test="(@type)='label'">header</xsl:when>
      </xsl:choose>
    </xsl:variable>

    <li class="{$className}">
      <xsl:choose>
        <xsl:when test="(pageURL/.)!=''">
          <a href="{translate(pageURL/., $uppercase, $smallcase)}">
            <xsl:if test="(icon/fa/.)!=''">
              <span>
                <ix class="fa {icon/fa/.}"></ix>&#160;
              </span>
            </xsl:if>
            <span>
              <xsl:value-of select="caption/." />
            </span>
            <xsl:if test="(@type)='treeroot'">
              <span class="pull-right-container">
                <ix class="fa fa-angle-left pull-right"></ix>
              </span>
            </xsl:if>
          </a>
          <xsl:if test="(@type)='treeroot'">
            <ul class="treeview-menu browse-left-sidebar">
              <xsl:apply-templates select="submenus/submenu[@type='treeview']" />&#160;
              <xsl:apply-templates select="submenus/submenu[@type='label']" />&#160;
            </ul>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="caption/." />&#160;
        </xsl:otherwise>
      </xsl:choose>
    </li>

  </xsl:template>

  <xsl:template match="submenus/submenu[@type='treeview']">
    <li class="treeview">
      <a href="{translate(pageURL/., $uppercase, $smallcase)}">
        <span>
          <xsl:if test="(icon/fa/.)!=''">
            <ix class="fa {icon/fa/.}"></ix>&#160;
          </xsl:if>
          <xsl:value-of select="caption/." />&#160;
        </span>
        <span class="pull-right-container">
          <ix class="fa fa-angle-left pull-right"></ix>
        </span>
      </a>
      <ul class="treeview-menu browse-left-sidebar" >
        <xsl:apply-templates select="submenus/submenu[@type='treeview']" />&#160;
        <xsl:apply-templates select="submenus/submenu[@type='label']" />&#160;
      </ul>
    </li>

  </xsl:template>

  <xsl:template match="submenus/submenu[@type='label']">
    <script>//label</script>
    <li>
      <a href="{translate(pageURL/., $uppercase, $smallcase)}">
        <span>
          <xsl:if test="(icon/fa/.)!=''">
            <ix class="fa {icon/fa/.}"></ix>&#160;
          </xsl:if>
          <xsl:value-of select="caption/." />&#160;
        </span>
        &#160;
        <xsl:if test="isPending &gt; 0">
          <ix class="fa fa-asterisk" aria-hidden="true" style="font-size: 10px; position: absolute;"></ix>
        </xsl:if>
      </a>
    </li>
  </xsl:template>

  <xsl:template match="sqroot/header/menus/menu[@code='newdocument']/submenus/submenu">
    <li style="height:170px;text-align:center;">
      <a href="{translate(pageURL/., $uppercase, $smallcase)}">
        <img src="OPHContent/themes/{/sqroot/header/info/themeFolder}/images/module.png" />
        <h4>
          <xsl:value-of select="translate(substring(code/.,1,2), $smallcase, $uppercase)" />&#160;
          <br />
          <xsl:value-of select="translate(substring(code/.,3,2), $smallcase, $uppercase)" />&#160;
        </h4>
        <p style="width:150px">
          <xsl:value-of select="caption/." />&#160;
        </p>
      </a>
    </li>
  </xsl:template>

</xsl:stylesheet>

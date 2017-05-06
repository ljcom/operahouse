<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  <xsl:output method="xml" indent="yes"/>
  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
  
  <xsl:template match="/">

    <!-- search form -->
    <form action="#" method="get" class="sidebar-form">
      <div class="input-group">
        <input type="text" name="q" class="form-control" placeholder="Search..." />
        <span class="input-group-btn">
          <button type="submit" name="search" id="search-btn" class="btn btn-flat">
            <ix class="fa fa-search" aria-hidden="true"></ix>
          </button>
        </span>
      </div>
    </form>
    <!-- sidebar menu: : style can be found in sidebar.less -->
    <ul class="sidebar-menu" >
      <xsl:apply-templates select="sqroot/header/menus/menu[@code='sidebar']/submenus/submenu" />
    </ul>

  </xsl:template>

  <xsl:template match="sqroot/header/menus/menu[@code='sidebar']/submenus/submenu">
    <xsl:variable name="className">
      <xsl:choose>
        <xsl:when test="(@mode)='treeroot'">treeview main-menu-a</xsl:when>
        <xsl:when test="(@mode)='label'">header</xsl:when>
      </xsl:choose>
    </xsl:variable>

    <li class="{$className}">
      <xsl:choose>
        <xsl:when test="(pageURL/.)!=''">
          <a href="{pageURL/.}">

            <xsl:if test="(icon/fa/.)!=''">
              <span>
                <ix class="fa {icon/fa/.}"></ix>&#160;
              </span>
            </xsl:if>
            <span>
              <xsl:value-of select="caption/." />
            </span>
            <xsl:if test="(@mode)='treeroot'">
              <span class="pull-right-container">
                <ix class="fa fa-angle-left pull-right"></ix>
              </span>
              <xsl:choose>
                <xsl:when test="submenus!=''">
                  <ul class="treeview-menu browse-left-sidebar" >
                    <xsl:apply-templates select="submenus/submenu[@mode='treeview']" />
                  </ul>
                </xsl:when>
              </xsl:choose>
            </xsl:if>
          </a>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="caption/." />
        </xsl:otherwise>
      </xsl:choose>
    </li>
  </xsl:template>
  <xsl:template match="submenus/submenu[@mode='treeview']">
    <li class="treeview">
      <a href="{pageURL/.}">
        <span>
          <xsl:if test="(icon/fa/.)!=''">
            <ix class="fa {icon/fa/.}"></ix>&#160;
          </xsl:if>
          <xsl:value-of select="caption/." />
        </span>
        <xsl:if test="(@mode)='treeview'">
          <span class="pull-right-container">
            <ix class="fa fa-angle-left pull-right"></ix>
          </span>
          <xsl:choose>
            <xsl:when test="submenus!=''">
              <ul class="treeview-menu browse-left-sidebar" >
                <xsl:apply-templates select="submenus/submenu[@mode='treeview']" />
              </ul>
            </xsl:when>
          </xsl:choose>
        </xsl:if>
      </a>
    </li>

  </xsl:template>
  <!--<xsl:template match="sqroot/header/menus/menu[@code='newdocument']/submenus/submenu">
    <li style="height:170px;text-align:center;">
      <a href="{pageURL/.}">
        <img src="OPHContent/themes/{/sqroot/header/info/themeFolder}/images/module.png" />
        <h4>
          <xsl:value-of select="translate(substring(code/.,1,2), $smallcase, $uppercase)" />
          <br />
          <xsl:value-of select="translate(substring(code/.,3,2), $smallcase, $uppercase)" />
        </h4>
        <p style="width:150px">
          <xsl:value-of select="caption/." />
        </p>
      </a>
    </li>
  </xsl:template>-->

</xsl:stylesheet>

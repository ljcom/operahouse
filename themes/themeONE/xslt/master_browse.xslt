<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>

  <xsl:variable name="state" select="/sqroot/body/bodyContent/browse/info/curState/@substateCode" />

  <xsl:template match="/">

    <xsl:if test="/sqroot/header/info/isBrowsable = 0">
      <script>
        document.getElementById("contentWrapper").innerHTML = '<p style="padding:20px 0 0 20px; font-weight:bold;">Sorry, You Do Not Have Authority for This Module.</p><hr />';

        $(".ellipsis").dotdotdot({
        watch: "window"
        });

      </script>
    </xsl:if>

    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        <!--<xsl:value-of select="sqroot/header/info/code/name"/>&#160;(<xsl:value-of select="sqroot/header/info/code/id"/>)-->
        <xsl:value-of select="sqroot/header/info/code/name"/>
      </h1>
      <ol class="breadcrumb">
        <li>
          <a href="javascript:goHome();">
            <span>
              <ix class="fa fa-home"></ix>
            </span>&#160;Home
          </a>
        </li>
        <li class="active">
          <xsl:value-of select="sqroot/header/info/code/name"/>&#160;(<xsl:value-of select="sqroot/header/info/code/id"/>)
        </li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      <script>
        addpagenumber('pagenumbers', '<xsl:value-of select ="sqroot/body/bodyContent/browse/info/pageNo"/>', '<xsl:value-of select ="sqroot/body/bodyContent/browse/info/nbPages"/>')
      </script>

      <div class="col-md-12 full-width-a">
        <div class="box-header full-width-a">
          <!-- <h3 class="box-title title-browse">On Approval<span class="caret"></span> </h3> -->

          <div class=" browse-dropdown-status">

            <div class="dropdown">
              <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown" >
                <xsl:value-of select="translate(sqroot/body/bodyContent/browse/info/curState/@substateName, $smallcase, $uppercase)"/>
                &#160;
                <span class="caret"></span>
              </button>

              <ul class="dropdown-menu browse-dropdown-content">
                <xsl:apply-templates select="sqroot/body/bodyContent/browse/info/states/state/substate" />
              </ul>
            </div>
          </div>
          <div class="box-tools">
            <!-- <button type="button" class="btn btn-info btn-lg" style="background:#ccc; border:none;">CLEAR</button> -->
            <!-- 
                <button type="button" class="btn btn-info btn-lg" style="background:orange; border:none;">DONE</button> -->
            <button type="button" style="margin-top:10px;" class="btn btn-orange-a" id="newdoc" onclick="window.location='?code={sqroot/header/info/code/id}&amp;guid=00000000-0000-0000-0000-000000000000'">
              NEW <span class="visible-phone">DOCUMENT</span>
            </button>
            <!-- Modal -->
          </div>
          <script>
            var allowAdd='<xsl:value-of select="sqroot/body/bodyContent/browse/info/permission/allowAdd/." />';
            if (allowAdd!='1') $('#newdoc').prop('disabled', true);
          </script>
          <!--<div class="accordian-body collapse" id="newdocpanel" style="background:#4c4c4c; position:absolute; z-index:100; width:99%; right:10px; top:65px; ">
              <ul class="new-doc"  style="margin-left:-10px; display:inline-table; padding:10px;">
                <xsl:apply-templates select="sqroot/header/menus/menu[@code='newdocument']/submenus/submenu" />
              </ul>
              <div class="arrow-up"></div>
            </div>
          </div>-->
          <!-- /.box-header -->
        </div>
      </div>
      <!-- header -->

      <!-- browse for pc/laptop -->
      <div class="row visible-phone">
        <div class="col-md-12">
          <div class="box" style="border:0px none white;box-shadow:none;">
            <table class="table table-condensed strip-table-browse browse-table-an" style="border-collapse:collapse; margin:auto;">
              <thead>
                <tr>
                  <!--th width="30"></th-->
                  <xsl:apply-templates select="sqroot/body/bodyContent/browse/header/column[@mandatory=1]" />
                  <th>SUMMARY</th>
                  <xsl:if test="/sqroot/header/info/code/settingMode='T'">
                    <th width="10">
                      <xsl:apply-templates select="sqroot/body/bodyContent/browse/header/column[@docStatus=1]" />&#160;
                    </th>
                  </xsl:if>
                  <th width="10">
                    ACTION&#160;
                    <!--
                      <xsl:if test="/sqroot/header/info/code/settingMode!='M'">
                        <xsl:if test="$state &lt; 400">
                          <a href="#">
                            <ix class="fa fa-check" title="Approve All"></ix>
                          </a>
                        </xsl:if>
                        <xsl:if test="$state = 400">
                          <a href="#">
                            <ix class="fa fa-close" title="Close All"></ix>
                          </a>
                        </xsl:if>
                      </xsl:if>
                      <xsl:if test="$state &lt; 500">
                        <a href="#">
                          <ix class="fa fa-trash" title="Delete All"></ix>
                        </a>
                      </xsl:if>
                      -->
                  </th>
                </tr>
              </thead>
              <tbody>
                <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row" />
              </tbody>
            </table>
            <!-- /.box-body -->
            <div class="box-footer clearfix">
              <ul class="pagination pagination-sm no-margin pull-right" id="pagenumbers">
              </ul>
            </div>
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
      </div>
      <!-- browse for pc/laptop -->

      <!-- browse for phone/tablet max width 768 -->

      <div class="row displayblock-phone">
        <div class="col-md-12 full-width-a">
          <div class="box box-solid" style="width:100%;">
            <div class="box-body full-width-a">
              <div class="box-group" id="accordion">

                <!-- we are adding the .panel class so bootstrap.js collapse plugin detects it -->

              </div>
              <div class="box-footer clearfix">
                <ul class="pagination pagination-sm no-margin pull-right">
                  <li>
                    <a href="#">&#171;</a>
                  </li>
                  <li>
                    <a href="#">1</a>
                  </li>
                  <li>
                    <a href="#">2</a>
                  </li>
                  <li>
                    <a href="#">3</a>
                  </li>
                  <li>
                    <a href="#">&#187;</a>
                  </li>
                </ul>
              </div>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
      </div>
      <!-- browse for phone/tablet max width 768 -->

    </section>
    <!-- /.content -->

  </xsl:template>

  <xsl:template match="sqroot/header/menus/menu[@code='newdocument']/submenus/submenu">
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
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/info/states/state/substate">
    <li>
      <a href="javascript:changestateid({@code})">
        <xsl:value-of select="translate(., $smallcase, $uppercase)"/>
      </a>
    </li>

  </xsl:template>
  <xsl:template match="sqroot/body/bodyContent/browse/header/column[@mandatory=1]">
    <th width="10">
      <table class="fixed-table">
        <tr>
          <td>
            <xsl:choose>
              <xsl:when test=".!=''">
                <xsl:value-of select="translate(., $smallcase, $uppercase)" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="translate(@fieldName, $smallcase, $uppercase)" />
              </xsl:otherwise>
            </xsl:choose>
          </td>
        </tr>
      </table>
    </th>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/header/column[@docStatus=1]">
    STATUS
    <xsl:value-of select="translate(., $smallcase, $uppercase)" />
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/content/row">

    <tr class="odd-tr">
      <input id="mandatory{@GUID}" type="hidden" value="" />
      <!--td class="browse-doc-title expand-td">
        &#160;
      </td-->
      <xsl:apply-templates select="fields/field[@mandatory=1]" />
      <td class="expand-td" data-toggle="collapse" data-target="#{@GUID}" data-parent="#{@GUID}">
        <table class="fixed-table">
          <tr>
            <td id="summary{@GUID}">
              <xsl:apply-templates select="fields/field[@mandatory=0]" />&#160;
            </td>
          </tr>
        </table>
      </td>

      <script>
        //put before mandatory section
        fillMobileItem('<xsl:value-of select="@code"/>', '<xsl:value-of select="@GUID" />');
      </script>

      <xsl:if test="/sqroot/header/info/code/settingMode='T'">
        <td class="expand-td" style="text-align:center" data-toggle="collapse" data-target="#{@GUID}" data-parent="#{@GUID}">
          <a href="#" data-toggle="tooltip" title="{docStatus/.}">
            <span class="label label-{docStatus/@labelColor}">
              <xsl:value-of select="docStatus/@title" />
            </span>
          </a>
        </td>
      </xsl:if>

      <xsl:variable name="pageNo" select="/sqroot/body/bodyContent/browse/info/pageNo" />
      <td class="browse-action-button" style="white-space: nowrap;">
        <!--approval icons-->
        <xsl:if test="/sqroot/header/info/code/settingMode='T'">
          <xsl:choose>
            <xsl:when test="$state &lt; 400">
              <a href="javascript:btn_function('{@code}', '{@GUID}', 'execute', '{$pageNo}')">
                <ix class="fa fa-check" title="Approve"></ix>
              </a>
            </xsl:when>
            <xsl:when test="$state &lt; 500">
              <a href="javascript:btn_function('{@code}', '{@GUID}', 'force', '{$pageNo}')">
                <ix class="fa fa-archive" title="Close"></ix>
              </a>
            </xsl:when>
            <xsl:otherwise>
              <a href="javascript:btn_function('{@code}', '{@GUID}', 'force', '{$pageNo}')">
                <ix class="fa fa-undo" title="Reopen"></ix>
              </a>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>

        <!--delete things-->
        <xsl:choose>
          <!--allow delete-->
          <xsl:when test="@onOff=1 and @delete=1 and $state &lt; 500">
            <a href="javascript:btn_function('{@code}', '{@GUID}', 'inactivate', '{$pageNo}')">
              <ix class="fa fa-toggle-off" title="Inactive"></ix>
            </a>
          </xsl:when>
          <xsl:when test="@onOff=0 and @delete=1 and $state &lt; 500">
            <a href="javascript:btn_function('{@code}', '{@GUID}', 'delete', '{$pageNo}')">
              <ix class="fa fa-trash" title="Delete"></ix>
            </a>
          </xsl:when>
          <xsl:when test="$state = 999">
            <a href="javascript:btn_function('{@code}', '{@GUID}', 'restore', '{$pageNo}')">
              <ix class="fa fa-toggle-on" title="Reactivate"></ix>
            </a>
            <a href="javascript:btn_function('{@code}', '{@GUID}', 'wipe', '{$pageNo}')">
              <ix class="fa fa-trash" title="Delete"></ix>
            </a>
          </xsl:when>

          <!--not allow delete-->
          <xsl:when test="@onOff=1 and @delete=0 and $state &lt; 500">
            <a href="#">
              <ix class="fa fa-toggle-off" title="Inactive" style="color:LightGray"></ix>
            </a>
          </xsl:when>
          <xsl:when test="@onOff=0 and @delete=1 and $state &lt; 500">
            <a href="#">
              <ix class="fa fa-trash" title="Delete" style="color:LightGray"></ix>
            </a>
          </xsl:when>
          <xsl:when test="$state = 999">
            <a href="#">
              <ix class="fa fa-toggle-on" title="Reactivate" style="color:lightgray"></ix>
            </a>
            <a href="#">
              <ix class="fa fa-trash" title="Delete" style="color:LightGray"></ix>
            </a>
          </xsl:when>
        </xsl:choose>

        <!--edit things-->
        <xsl:choose>
          <xsl:when test="@edit=1 and $state &lt; 500">
            <a id="edit_{@GUID}" href="javascript:btn_function('{@code}', '{@GUID}', 'formView', '{$pageNo}')">
              <ix class="fa fa-pencil" title="Edit"></ix>
            </a>
          </xsl:when>
          <xsl:otherwise>
            <a href="#">
              <ix class="fa fa-pencil" title="Edit" style="color:LightGray"></ix>
            </a>
          </xsl:otherwise>
        </xsl:choose>

        <xsl:if test="$state &gt; 900">
        </xsl:if>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="fields/field[@mandatory=1]">
    <script>
      var m=$('#mandatory<xsl:value-of select="../../@GUID"/>').val();
      if (m!='' &#38;&#38; '<xsl:value-of select="." />'!='') m+='/';
      m+='<xsl:value-of select="." />';
      $('#mandatory<xsl:value-of select="../../@GUID"/>').val(m);
    </script>
    <td id="mandatory{../../@GUID}" class="expand-td" data-toggle="collapse" data-target="#{../@GUID}" data-parent="#{../@GUID}">
      <xsl:value-of select="." />
    </td>
  </xsl:template>

  <xsl:template match="fields/field[@mandatory='0']">
    <xsl:variable name="tbContent">
      <xsl:choose>
        <xsl:when test="@digit = 0 and .!=''">
          <xsl:value-of select="format-number(., '#,##0', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 1 and .!=''">
          <xsl:value-of select="format-number(., '#,##0.0', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 2 and .!=''">
          <xsl:value-of select="format-number(., '#,##0.00', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 3 and .!=''">
          <xsl:value-of select="format-number(., '#,##0.000', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 4 and .!=''">
          <xsl:value-of select="format-number(., '#,##0.0000', 'dot-dec')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>&#160;
    </xsl:variable>
    <span style="font-weight:bold;">
      <xsl:value-of select="@title" />
    </span>&#160;:&#160;
    <xsl:value-of select="$tbContent" />
    &#160;·&#160;
  </xsl:template>

</xsl:stylesheet>

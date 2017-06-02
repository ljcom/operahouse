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

        <!--$(".ellipsis").dotdotdot({
        watch: "window"
        });-->

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
        addpagenumber('mobilepagenumbers', '<xsl:value-of select ="sqroot/body/bodyContent/browse/info/pageNo"/>', '<xsl:value-of select ="sqroot/body/bodyContent/browse/info/nbPages"/>')
      </script>

      <div class="col-md-12 full-width-a">
        <div class="box-header full-width-a">
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
            <!-- <button type="button" class="btn btn-info btn-lg" style="background:orange; border:none;">DONE</button> -->
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
                  <xsl:apply-templates select="sqroot/body/bodyContent/browse/header/column[@mandatory=1]" />
                  <th>SUMMARY</th>
                  <xsl:if test="/sqroot/header/info/code/settingMode='T'">
                    <th width="10">
                      <xsl:apply-templates select="sqroot/body/bodyContent/browse/header/column[@docStatus=1]" />&#160;
                    </th>
                  </xsl:if>
                  <th width="10">ACTION&#160;
                      <!--<xsl:if test="/sqroot/header/info/code/settingMode!='M'">
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
                      </xsl:if>-->
                  </th>
                </tr>
              </thead>
              <xsl:choose>
                <xsl:when test="sqroot/body/bodyContent/browse/info/permission/allowBrowse/.=1">
                  <tbody id="browseContent">
                    <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row" />
                  </tbody>
                </xsl:when>
                <xsl:otherwise>
                  <tr>
                    <td colspan="100" align="center">
                      <div class="alert alert-warning">You don't have any access to see this list. Please ask the administrator for more information.</div>
                    </td>
                  </tr>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:choose>
                <xsl:when test="not(sqroot/body/bodyContent/browse/content/row) and $state=0">
                  <tr>
                    <td colspan="100" align="center">
                      <div class="alert alert-warning">There is no data available. Create a new one?</div>
                    </td>
                  </tr>
                </xsl:when>
                <xsl:when test="not(sqroot/body/bodyContent/browse/content/row) and $state>0">
                  <tr>
                    <td colspan="100" align="center">
                      <div class="alert alert-warning">There is no data available.</div>
                    </td>
                  </tr>
                </xsl:when>
                <xsl:otherwise>

                </xsl:otherwise>
              </xsl:choose>
            </table>
            <!-- /.box-body -->
            <div class="box-footer clearfix">
              <ul class="pagination pagination-sm no-margin pull-right" id="pagenumbers"></ul>
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
                <xsl:if test="sqroot/body/bodyContent/browse/info/permission/allowBrowse/.=0">
                  <div class="alert alert-warning" align="center">
                    You don't have any access to see this list. Please ask the administrator for more information.
                  </div>
                </xsl:if>
              </div>
            </div>
            <div class="box-footer clearfix">
              <ul class="pagination pagination-sm no-margin pull-right" id="mobilepagenumbers"></ul>
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
      <xsl:apply-templates select="fields/field[@mandatory=1]" />
      <td class="expand-td" data-toggle="collapse" data-target="#brodeta-{@GUID}" data-parent="#brodeta-{@GUID}">
        <table class="fixed-table">
          <tr>
            <td id="summary{@GUID}">
              <xsl:apply-templates select="fields/field[@mandatory=0]" />&#160;
            </td>
          </tr>
        </table>
      </td>

      <!--<script>
        //put before mandatory section
        fillMobileItem('<xsl:value-of select="@code"/>', '<xsl:value-of select="@GUID" />', '<xsl:value-of select="$state" />', '<xsl:value-of select="@edit" />', '<xsl:value-of select="@delete" />', '<xsl:value-of select="@wipe" />', '<xsl:value-of select="@force" />');
      </script>-->

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
              <!--location: 0 header; 1 child; 2 browse
              location: browse:10, header form:20, browse anak:30, browse form:40-->
              <a href="javascript:btn_function('{@code}', '{@GUID}', 'execute', '{$pageNo}', 10)">
                <ix class="fa fa-check" title="Approve"></ix>
              </a>
            </xsl:when>
            <xsl:when test="@force=1 and $state &lt; 500">
              <a href="javascript:btn_function('{@code}', '{@GUID}', 'force', '{$pageNo}', 10)">
                <ix class="fa fa-archive" title="Close"></ix>
              </a>
            </xsl:when>
            <xsl:when test="@force=1 and $state &lt; 600">
              <a href="javascript:btn_function('{@code}', '{@GUID}', 'reopen', '{$pageNo}', 10)">
                <ix class="fa fa-undo" title="Reopen"></ix>
              </a>
            </xsl:when>
          </xsl:choose>
        </xsl:if>

        <!--delete things-->
        <xsl:choose>
          <!--allow delete-->
          <xsl:when test="@onOff=1 and @delete=1 and $state &lt; 500">
            <a href="javascript:btn_function('{@code}', '{@GUID}', 'inactivate', '{$pageNo}', 10)">
              <ix class="fa fa-toggle-off" title="Inactive"></ix>
            </a>
          </xsl:when>
          <xsl:when test="@onOff=0 and @delete=1 and $state &lt; 500">
            <a href="javascript:btn_function('{@code}', '{@GUID}', 'delete', '{$pageNo}', 10)">
              <ix class="fa fa-trash" title="Delete"></ix>
            </a>
          </xsl:when>
          <xsl:when test="$state = 999">
            <a href="javascript:btn_function('{@code}', '{@GUID}', 'restore', '{$pageNo}', 10)">
              <ix class="fa fa-toggle-on" title="Reactivate"></ix>
            </a>
            <xsl:if test="@wipe=1">
              <a href="javascript:btn_function('{@code}', '{@GUID}', 'wipe', '{$pageNo}', 10)">
                <ix class="fa fa-trash" title="Delete"></ix>
              </a>
            </xsl:if>
          </xsl:when>

          <!--not allow delete-->
          <xsl:when test="@onOff=1 and @delete=0 and $state &lt; 500">
            <a href="#">
              <ix class="fa fa-toggle-off" title="Inactive" style="color:LightGray"></ix>
            </a>
          </xsl:when>
          <xsl:when test="@onOff=0 and @delete=0 and $state &lt; 500">
            <a href="#">
              <ix class="fa fa-trash" title="Delete" style="color:LightGray"></ix>
            </a>
          </xsl:when>
          <xsl:when test="$state = 999">
            <a href="#">
              <ix class="fa fa-undo" title="Recover" style="color:lightgray"></ix>
            </a>
            <a href="#">
              <ix class="fa fa-trash" title="Delete" style="color:LightGray"></ix>
            </a>
          </xsl:when>
        </xsl:choose>

        <!--edit things-->
        <xsl:choose>
          <xsl:when test="$state &lt; 999">
            <a id="edit_{@GUID}" href="javascript:btn_function('{@code}', '{@GUID}', 'formView', '{$pageNo}', 10)">
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
    <tr class="tr-detail">
      <td colspan="7" style="padding:0;">
        <div class="browse-data accordian-body collapse" id="brodeta-{@GUID}" style="cursor:default;">
          <table class="table" style="background:gray; color:white">
            <thead>
              <tr>
                <td>STATUS</td>
                <td>DOCUMENT</td>
                <td>CHAT TALK</td>
              </tr>
              <tr>
                <td class="expand-table-an" style="width:40%">                  
                  <xsl:if test="approvals/approval">
                  <table>
                    <tr>
                      <td class="colname-an">
                        <p  class="title-subbrowse">REQUESTED BY</p>
                        <p>
                          <xsl:if test="approvals/approval/@level = 0" >
                            <xsl:value-of select="approvals/approval/name"/>
                          </xsl:if>
                        </p>
                      </td>
                    </tr>
                    <tr>
                      <td class="colname-an">&#160;</td>
                    </tr>
                    <tr>
                      <td class="colname-an">
                        <p class="title-subbrowse">STATUS COMMENT</p>
                        <p><xsl:value-of select="docStatus"/></p>
                      </td>
                    </tr>
                    <tr>
                      <td class="colname-an">&#160;</td>
                    </tr>
                    <tr>
                      <td class="colname-an">
                        <p class="title-subbrowse">
                          <i class="fa fa-clock-o">&#160;</i>WAITING FOR YOUR APPROVAL
                        </p>
                        <p>
                          <i class="fa fa-list" aria-hidden="true">&#160;</i>
                          <span id="more-aprv{@GUID}" onclick="show_aprvList('{@GUID}');" style="color:blue; cursor:pointer;">Show Approval List</span>
                        </p>
                        <div id="aprv-list{@GUID}" style="display:none;">
                          <ul>
                            <xsl:for-each select="approvals/approval">
                              <li>
                                <xsl:value-of select="name"/>&#160;
                                <xsl:choose>
                                  <xsl:when test="date">
                                    Approved On (<xsl:value-of select="date"/>)
                                  </xsl:when>
                                  <xsl:otherwise>
                                    Not Approved Yet
                                  </xsl:otherwise>
                                </xsl:choose>
                              </li>
                            </xsl:for-each>
                          </ul>
                        </div>
                      </td>
                    </tr>
                  </table>
                  </xsl:if>
                </td>
                <td class="expand-table-an" style="width:25%">
                  &#160;                
                </td>
                <td class="expand-table-an" style="width:35%">&#160;                
                  <table>
                    <tr style="padding:10px;">
                      <td colspan="2" class="title-subbrowse">DOC TALK</td>
                    </tr>
                    <tr>
                      <td valign="top" style="padding-right:10px">
                        <img src="OPHContent/themes/{/sqroot/header/info/themeFolder}/images/doc-talk-icon2.png" class="img-circle" alt="User Image" style="width:20px; border:solid 2px white;" />
                      </td>
                      <td>
                        <span style="font-weight:bold">USER 1</span>
                        <br />
                        <span>XXXXXX XXXXXX XXXXXXX</span>
                        <br />
                        <span style="font-size:10px;">1 hours ago</span>
                      </td>
                    </tr>
                    <tr>
                      <td valign="top" style="padding-right:10px">
                        <img src="OPHContent/themes/{/sqroot/header/info/themeFolder}/images/doc-talk-icon2.png" class="img-circle" alt="User Image" style="width:20px; border:solid 2px white;" />
                      </td>
                      <td>
                        <span style="font-weight:bold">USER 2</span>
                        <br />
                        <span>XXXXXX XXXXXX XXXXXXX</span>
                        <br />
                        <span style="font-size:10px;">1 hours ago</span>
                      </td>
                    </tr>
                    <tr>
                      <td valign="top" style="padding-right:10px">
                        <img src="OPHContent/themes/{/sqroot/header/info/themeFolder}/images/doc-talk-icon2.png" class="img-circle" alt="User Image" style="width:20px; border:solid 2px white;" />
                      </td>
                      <td>
                        <span style="font-weight:bold">USER 3</span>
                        <br />
                        <span>XXXXXX XXXXXX XXXXXXX</span>
                        <br />
                        <span style="font-size:10px;">2 hours ago</span>
                      </td>
                    </tr>
                    <tr>
                      <td></td>
                      <td>
                        <input type="text" class="form-control input-sm" placeholder="enter to post" />
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </thead>
          </table>
        </div>
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

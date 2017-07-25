<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>

  <xsl:variable name="state" select="/sqroot/body/bodyContent/browse/info/curState/@substateCode" />
  <xsl:variable name="allowAccess" select="/sqroot/body/bodyContent/browse/info/permission/allowAccess" />
  <xsl:variable name="allowForce" select="/sqroot/body/bodyContent/browse/info/permission/allowForce" />
  <xsl:variable name="allowDelete" select="/sqroot/body/bodyContent/browse/info/permission/allowDelete" />
  <xsl:variable name="allowWipe" select="/sqroot/body/bodyContent/browse/info/permission/allowWipe" />
  <xsl:variable name="allowOnOff" select="/sqroot/body/bodyContent/browse/info/permission/allowOnOff" />

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
                <ix class="icon-doc-draft">
                  <span class="path1"></span>
                  <span class="path2"></span>
                  <span class="path3"></span>
                  <span class="path4"></span>
                  <span class="path5"></span>
                  <span class="path6"></span>
                  <span class="path7"></span>
                  <span class="path8"></span>
                  <span class="path9"></span>
                  <span class="path10"></span>
                  <span class="path11"></span>
                  <span class="path12"></span>
                  <span class="path13"></span>
                  <span class="path14"></span>
                  <span class="path15"></span>
                </ix>&#160;
                <span>
                  <xsl:value-of select="translate(sqroot/body/bodyContent/browse/info/curState/@substateName, $smallcase, $uppercase)"/>
                </span>
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

                  <th>
                    <xsl:if test="count(sqroot/body/bodyContent/browse/header/column[@mandatory=0])>0">SUMMARY</xsl:if>&#160;
                  </th>

                  <xsl:if test="/sqroot/header/info/code/settingMode='T'">
                    <th width="10">
                      <!--<xsl:apply-templates select="sqroot/body/bodyContent/browse/header/column[@docStatus=1]" />-->&#160;
                    </th>
                  </xsl:if>
                  <th width="10">
                    ACTION&#160;
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
                <xsl:when test="sqroot/body/bodyContent/browse/info/permission/allowAccess/.=1">
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
              <div class="box-group" id="accordionBrowse">
                <!-- we are adding the .panel class so bootstrap.js collapse plugin detects it -->
                <xsl:if test="sqroot/body/bodyContent/browse/info/permission/allowAccess/.=0">
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
    <xsl:value-of select="translate(titleCaption/., $smallcase, $uppercase)" />
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
    <tr class="odd-tr">
      <input id="mandatory{@GUID}" type="hidden" value="" />
      <xsl:apply-templates select="fields/field[@mandatory=1]" />

      <td class="expand-td" data-toggle="collapse" data-target="#brodeta-{@GUID}" data-parent="#brodeta-{@GUID}">
        <xsl:if test="count(fields/field[@mandatory=0])>0">
          <table class="fixed-table">
            <tr>
              <td id="summary{@GUID}">
                <xsl:apply-templates select="fields/field[@mandatory=0]" />&#160;
              </td>
            </tr>
          </table>
        </xsl:if>
      </td>

      <script>
        //put before mandatory section
        fillMobileItem('<xsl:value-of select="@code"/>', '<xsl:value-of select="@GUID" />', '<xsl:value-of select="$state" />', '<xsl:value-of select="@edit" />', '<xsl:value-of select="@delete" />', '<xsl:value-of select="@wipe" />', '<xsl:value-of select="@force" />');
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
        <xsl:if test="substring(/sqroot/header/info/code/id, 1, 1) = 'T'">
          <xsl:choose>
            <xsl:when test="$state &lt; 400">
              <!--location: 0 header; 1 child; 2 browse
              location: browse:10, header form:20, browse anak:30, browse form:40-->
              <a href="javascript:btn_function('{@code}', '{@GUID}', 'execute', '{$pageNo}', 10)">
                <ix class="fa fa-check" title="Approve"></ix>
              </a>
            </xsl:when>
            <xsl:when test="$allowForce = 1 and $state &lt; 500">
              <a href="javascript:btn_function('{@code}', '{@GUID}', 'force', '{$pageNo}', 10)">
                <ix class="fa fa-archive" title="Close"></ix>
              </a>
            </xsl:when>
            <xsl:when test="$allowForce = 1 and $state &lt; 600">
              <a href="javascript:btn_function('{@code}', '{@GUID}', 'reopen', '{$pageNo}', 10)">
                <ix class="fa fa-undo" title="Reopen"></ix>
              </a>
            </xsl:when>
          </xsl:choose>
        </xsl:if>

        <!--delete things-->
        <xsl:choose>
          <!--allow delete-->
          <xsl:when test="$allowOnOff = 1 and $allowDelete = 1 and $state &lt; 500">
            <a href="javascript:btn_function('{@code}', '{@GUID}', 'inactivate', '{$pageNo}', 10)">
              <ix class="fa fa-toggle-off" title="Inactive"></ix>
            </a>
          </xsl:when>
          <xsl:when test="$allowOnOff = 0 and $allowDelete = 1 and $state &lt; 500">
            <a href="javascript:btn_function('{@code}', '{@GUID}', 'delete', '{$pageNo}', 10)">
              <ix class="fa fa-trash" title="Delete"></ix>
            </a>
          </xsl:when>
          <xsl:when test="$state = 999">
            <a href="javascript:btn_function('{@code}', '{@GUID}', 'restore', '{$pageNo}', 10)">
              <ix class="fa fa-toggle-on" title="Reactivate"></ix>
            </a>
            <xsl:if test="$allowWipe = 1">
              <a href="javascript:btn_function('{@code}', '{@GUID}', 'wipe', '{$pageNo}', 10)">
                <ix class="fa fa-trash" title="Delete"></ix>
              </a>
            </xsl:if>
          </xsl:when>

          <!--not allow delete-->
          <xsl:when test="$allowOnOff = 1 and $allowDelete = 0 and $state &lt; 500">
            <a href="#">
              <ix class="fa fa-toggle-off" title="Inactive" style="color:LightGray"></ix>
            </a>
          </xsl:when>
          <xsl:when test="$allowOnOff = 0 and $allowDelete = 0 and $state &lt; 500">
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
            <a id="edit_{@GUID}" href="index.aspx?code={@code}&#38;guid={@GUID}">
              <ix class="fa fa-pencil" title="Edit"></ix>
            </a>
          </xsl:when>
          <xsl:otherwise>
            <a href="#">
              <ix class="fa fa-pencil" title="Edit" style="color:LightGray"></ix>
            </a>
          </xsl:otherwise>
        </xsl:choose>
      </td>
    </tr>
    <tr class="tr-detail">
      <td colspan="7" style="padding:0;">
        <div class="browse-data accordian-body collapse" id="brodeta-{@GUID}" style="cursor:default;">
          <div class="row">
            <div class="col-md-12 full-width-a">

              <!--Summary-->
              <xsl:if test="fields/field[@mandatory=0]">
                <div class="box box-primary box-solid" style="max-width:600px;float:left;margin: 10px 10px 10px 10px;">
                  <div class="box-header with-border">
                    <h3 class="box-title">Content of Summary</h3>
                    <div class="box-tools pull-right">
                      <button class="btn btn-box-tool" data-widget="collapse">
                        <ix class="fa fa-minus"></ix>
                      </button>
                    </div>
                  </div>
                  <div class="box-body">
                    <xsl:apply-templates select="fields/field[@mandatory=0]" />                
                  </div>
                </div>
              </xsl:if>

              <!--Status Approval-->
              <xsl:if test="approvals/approval">
                <div class="box box-warning box-solid" style="max-width:300px;float:left;margin: 10px 10px 10px 10px;">
                  <div class="box-header with-border">
                    <h3 class="box-title">Approval List</h3>
                    <div class="box-tools pull-right">
                      <button class="btn btn-box-tool" data-widget="collapse">
                        <ix class="fa fa-minus"></ix>
                      </button>
                    </div>
                  </div>
                  <div class="box-body">
                    <div class="direct-chat-msg">
                      <!--<div class="direct-chat-info clearfix">
                        <span class="direct-chat-name pull-left">
                          Created By
                        </span>
                        <span class="direct-chat-timestamp pull-right">
                          <xsl:value-of select="fields/field[@caption='CreatedUser']"/>
                        </span>
                      </div>-->
                      <!--Approvals-->
                        <!--<br/>
                        <strong>APPROVALS</strong>
                        <hr style="margin:0 0 5px 0;"/>-->
                        <xsl:apply-templates select="approvals"/>
                    </div>
                  </div>
                </div>
              </xsl:if>

              <!--Talks-->
              <div class="box box-danger box-solid direct-chat direct-chat-danger" style="max-width:300px;float:left;margin: 10px 10px 10px 10px;">
                <div class="box-header with-border">
                  <h3 class="box-title">Document Talk</h3>
                  <div class="box-tools pull-right">
                    <!--<span data-toggle="tooltip" title="3 New Messages" class="badge bg-red">3</span>-->
                    <button class="btn btn-box-tool" data-widget="collapse">
                      <ix class="fa fa-plus"></ix>
                    </button>
                  </div>
                </div>
                <xsl:variable name="talkDisplay">
                  <xsl:choose>
                    <xsl:when test="talks/talk">block</xsl:when>
                    <xsl:otherwise>none</xsl:otherwise>
                  </xsl:choose>
                </xsl:variable>
                <div class="box-body" style="display:{$talkDisplay};">
                  <div class="direct-chat-messages" id="chatMessages{@GUID}" >
                    <xsl:apply-templates select="talks/talk"/>
                  </div>
                </div>
                <div class="box-footer">
                  <div class="input-group">
                    <input type="text" id="message{@GUID}" name="message" placeholder="Type Message ..." class="form-control" onkeypress="javascript:enterTalk('{@GUID}', event, '10')"/>
                    <span class="input-group-btn">
                      <button type="button" class="btn btn-danger btn-flat" onclick="javascript:submitTalk('{@GUID}', '10')">Send</button>
                    </span>
                  </div>
                </div>
              </div>

            </div>
          </div>
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
    <xsl:if test=". != ''">
      <span style="font-weight:bold;">
        <xsl:value-of select="@title" />
      </span>
      &#160;:&#160;
      <xsl:value-of select="$tbContent" />
      &#160;·&#160;
    </xsl:if>
  </xsl:template>

  <xsl:template match="approvals">
    <xsl:for-each select="approval">
      <xsl:variable name="aprvStat">
        <xsl:choose>
          <xsl:when test="@status = 400">
            Approved
          </xsl:when>
          <xsl:when test="@status = 300">
            Rejected
          </xsl:when>
          <xsl:otherwise>
            Waiting for Approval
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="aprvColor">
        <xsl:choose>
          <xsl:when test="@status = 400">
            ORANGE
          </xsl:when>
          <xsl:when test="@status = 300">
            RED
          </xsl:when>
          <xsl:otherwise>
            GREY
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="aprvIcon">
        <xsl:choose>
          <xsl:when test="@status = 400">
            fa-user-circle-o
          </xsl:when>
          <xsl:when test="@status = 300">
            fa-user-times
          </xsl:when>
          <xsl:otherwise>
            fa-user
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="aprvName">
        <xsl:choose>
          <xsl:when test="@status = 400">
            &#160;&#160;<xsl:value-of select="name"/>
          </xsl:when>
          <xsl:when test="@status = 300">
            &#160;<xsl:value-of select="name"/>
          </xsl:when>
          <xsl:otherwise>
            &#160;&#160;&#160;&#160;<xsl:value-of select="name"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <div class="direct-chat-info clearfix">
        <span class="direct-chat-name pull-left">
          Level <xsl:value-of select="@level"/>
        </span>
      </div>
      <div class="direct-chat-info clearfix">
        <span class="direct-chat-name pull-left">
          <ix class="fa {$aprvIcon} fa-lg" aria-hidden="true" style="color:{$aprvColor};" title="{$aprvStat}"></ix>
        </span>
        <span class="direct-chat-name pull-left">
          <xsl:value-of select="$aprvName"/>
        </span>
        <span class="direct-chat-timestamp pull-right">
          <xsl:value-of select="date"/>
        </span>
      </div>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="talks/talk">
    <xsl:choose>
      <xsl:when test="@itsMe">
        <div class="direct-chat-msg right">
          <div class="direct-chat-info clearfix">
            <span class="direct-chat-name pull-right">
              <xsl:value-of select="@talkUser"/>
            </span>
            <span class="direct-chat-timestamp pull-left">
              <xsl:value-of select="@talkDateCaption"/>
            </span>
          </div>
          <img class="direct-chat-img" src="OPHContent/documents/{/sqroot/header/info/account}/{@talkUserProfile}" alt="{talkUser}"/>
          <div class="direct-chat-text">
            <xsl:value-of select="@comment"/>
          </div>
        </div>
      </xsl:when>
      <xsl:otherwise>
        <div class="direct-chat-msg">
          <div class="direct-chat-info clearfix">
            <span class="direct-chat-name pull-left">
              <xsl:value-of select="@talkUser"/>
            </span>
            <span class="direct-chat-timestamp pull-right">
              <xsl:value-of select="@talkDateCaption"/>
            </span>
          </div>
          <img class="direct-chat-img" src="OPHContent/documents/{/sqroot/header/info/account}/{@talkUserProfile}" alt="{talkUser}"/>
          <div class="direct-chat-text">
            <xsl:value-of select="@comment"/>
          </div>
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
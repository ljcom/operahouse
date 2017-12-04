<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">

  <xsl:output method="xml" indent="yes"/>
  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:variable name="docStatus" select="sqroot/body/bodyContent/form/info/state/status/." />

  <xsl:template match="/">
    <xsl:variable name="settingmode">
      <xsl:value-of select="/sqroot/body/bodyContent/form/info/settingMode/."/>
    </xsl:variable>
    <xsl:variable name="gotoActive"></xsl:variable>
    <xsl:if test="count(sqroot/body/bodyContent/form/talks/talk)=0">active</xsl:if>
    <xsl:variable name="chatActive">
      <xsl:if test="count(sqroot/body/bodyContent/form/talks/talk)>0">active</xsl:if>
    </xsl:variable>

    <div class="user-panel">
      <div class="pull-left image image-envi data-logo" style="padding:2px; margin-left:7px; margin-top:0px; border:2px inset grey;">
        <xsl:choose>
          <xsl:when test="sqroot/header/info/code/shortName != ''">
            <span>
              <xsl:value-of select="translate(substring(sqroot/header/info/code/shortName, 1, 2), $smallcase, $uppercase)" />
              <br />
              <xsl:value-of select="translate(substring(sqroot/header/info/code/shortName, 3, 2), $smallcase, $uppercase)" />
            </span>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="sqroot/header/info/code/settingMode = 't' or sqroot/header/info/code/settingMode = 'T'">
                <span>
                  <xsl:value-of select="translate(substring(sqroot/header/info/code/id, 3, 2), $smallcase, $uppercase)" />
                  <br />
                  <xsl:value-of select="translate(substring(sqroot/header/info/code/id, 5, 2), $smallcase, $uppercase)" />
                </span>
              </xsl:when>
              <xsl:otherwise>
                <span >
                  <xsl:value-of select="translate(substring(sqroot/header/info/code/id, 1, 2), $smallcase, $uppercase)" />
                  <br />
                  <xsl:value-of select="translate(substring(sqroot/header/info/code/id, 3, 2), $smallcase, $uppercase)" />
                </span>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <div class="pull-left info menu-environtment doc-type-f" style="padding:3px;margin-left:5px;">
        <span>
          <span style="font-size:10pt;">
            <xsl:choose>
              <xsl:when test="$settingmode='T'">
                <xsl:value-of select="sqroot/body/bodyContent/form/info/docNo/."/>
              </xsl:when>
              <xsl:otherwise>
                <!--xsl:value-of select="sqroot/body/bodyContent/form/info/id/."/-->
              </xsl:otherwise>
            </xsl:choose>
          </span>
          <span style="font-size:14pt;">
            <table class="fixed-table">
              <tr>
                <td id="summary{@GUID}">
                  <xsl:choose>
                    <xsl:when test="$settingmode='T'">
                      <xsl:value-of select="sqroot/body/bodyContent/form/info/refNo/."/>
                    </xsl:when>
                    <xsl:otherwise>
                      <!--<xsl:value-of select="sqroot/body/bodyContent/form/info/id/."/>-->
                    </xsl:otherwise>
                  </xsl:choose>
                </td>
              </tr>
            </table>

            <!--xsl:value-of select="sqroot/body/bodyContent/form/info/Description/."/-->
          </span>
        </span>
      </div>
    </div>
    <!-- search form -->
    <div class="input-group sidebar-form">
      <input type="text" id="searchBox" name="searchBox" class="form-control" placeholder="Search..." onkeypress="return searchText(event,this.value);" value="" />
      <span class="input-group-btn">
        <button type="button" name="search" id="search-btn" class="btn btn-flat" onclick="searchText(event);">
          <ix class="fa fa-search" aria-hidden="true"></ix>
        </button>
      </span>
    </div>
    <!--<form action="#" method="get" class="sidebar-form">
      <div class="input-group">
        <input type="text" name="q" class="form-control" placeholder="Search..." />
        <span class="input-group-btn">
          <button type="submit" name="search" id="search-btn" class="btn btn-flat">
            <ix class="fa fa-search" aria-hidden="true"></ix>
          </button>
        </span>
      </div>
    </form>-->
    <!-- sidebar menu: : style can be found in sidebar.less -->
    <ul class="sidebar-menu">
      <!-- <li class="header">MAIN NAVIGATION</li> -->
      <xsl:if test="(sqroot/body/bodyContent/form/children) and (sqroot/body/bodyContent/form/info/GUID)!='00000000-0000-0000-0000-000000000000'">
        <li class="treeview">
          <a href="#">
            <span>
              <ix class="fa  fa-arrow-circle-right"></ix>
            </span>
            <span>&#160;GO TO</span>
            <span class="pull-right-container">
              <ix class="fa fa-angle-left pull-right"></ix>
            </span>
          </a>
          <ul class="treeview-menu view-left-sidebar">
            <li>
              <a href="#header_title">
                <span>
                  <ix class="fa fa-header"></ix>
                </span>&#160;HEADER
              </a>
            </li>
            <li>
              <xsl:apply-templates select="sqroot/body/bodyContent/form/children"/>
            </li>
          </ul>
        </li>
      </xsl:if>

      <!--Document Information-->
      <li class="treeview active">
        <a href="#">
          <span>
            <ix class="fa fa-info-circle"></ix>
          </span>
          <span>&#160;DOCUMENT INFORMATION</span>
          <span class="pull-right-container">
            <ix class="fa fa-angle-left pull-right"></ix>
          </span>
        </a>
        <xsl:apply-templates select="sqroot/body/bodyContent/form/info"/>
      </li>

      <!--Report Query Form-->
      <xsl:variable name ="qpar" select="sqroot/body/bodyContent/form/query/reports/@parameter" />
      <xsl:for-each select="sqroot/body/bodyContent/form/query/reports/report/.">
        <xsl:variable name ="qstate" select="@state" />
        <xsl:variable name ="qcode" select="code" />
        <xsl:variable name ="qname" select="reportName" />
        <xsl:variable name ="qdesc" select="description" />
        <xsl:variable name ="isPDF" select="allowPDF" />
        <xsl:variable name ="isXLS" select="allowXLS" />
        <xsl:variable name ="qsql" select="querySQL" />
        <!--<xsl:if test="$docStatus = $qstate">-->
        <li class="treeview">
          <xsl:if test="$isPDF = 1 and $isXLS = 0" >
            <a href="javascript:genReport('{$qcode}','{$qpar}', 1,'{$qsql}','{$qname}');">
              <span>
                <ix class="fa fa-print"></ix>
              </span>
              <span>
                &#160;<xsl:value-of select="$qdesc"/>
              </span>
            </a>
          </xsl:if>
          <xsl:if test="$isXLS = 1 and $isPDF = 0">
            <a href="javascript:genReport('{$qcode}','{$qpar}', 0,'{$qsql}','{$qname}');" >
              <span>
                <ix class="fa fa-print"></ix>
              </span>
              <span>
                &#160;<xsl:value-of select="$qdesc"/>
              </span>
            </a>
          </xsl:if>
        </li>
        <!--</xsl:if>-->
      </xsl:for-each>

      <!--Approvals-->
      <xsl:if test="sqroot/body/bodyContent/form/approvals/approval" >
        <li class="treeview">
          <a href="#">
            <span>
              <ix class="fa fa-users"></ix>
            </span>
            <span>&#160;APPROVALS</span>
            <span class="pull-right-container">
              <ix class="fa fa-angle-left pull-right"></ix>
            </span>
          </a>
          <ul class="treeview-menu view-left-sidebar">
            <li>
              <dl id="approval-info">
                <xsl:for-each select="sqroot/body/bodyContent/form/approvals/approval/.">
                  <xsl:variable name="aprvstat">
                    <xsl:choose>
                      <xsl:when test="@status = 400">
                        Approved
                      </xsl:when>
                      <xsl:when test="@status = 300">
                        Rejected   
                      </xsl:when>
                      <xsl:otherwise>
                        Not Yet Approved
                      </xsl:otherwise>
                    </xsl:choose>                  
                  </xsl:variable>
                  <dt style="margin: 10px 0 0 0;" data-toggle="tooltip" title="{$aprvstat}">
                    <xsl:choose>
                      <xsl:when test="@status = 400">
                        <div style="float:left">
                          <ix class="fa fa-check-circle"></ix>
                        </div>
                      </xsl:when>
                      <xsl:when test="@status = 300">
                        <div style="float:left">
                          <ix class="fa fa-times-circle"></ix>
                        </div>
                      </xsl:when>
                      <xsl:otherwise>
                        <div style="float:left">
                          <ix class="fa fa-minus-circle"></ix>
                        </div>
                      </xsl:otherwise>
                    </xsl:choose>
                    &#160;<xsl:value-of select="name"/>
                  </dt>
                  <dd style="margin-left:15px;">
                    <xsl:value-of select="date"/>
                  </dd>
                </xsl:for-each>
              </dl>
            </li>
          </ul>
        </li>
      </xsl:if>

      <xsl:if test="$settingmode!='C'">
        <script>
          setTimeout(function () { refreshTalk('<xsl:value-of select="sqroot/body/bodyContent/form/info/GUID" />', '', 20); }, 1000 * 60);

        </script>

        <li class="treeview">
          <a href="#">
            <span>
              <ix class="fa fa-comments"></ix>
            </span>
            <span>&#160;DOC TALK</span>
            <span class="pull-right-container">
              <ix class="fa fa-angle-left pull-right"></ix>
            </span>
          </a>

          <ul class="treeview-menu view-left-sidebar">
            <li>
              <div id="chatMessages" class="direct-chat-messages">
                <xsl:apply-templates select="sqroot/body/bodyContent/form/talks/talk"/>
                <script>
                  var d = $('.direct-chat-messages');
                  d.scrollTop(d.prop("scrollHeight"));
                </script>
                <!-- /.direct-chat-msg -->
              </div>
            </li>
            <li>
              <div class="input-group">
                <input type="text" id="message" name="message" placeholder="Type Message ..." class="form-control" onkeypress="javascript:enterTalk('{@GUID}', event, '20')"/>
                <span class="input-group-btn">
                  <button type="button" class="btn btn-primary btn-flat" onclick="javascript:submitTalk('{@GUID}', '20')">Send</button>
                </span>
              </div>

            </li>
          </ul>
        </li>
      </xsl:if>
    </ul>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/form/talks/talk">
    <xsl:variable name="chatRight">
      <xsl:if test="@itsMe=1">right</xsl:if>
    </xsl:variable>
    <div class="direct-chat-msg {$chatRight}">
      <div class="direct-chat-info clearfix">
        <span class="direct-chat-name pull-right">
          <xsl:value-of select="@talkUser"/>
        </span>
        <span class="direct-chat-timestamp pull-left" title="{@talkDate}">
          <xsl:value-of select="@talkDateCaption"/>
        </span>
      </div>
      <img class="direct-chat-img" src="OPHContent/documents/{/sqroot/header/info/account}/{@talkUserProfile}" alt="{talkUser}"/>
      <div class="direct-chat-text">
        <xsl:value-of select="@comment"/>
      </div>
    </div>

  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/form/info">
    <ul class="treeview-menu view-left-sidebar">
      <li>
        <!--<xsl:if test="docNo/.">
          <dl>
            <dt>
              <span style="font-weight:normal;">Doc No</span>
              <br/>
              <xsl:value-of select="docNo"/>
            </dt>
          </dl>
        </xsl:if>
        <xsl:if test="refNo/.">
          <dl>
            <dt>
              <span style="font-weight:normal;">Ref No</span>
              <br/>
              <xsl:value-of select="refNo"/>
            </dt>
          </dl>
        </xsl:if>
        <xsl:if test="docDate/.">
          <dl>
            <dt>
              <span style="font-weight:normal;">Doc Date</span>
              <br/>
              <xsl:value-of select="docDate"/>
            </dt>
          </dl>
        </xsl:if>-->
        <xsl:if test="state/statuscomment/.">
          <dl>
            <dt>
              <span style="font-weight:normal;">Status Comment</span>
              <br/>
              <xsl:value-of select="state/statuscomment"/>
            </dt>
          </dl>
        </xsl:if>
        <xsl:if test="document/createdDate/.">
          <dl>
            <dt>
              <span style="font-weight:normal;">Created On</span>
              <br/>
              <xsl:value-of select="document/createdDate"/>
            </dt>
          </dl>
        </xsl:if>
        <xsl:if test="document/createdUser/.">
          <dl>
            <dt>
              <span style="font-weight:normal;">Created By</span>
              <br/>
              <xsl:value-of select="document/createdUser"/>
            </dt>
          </dl>
        </xsl:if>
        <xsl:if test="document/updatedDate/.">
          <dl>
            <dt>
              <span style="font-weight:normal;">Updated On</span>
              <br/>
              <xsl:value-of select="document/updatedDate"/>
            </dt>
          </dl>
        </xsl:if>
        <xsl:if test="document/updatedUser/.">
          <dl>
            <dt>
              <span style="font-weight:normal;">Updated By</span>
              <br/>
              <xsl:value-of select="document/updatedUser"/>
            </dt>
          </dl>
        </xsl:if>
        <xsl:if test="document/isDelete/. = 1">
          <xsl:if test="document/isDeleted/.">
            <dl>
              <dt>
                <span style="font-weight:normal;">Status Document</span>
                <br/>
                Deleted
              </dt>
            </dl>
          </xsl:if>
          <xsl:if test="document/deletedDate/.">
            <dl>
              <dt>
                <span style="font-weight:normal;">Deleted On</span>
                <br/>
                <xsl:value-of select="document/deletedDate"/>
              </dt>
            </dl>
          </xsl:if>
          <xsl:if test="document/deletedUser/.">
            <dl>
              <dt>
                <span style="font-weight:normal;">Deleted By</span>
                <br/>
                <xsl:value-of select="document/deletedUser"/>
              </dt>
            </dl>
          </xsl:if>
        </xsl:if>  
      </li>
    </ul>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/form/approvals">
    <ul class="treeview-menu view-left-sidebar">
      <li>
        <dl id="approval-info">
          <xsl:apply-templates select="approval"/>
        </dl>
      </li>
    </ul>
  </xsl:template>

  <xsl:template match="approval">

    <dt>
      <xsl:value-of select="username"/>
    </dt>
    <dt>Level</dt>
    <dd>
      <xsl:value-of select="lvl"/>
    </dd>
    <dt>Status</dt>
    <dd>
      <xsl:if test="status='400'" > Approved</xsl:if>
    </dd>
  </xsl:template>

  <xsl:template match="sqroot/widgets/widget[@code='TALK']/talks">
    <xsl:apply-templates select="talk"/>
  </xsl:template>

  <xsl:template match="talk">
    <dt>
      <xsl:value-of select="createduser"/>
    </dt>
    <dd>
      <xsl:value-of select="createddate"/>
    </dd>
    <dd>
      <xsl:value-of select="doccomment"/>
    </dd>
    <dd>
      <xsl:value-of select=" docattachment"/>
    </dd>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/form/children">
    <xsl:apply-templates  select="child"/>
  </xsl:template>

  <xsl:template match="child">
    <a href="#child{code/.}">
      <span>
        <ix class="fa fa-list-alt"></ix>
      </span>&#160;
      <xsl:value-of select="childTitle"/>
    </a>

  </xsl:template>

</xsl:stylesheet>



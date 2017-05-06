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

    <div class="user-panel">
      <div class="pull-left image image-envi data-logo" style="padding:0;  margin-left:7px; margin-top:2px;">
        <span >
          <xsl:value-of select="translate(substring(sqroot/header/info/code/id, 1, 2), $smallcase, $uppercase)" />
          <br />
          <xsl:value-of select="translate(substring(sqroot/header/info/code/id, 3, 2), $smallcase, $uppercase)" />
        </span>
      </div>
      <div class="pull-left info menu-environtment doc-type-f" style="padding:0;margin-left:-5px;">
        <span>
          <span style="font-size:9pt;">
            <xsl:choose>
              <xsl:when test="$settingmode='T'">
                <xsl:value-of select="sqroot/body/bodyContent/form/info/docNo/."/>
              </xsl:when>
              <xsl:otherwise>
                <!--xsl:value-of select="sqroot/body/bodyContent/form/info/id/."/-->
              </xsl:otherwise>
            </xsl:choose>

          </span>
          <br />
          <span style="font-size:14pt;">
            <xsl:choose>
              <xsl:when test="$settingmode='T'">
                <xsl:value-of select="sqroot/body/bodyContent/form/info/refNo/."/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="sqroot/body/bodyContent/form/info/id/."/>
              </xsl:otherwise>
            </xsl:choose>
            <!--xsl:value-of select="sqroot/body/bodyContent/form/info/Description/."/-->
          </span>


        </span>
      </div>
    </div>
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
    <ul class="sidebar-menu">
      <!-- <li class="header">MAIN NAVIGATION</li> -->
      <xsl:if test="(sqroot/body/bodyContent/form/children) and (sqroot/body/bodyContent/form/info/GUID)!='00000000-0000-0000-0000-000000000000'">
        <li class="treeview active">
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
            <!-- <li><a href="browse.html"><ix class="fa fa-list-alt"></ix> CHILD 2</a></li> -->
          </ul>
        </li>
      </xsl:if>

      <li class="treeview">
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

      <xsl:if test="substring(sqroot/body/bodyContent/form/info/code, 1, 1) = 't'">

        <li class="treeview">
          <a href="#">
            <span>
              <ix class="fa fa-users"></ix>
            </span>
            <span>&#160;APPROVAL</span>
            <span class="pull-right-container">
              <ix class="fa fa-angle-left pull-right"></ix>
            </span>
          </a>

          <xsl:apply-templates select="sqroot/body/bodyContent/form/approvals"/>
          <ul class="treeview-menu view-left-sidebar">
            <li>
              <dl id="approval-info">
                <dt>
                  <ix class="fa  fa-check-circle"></ix> Mikaela Grace
                </dt>
                <dd style="margin-left:15px;">1 hours ago</dd>
                <dt>
                  <ix class="fa   fa-check-circle"></ix> SHEDEA Maria Onawa
                </dt>
                <dd style="margin-left:15px;">1 minutes ago</dd>
                <dt>
                  <ix class="fa  fa-minus-circle"></ix> SUSILA Yitna
                </dt>
              </dl>
            </li>
          </ul>
        </li>

      </xsl:if>
      <li class="treeview">
        <a href="#">
          <span>
            <ix class="fa fa-wechat"></ix>
          </span>
          <span>&#160;DOCUMENT TALK</span>
          <span class="pull-right-container">
            <ix class="fa fa-angle-left pull-right"></ix>
          </span>
        </a>
        <ul class="treeview-menu view-left-sidebar">
          <li>
            <dl>
              <dl id="doctalk-info">
                <xsl:apply-templates select="sqroot/docTalks"/>
              </dl>
              <input type="text" class="form-control" placeholder="Press Enter to Comment" style="max-width:200px;"/>
            </dl>
          </li>
        </ul>
      </li>
    </ul>
  </xsl:template>


  <xsl:template match="sqroot/body/bodyContent/form/info">
    <ul class="treeview-menu view-left-sidebar">
      <li>
        <dl>
          <dl>Doc No</dl>

          <dt>
            <xsl:apply-templates select="docNo"/>
          </dt>
        </dl>
        <dl>
          <dl>Ref No</dl>

          <dt>
            <xsl:apply-templates select="refNo"/>
          </dt>
        </dl>
        <dl>
          <dl>Doc Date</dl>
          <dt>
            <xsl:apply-templates select="docDate"/>
          </dt>
        </dl>
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



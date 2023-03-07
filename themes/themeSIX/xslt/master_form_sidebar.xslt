<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">

  <xsl:output method="xml" indent="yes"/>
  
  <xsl:template match="/">
	<script>
	$('body').addClass('sidebar-collapse').trigger('sidebar-animated');
	</script>
    <xsl:variable name="settingmode">
      <xsl:value-of select="/sqroot/body/bodyContent/form/info/settingMode/."/>
    </xsl:variable>
    <xsl:variable name="gotoActive">
      <xsl:if test="count(sqroot/body/bodyContent/form/talks/talk)=0">active</xsl:if>
    </xsl:variable>
    <xsl:variable name="chatActive">
      <xsl:if test="count(sqroot/body/bodyContent/form/talks/talk)>0">active</xsl:if>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="/sqroot/body/bodyContent/form/info/permission/ShowDocInfo/.=1">
        <div class="user-panel">

          <div class="pull-left image image-envi data-logo" style="border: 0px;margin-top:-5px">
            <span class="fa-layers fa-fw fa-4x">
              <ix class="fas fa-4x fa-inverse fa-square"></ix>
              <span class="fa-layers-text fa-text-1x" data-fa-transform="shrink-11.5 down-4">

                <xsl:choose>
                  <xsl:when test="/sqroot/header/info/code/shortName != ''">
                    <span>
                      <xsl:value-of select="translate(substring(sqroot/header/info/code/shortName, 1, 2), $smallcase, $uppercase)" />
                      <br />
                      <xsl:value-of select="translate(substring(sqroot/header/info/code/shortName, 3, 2), $smallcase, $uppercase)" />
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
              </span>
            </span>
          </div>
          <div class="pull-left info menu-environtment doc-type-f" style="padding:0;margin-left:10px;margin-left:10px">
            <span>
              <div style="font-size:9pt;" id="docNo">
                <xsl:choose>
                  <xsl:when test="$settingmode='T'">
                    <xsl:value-of select="/sqroot/body/bodyContent/form/info/docNo/."/>&#160;
                  </xsl:when>
                  <xsl:otherwise>
                    <!--xsl:value-of select="/sqroot/body/bodyContent/form/info/id/."/-->&#160;
                  </xsl:otherwise>
                </xsl:choose>
              </div>
              <div style="font-size:14pt;">
                <table class="fixed-table">
                  <tr>
                    <td id="docRefNo">
                      <xsl:choose>
                        <xsl:when test="$settingmode='T'">
                          <xsl:value-of select="/sqroot/body/bodyContent/form/info/refNo/."/>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:value-of select="/sqroot/body/bodyContent/form/info/id/."/>
                        </xsl:otherwise>
                      </xsl:choose>
                    </td>
                  </tr>
                </table>
                <!--xsl:value-of select="/sqroot/body/bodyContent/form/info/Description/."/-->
              </div>
			        <div style="font-size:9pt;" id="docDate">
                <xsl:choose>
                  <xsl:when test="$settingmode='T'">
                    <xsl:value-of select="/sqroot/body/bodyContent/form/info/docDate/."/>&#160;
                  </xsl:when>
                  <xsl:otherwise>
                    <!--xsl:value-of select="/sqroot/body/bodyContent/form/info/id/."/-->&#160;
                  </xsl:otherwise>
                </xsl:choose>
              </div>			  
            </span>
          </div>
        </div>
        <!-- search form -->
        <div class="input-group sidebar-form">
          <input type="text" id="searchBox" name="searchBox" class="form-control" placeholder="Search..." onkeypress="return searchText(event, this.value, 20);" value="" />
          <span class="input-group-btn">
            <button type="button" name="search" id="search-btn" class="btn btn-flat" onclick="searchText(event, null, 20);">
              <ix class="fa fa-search" aria-hidden="true"></ix>
            </button>
			      <button type="button" name="draft" id="draft-btn" class="btn btn-flat" onclick="loadSearchResult('', 1);">
              <ix class="fa fa-pen-square" aria-hidden="true"></ix>
            </button>
          </span>
        </div>
        <!-- sidebar menu: : style can be found in sidebar.less -->
		
        <ul class="sidebar-menu">
		  
          <li class="treeview hidden" id="tabSearchResult">
            <a href="#">
              <span>
                <ix class="fa fa-search"></ix>
              </span>
              <span class="info">&#160;SEARCH RESULT</span>
              <span class="pull-right-container">
                <ix class="fa fa-angle-left pull-right"></ix>
              </span>
            </a>
            <ul class="treeview-menu view-left-sidebar info">
			        <div class="direct-chat-messages" style="height:350px" id="searchResult">
                <li>
                  <a class="info" href="#">
                    <span>
                      <ix class="fa fa-header"></ix>
                    </span >No results
                  </a>
                </li>
              </div>
            </ul>
          </li>
          <li class="treeview" id="tabMenu">
            <a href="#">
              <span>
                <ix class="fa fa-bars"></ix>
              </span>
              <span class="info">&#160;MENU</span>
              <span class="pull-right-container">
                <ix class="fa fa-angle-left pull-right"></ix>
              </span>
            </a>
            <ul class="treeview-menu browse-left-sidebar">
              <xsl:apply-templates select="/sqroot/header/menus/menu[@code='sidebar']/submenus/submenu" />
                  
            </ul>			
          </li>

          <xsl:if test="(sqroot/body/bodyContent/form/children) and (sqroot/body/bodyContent/form/info/GUID)!='00000000-0000-0000-0000-000000000000'">
            <li class="treeview" id ="gotoPanel">
              <a href="#">
                <span>
                  <ix class="fa  fa-arrow-circle-right"></ix>
                </span>
                <span class="info">&#160;GO TO</span>
                <span class="pull-right-container">
                  <ix class="fa fa-angle-left pull-right"></ix>
                </span>
              </a>
              <ul class="treeview-menu view-left-sidebar info">
                <li>
                  <a class="info" href="#">
                    <span>
                      <ix class="fa fa-header"></ix>
                    </span >&#160;HEADER
                  </a>
                  <xsl:apply-templates select="/sqroot/body/bodyContent/form/children"/>
                </li>
              </ul>
            </li>
          </xsl:if>

          <!--Document Information-->
          <li class="treeview active" id="docInfoPanel">
            <a href="#">
              <span>
                <ix class="fa fa-info-circle"></ix>
              </span>
              <span class="info">&#160;DOCUMENT INFORMATION</span>
              <span class="pull-right-container">
                <ix class="fa fa-angle-left pull-right"></ix>
              </span>
            </a>
            <xsl:apply-templates select="/sqroot/body/bodyContent/form/info"/>
          </li>

          <!--Approvals-->
          <xsl:if test="/sqroot/body/bodyContent/form/approvals/approval" >
            <li class="treeview" id="aprvPanel">
              <a href="#">
                <span>
                  <ix class="fa fa-users"></ix>
                </span>
                <span class="info">&#160;APPROVAL LIST</span>
                <span class="pull-right-container">
                  <ix class="fa fa-angle-left pull-right"></ix>
                </span>
              </a>
              <ul class="treeview-menu view-left-sidebar info">
                <li>
                  <dl id="approval-info">
                    <xsl:for-each select="/sqroot/body/bodyContent/form/approvals/approval/.">
                      <dt style="margin: 10px 0 0 0;">
                        <xsl:choose>
                          <xsl:when test="@status = 400">
                            <ix class="fa fa-check-circle"></ix>
                          </xsl:when>
                          <xsl:otherwise>
                            <ix class="fa fa-minus-circle"></ix>
                          </xsl:otherwise>
                        </xsl:choose>
                        &#160;<xsl:value-of select="name"/><!--(Lv. <xsl:value-of select="@level"/>)-->
                        <xsl:if test="delegateName">
                          &#160;<small>
                            (delegated by <xsl:value-of select="delegateName"/>)
                          </small>
                        </xsl:if>
                        <br/>
                        <xsl:if test="@status =0">
                          &#160;

                          <div class="input-group">
                            <input type="password" id="txtpwd{aprvUserGUID}" name="message" placeholder="Type Password ..." class="form-control" />
                            <span class="input-group-btn">
                              <button type="button" class="btn btn-primary btn-flat" style="color:white;background-color: #ff9900" onclick="javascript:executeFunction('{/sqroot/body/bodyContent/form/info/code/.}','{/sqroot/body/bodyContent/form/info/GUID/.}','execute','21','{aprvUserGUID}' )">Approve</button>
                            </span>
                          </div>

                        </xsl:if>
                      </dt>

                      <dd style="margin-left:15px;">
                        <xsl:value-of select="date"/>
                      </dd>

                      <!--<xsl:choose>
                    <xsl:when test="@status = 400">
                      <dt>
                        <ix class="fa fa-check-circle"></ix> 
                          <xsl:value-of select="name"/> (Lv. <xsl:value-of select="@level"/>)
                      </dt>
                      <dd style="margin-left:15px;"><xsl:value-of select="date"/></dd>
                    </xsl:when>
                    <xsl:otherwise>
                      <dt>
                        <ix class="fa fa-minus-circle"></ix>
                          <xsl:value-of select="name"/> (Lv. <xsl:value-of select="@level"/>)
                      </dt>
                      <dd style="margin-left:15px;"><xsl:value-of select="date"/></dd>
                    </xsl:otherwise>
                  </xsl:choose>-->
                    </xsl:for-each>
                  </dl>
                </li>
              </ul>
            </li>
          </xsl:if>

          <xsl:if test="$settingmode!='C' and /sqroot/body/bodyContent/form/info/permission/ShowDocTalk/.=1">
            <script>
              setTimeout(function () { refreshTalk('<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID" />', '', 20); }, 1000 * 60);
            </script>

            <li class="treeview" id="docTalkPanel">
              <a href="#">
                <span>
                  <ix class="fa fa-comments"></ix>
                </span>
                <span class="info">&#160;DOC TALK</span>
                <span class="pull-right-container">
                  <ix class="fa fa-angle-left pull-right"></ix>
                </span>
              </a>
              <ul class="treeview-menu view-left-sidebar info">
                <li>
                  <div id="chatMessages" class="direct-chat-messages">
                    <xsl:apply-templates select="/sqroot/body/bodyContent/form/talks/talk"/>
                    <script>
                      var d = $('.direct-chat-messages');
                      d.scrollTop(d.prop("scrollHeight"));
                    </script>
                    <!-- /.direct-chat-msg -->
                  </div>
                </li>
                <li>
                  <div class="input-group">
                    <input type="text" id="message" name="message" placeholder="Type Message ..." class="form-control" onkeypress="javascript:enterTalk('{@GUID}', event, '20')" autocomplete="off"/>
                    <span class="input-group-btn">
                      <button type="button" class="btn btn-primary btn-flat" onclick="javascript:submitTalk('{@GUID}', '20')">Send</button>
                    </span>
                  </div>

                </li>
              </ul>
            </li>
          </xsl:if>
        </ul>

      </xsl:when>
      <xsl:otherwise>
        <script>
          $("#searchBox").val(getSearchText());
          var c=getQueryVariable('code').toLowerCase();
          try {
          $($('.treeview').children().find('a[href$="='+c+'"]')[0].parentNode.parentNode.parentNode.parentNode.parentNode).addClass('active');
          $($('.treeview').children().find('a[href$="='+c+'"]')[0].parentNode.parentNode.parentNode).addClass('active');
          $($('.treeview').children().find('a[href$="='+c+'"]')[0].parentNode).addClass('active');
          } catch(e) {}
        </script>

        <div class="user-panel">
          <div class="pull-left image">
            <img src="OPHContent/documents/{sqroot/header/info/suba}/{sqroot/header/info/user/userURL}" class="img-circle" alt="User Image" />
          </div>
          <div class="pull-left info">
            <p>
              <xsl:value-of select="/sqroot/header/info/user/userName"/>
            </p>
            <a href="#">
              <ix class="fa fa-circle text-success"></ix> Online
            </a>
          </div>
        </div>
        <div class="input-group sidebar-form">
          <input type="text" id="searchBox" name="searchBox" class="form-control" placeholder="Search..." onkeypress="return searchText(event, this.value);" value="" />
          <span class="input-group-btn">
            <button type="button" name="search" id="search-btn" class="btn btn-flat" onclick="return searchText(event);">
              <ix class="fa fa-search" aria-hidden="true"></ix>
            </button>
          </span>
        </div>
        <ul class="sidebar-menu">
          <xsl:apply-templates select="/sqroot/header/menus/menu[@code='sidebar']/submenus/submenu" />
        </ul>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:include href="_form_sidebar.xslt" />

</xsl:stylesheet>



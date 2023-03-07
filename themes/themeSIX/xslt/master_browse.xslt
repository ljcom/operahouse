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

  <!--Table colspan-->
  <xsl:variable name="cMandatory">
    <xsl:value-of select="count(sqroot/body/bodyContent/browse/header/column[@mandatory=1])"/>                        
  </xsl:variable>
  <xsl:variable name="cSummary">
    <xsl:choose>
      <xsl:when test="sqroot/body/bodyContent/browse/header/column[@mandatory=0]">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="cDelegated">
    <xsl:value-of select="sqroot/body/bodyContent/browse/info/isDelegated"/>                        
  </xsl:variable>
  <xsl:variable name="cDelegator">
    <xsl:choose>
      <xsl:when test="sqroot/body/bodyContent/browse/info/isDelegator = 0">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="tMode">
    <xsl:choose>
      <xsl:when test="sqroot/header/info/code/settingMode='T'">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="tcolspan" select="$cMandatory + $cSummary + $cDelegated + $cDelegator + $tMode + 1"/>
  
  <xsl:template match="/">
  <!--Re-Modeled by eLs-->
    <script>
      //loadScript('OPHContent/cdn/select2/select2.full.min.js');
      <xsl:if test="sqroot/body/bodyContent/browse/info/buttons">
        buttons=<xsl:value-of select="sqroot/body/bodyContent/browse/info/buttons"/>;
        loadExtraButton(buttons, 'browse-action-button');
      </xsl:if>
      
     
      
      $("input:checkbox").not("#pinnedAll").click(function() {
        var odd = $(this).parents(".odd-tr");
        var even = $(odd).next();
        
        if (this.checked) {          
          $("#actionHeader span").hide();
          $("#actionHeader div").show();
                                       
          if ($("input:checkbox").not("#pinnedAll").length == $("input:checked").not("#pinnedAll").length)
            $("#pinnedAll").prop('checked', 'checked');
        } 
        else {          
          if ($("input:checked").not("#pinnedAll").length != $("input:checkbox").not("#pinnedAll").length)
            $("#pinnedAll").prop('checked', false);
        }
      
        if($("input:checked").not("#pinnedAll").length == 0){
          $("#actionHeader span").show();
          $("#actionHeader div").hide();
        }
      });
    </script>

    <!--Delegator Action Modal-->
    <xsl:if test="sqroot/body/bodyContent/browse/info/isDelegator = 1">
      <div id="delegatorModal" class="modal fade" role="dialog">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="delegatorModal(0, '{sqroot/header/info/code/id}')">
                <span aria-hidden="true">&#215;</span>
              </button>              
              <h3>Are you sure you want to revoke your delegation?</h3>
            </div>
            <div class="modal-body">
              <p>
                Since you have delegated this module to someone else, you need to revoke your delegation to gain your full access to this module.
                But if you choose not to revoke your delegation, you will have no fully access to this module.
              </p>
              <p>If you want to set / modify your delegation later, please abandon this notification and go to your menu profile instead.</p>
            </div>
            <div class="modal-footer">
              <button id="btnRevokeLater" type="button" class="btn btn-default" data-dismiss="modal" onclick="delegatorModal(false)">No, I'll do it later</button>
              <button id="btnRevoke" type="button" class="btn btn-primary" data-loading-text="Revoking in process..." onclick="delegatorModal(true)">Yes, Revoke my delegate now</button>
            </div>
          </div>
        </div>
      </div>
      <script>
        $(document).ready(function(){
          var isShow = 1;
          var cname = '<xsl:value-of select="sqroot/header/info/code/id"/>_dmc';
          isShow = (getCookie(cname) == null || getCookie(cname) == undefined || getCookie(cname) == '') ? 1 : 0;
          if (isShow == 1) {
            $('#delegatorModal').modal({ backdrop: "static" });
          }          
        });                    
      </script>
    </xsl:if>

    <!--Delegation Info alert-->
    <xsl:if test="sqroot/body/bodyContent/browse/info/isDelegated = 1 and sqroot/body/bodyContent/browse/info/isDelegator = 0">
      <div id="delegationAlert" class="alert alert-warning alert-dismissable fade in">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&#215;</button>
        <h4>
          <ix class="icon fa fa-info"></ix>&#160; Attention
        </h4>
        You are assigned as a delegation for this module. Expand the "Advanced Filters Box" below to filtering between your documents or the delegators.
      </div>
      <script>
        $("#delegationAlert").fadeTo(10000, 800).slideUp(800, function(){
          $("#delegationAlert").slideUp(800);
        });
      </script>
    </xsl:if>

    <!-- Content Header (Page header) -->
    
    <!-- Main content-->
    <section class="flat-row flat-contact-form style5">
      <div class="container">
        <!--Access Authority and Permission-->
        <xsl:choose>
        <xsl:when test="$allowAccess = 1">
          <xsl:if test="sqroot/body/bodyContent/browse/info/nbPages > 1">
            <script>
              addpagenumber('pagenumbers', '<xsl:value-of select ="sqroot/body/bodyContent/browse/info/pageNo"/>', '<xsl:value-of select ="sqroot/body/bodyContent/browse/info/nbPages"/>')
              addpagenumber('mobilepagenumbers', '<xsl:value-of select ="sqroot/body/bodyContent/browse/info/pageNo"/>', '<xsl:value-of select ="sqroot/body/bodyContent/browse/info/nbPages"/>')
            </script>
          </xsl:if>
          
          <div class="row">                
            <!--Status and Button--> 
            <div class="col-md-12" style="padding-bottom:10px">
              <!--<div class="text-right">
                <xsl:if test="sqroot/body/bodyContent/browse/info/permission/allowExport = 1">
                  <button id="btnExport" class="btn btn-success" data-clicked="0" onclick="window.location='?code={sqroot/header/info/code/id}&amp;mode=export'">
                    <strong>UPLOAD SECTION</strong>
                  </button>
                </xsl:if>
                <button id="newdoc" class="btn btn-warning" onclick="window.location='?code={sqroot/header/info/code/id}&amp;guid=00000000-0000-0000-0000-000000000000'">
                  <xsl:if test="sqroot/body/bodyContent/browse/info/permission/allowAdd = 0">
                    <xsl:attribute name="disabled">disabled</xsl:attribute>
                  </xsl:if>
                  <strong>NEW DOCUMENT</strong>
                </button>
              </div>-->
              <div class="breadcrumbs">
                <ul style="text-align:center;">
                  <li>
                    <a href="?" title="">Home</a>
                    <i class="fa fa-angle-right" aria-hidden="true">&#xA0;</i>
                  </li>
                  <li>
                    <a href="#"  style="pointer-events: none;">
                      <xsl:value-of select="sqroot/header/info/code/name/." /> List
                    </a>
                  </li>
                </ul>
              </div>

              <xsl:if test="/sqroot/body/bodyContent/browse/info/permission/allowAdd/.=1">
                <div style="text-align:center; margin-top:30px;">
                  <a href="?code={sqroot/header/info/code/id}&amp;guid=00000000-0000-0000-0000-000000000000"  style="background:#1490d7; color:white; padding:10px; border-radius:2px;">NEW DOCUMENT</a>
                </div>
              </xsl:if>
             <!--  <xsl:if test="sqroot/body/bodyContent/browse/info/permission/allowExport = 1">
                <div style="text-align:center; margin-top:20px">
                  <button id="btnExport" class="flat-button-form border-radius-2" data-clicked="0" onclick="window.location='?code={sqroot/header/info/code/id}&amp;mode=export'">
                    UPLOAD SECTION
                  </button>
                </div>
              </xsl:if> -->
              <div class="browse-dropdown-status">
                <div class="dropdown">
                  <ul class="menu flat-unstyled" style="margin-right:0; padding-right:0; text-align:center;">
                    <li class="login"  style="margin-left:0;float:none;">
                      <ix class="fa fa-file-text-o" aria-hidden="true">&#xA0;</ix>&#160;
                      <a href="#" title="" style="pointer-events:none;">
                          <xsl:value-of select="translate(sqroot/body/bodyContent/browse/info/curState/@substateName, $smallcase, $uppercase)"/>

                        <i class="fa fa-angle-down" aria-hidden="true">&#xA0;</i>
                      </a>
                      <ul id="statusContent" class="unstyled border-radius-5 box-shadow" style="width:200px; margin-left:-60px;">
                        <xsl:apply-templates select="sqroot/body/bodyContent/browse/info/states/state/substate" />
                      </ul>
                    </li>
                    <!--<li class="login">
                      <a href="?code={sqroot/header/info/code/id}&amp;guid=00000000-0000-0000-0000-000000000000"  style="background:#1490d7; color:white; padding:10px; border-radius:2px;">NEW DOCUMENT</a>
                    </li>-->
                  </ul>
                  <!--<button id="statusFilter" class="dropdown-toggle" type="button" data-toggle="dropdown" >
                    <ix class="fa fa-file-text-o" aria-hidden="true"></ix>&#160;
                    <span style="font-family: 'Source Sans Pro','Helvetica Neue',Helvetica,Arial,sans-serif; font-weight:bold; font-size:smaller">
                      <xsl:value-of select="translate(sqroot/body/bodyContent/browse/info/curState/@substateName, $smallcase, $uppercase)"/>
                    </span>
                  </button>
                  <ul id="statusContent" class="dropdown-menu browse-dropdown-content">
                    <xsl:apply-templates select="sqroot/body/bodyContent/browse/info/states/state/substate" />
                  </ul>-->
                </div>
              </div>

              <div style="border-top:2px #DDDDDD solid; padding-top:10px; position:relative;">

                <input style="width:20%; border-radius:2px; padding:0px 10px; " type="text" id="searchBox" name="searchBox" class="form-control" placeholder="Search..." onkeypress="return searchText(event,this.value);" value=""/>
                 <xsl:if test="sqroot/body/bodyContent/browse/info/permission/allowExport = 1">
                <button id="btnExport" style="position:absolute; right:0; top:10px;" class="flat-button-form border-radius-2" data-clicked="0" onclick="window.location='?code={sqroot/header/info/code/id}&amp;mode=export'">
                    Upload Section
                  </button>
              </xsl:if>
              </div>
            </div>
      
            <!--Browse Filters-->
            <xsl:if test="sqroot/body/bodyContent/browse/info/filters">
              <div class="col-md-12">
                <div id="bfBox">
                  <xsl:attribute name="class">
                    <xsl:choose>
                      <xsl:when test="sqroot/body/bodyContent/browse/info/filters/*/value">box box-default</xsl:when>
                      <xsl:otherwise>box box-default collapsed-box</xsl:otherwise>
                    </xsl:choose>
                  </xsl:attribute>
                  <div class="box-header with-border">
                    <button id="btnAdvancedFilter" type="button" class="btn btn-box-tool" data-widget="collapse">
                      <ix aria-hidden="true">
                        <xsl:attribute name="class">
                          <xsl:choose>
                            <xsl:when test="sqroot/body/bodyContent/browse/info/filters/*/value">fa fa-minus</xsl:when>
                            <xsl:otherwise>fa fa-plus</xsl:otherwise>
                          </xsl:choose>
                        </xsl:attribute>
                      </ix>
                      Advanced Filters
                      <xsl:if test="sqroot/body/bodyContent/browse/info/filters/*/value">(ACTIVE)</xsl:if>
                    </button>
                  </div>
                  <div class="box-body">
                    <form id="formFilter">
                      <xsl:apply-templates select="sqroot/body/bodyContent/browse/info/filters" />
                    </form>
                  </div>
                </div>
              </div>
            </xsl:if>
          </div>
      
          <!-- browse for pc/laptop -->
          <div class="row visible-phone">
            <div class="col-md-12">
              <div class="box">
                <table id="tblBrowse" class="table table-condensed table-stripped dataTable">
                  <thead id="browseHead">
                    <tr class="trhead">
                      <xsl:if test="sqroot/body/bodyContent/browse/info/isDelegator = 0">
                        <th style="width:10px;" name="th_checkbox">
                          <input type="checkbox" id="pinnedAll" class="pinned header fa fa-square-o fa-lg" />
                        </th>
                      </xsl:if>
                      <xsl:if test="sqroot/body/bodyContent/browse/header/column[@mandatory=1]">
                        <xsl:apply-templates select="sqroot/body/bodyContent/browse/header/column[@mandatory=1]" />
                      </xsl:if>
                      <xsl:if test="sqroot/body/bodyContent/browse/header/column[@mandatory=0]">
                        <th class="text-left">SUMMARY</th>                  
                      </xsl:if>                  
                      <xsl:if test="sqroot/body/bodyContent/browse/info/isDelegated = 1">
                        <th>&#160;</th>
                      </xsl:if>
                      <xsl:if test="sqroot/header/info/code/settingMode='T'">
                        <th>&#160;</th>                      
                      </xsl:if>
                      <xsl:if test="sqroot/body/bodyContent/browse/info/isDelegator = 0">
                        <th id="actionHeader" class="text-right">
                          <span>ACTION</span>
                          <div style="display:none;">
                            <xsl:if test="$allowOnOff = 1 and $allowDelete = 1 and $state &lt; 500">
                              <a href="#" onclick="btn_function('{sqroot/body/bodyContent/browse/info/code}', null, 'inactivate', {sqroot/body/bodyContent/browse/info/pageNo}, 10)">
                                <ix class="fa fa-toggle-on fa-lg" data-toggle="tooltip" title="Inactivated All" data-placement="left"/>
                              </a>
                            </xsl:if>
                            <xsl:if test="$state = 999">
                              <a href="#" onclick="btn_function('{sqroot/body/bodyContent/browse/info/code}', null, 'restore', {sqroot/body/bodyContent/browse/info/pageNo}, 10)">
                                <ix class="fa fa-toggle-off fa-lg" data-toggle="tooltip" title="Re-Activated All" data-placement="left"/>
                              </a>
                              <xsl:if test="$allowWipe = 1">
                                <a href="#" onclick="btn_function('{sqroot/body/bodyContent/browse/info/code}', null, 'wipe', {sqroot/body/bodyContent/browse/info/pageNo}, 10)">
                                  <ix class="fa fa-tras fa-lg" data-toggle="tooltip" title="Wiped All" data-placement="left"/>
                                </a>
                              </xsl:if>
                            </xsl:if>
                          </div>
                        </th>
                      </xsl:if>
                    </tr>              
                  </thead>
                  <tbody id="browseContent">                                    
                    <xsl:choose>
                      <xsl:when test="sqroot/body/bodyContent/browse/content/row">
                        <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row" />                      
                      </xsl:when>
                      <xsl:otherwise>
                        <tr>
                          <td align="center" colspan="{$tcolspan}">
                            <div id="noData" class="alert alert-warning">
                              There is no data available. 
                              <xsl:if test="$state=0">
                                <a href="#" onclick="window.location='?code={sqroot/header/info/code/id}&amp;guid=00000000-0000-0000-0000-000000000000'">Create a new one?</a>
                              </xsl:if>
                            </div>
                          </td>
                        </tr>
                      </xsl:otherwise>
                    </xsl:choose>
                  </tbody>
                </table>
                <xsl:if test="sqroot/body/bodyContent/browse/info/nbPages > 1">
                  <div class="box-footer clearfix">
                    <ul class="pagination pagination-sm no-margin pull-right" id="pagenumbers"></ul>
                  </div>
                </xsl:if>
              </div>
            </div>
          </div>
          <!-- browse for pc/laptop -->


        </xsl:when>
        <xsl:otherwise>
          <div class="callout callout-danger">
            <h4>Unauthority Access!</h4>
            <p>You don't have the right access. Please ask the administrator if you feel that you already have the right access into this module.</p>
          </div>
        </xsl:otherwise>    
      </xsl:choose>
      </div>
    </section>
  
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

  <xsl:template match="sqroot/body/bodyContent/browse/info/filters">
    <div class="row">
      <xsl:apply-templates select="comboFilter"/>
    </div>
    <div class="row">
      <div class="col-md-12">
        <button type="button" id="btnFilter" class="btn btn-success btn-flat" data-loading-text="Applying Filter..." onclick="applySQLFilter(this)">
          Apply Filters
        </button>
        <button type="button" id="btnResetFilter" class="btn btn-warning btn-flat" data-loading-text="Reseting Filter..." onclick="resetSQLFilter(this)" >
          <xsl:if test="not(comboFilter/value)">
            <xsl:attribute name="disabled">disabled</xsl:attribute>
          </xsl:if>
          Reset Filters
        </button>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="comboFilter">
    <div class="col-md-6">
      <div class="form-group">
        <label for="{@id}">
          <xsl:value-of select="@caption"/>
        </label>
        <select class="form-control select2" style="width: 100%;" name="{@id}" id="{@id}" tabindex="-1" aria-hidden="true"
           data-type="selectBox" data-old="{value}" data-oldText="{value}" data-value="{value}" >
          <option value="NULL">-- Select All --</option>
        </select>
      </div>
    </div>
    <script>
      $("#<xsl:value-of select="@id"/>").select2({
      ajax: {
      url:"OPHCORE/api/msg_autosuggest.aspx",
      data: function (params) {
      var query = {
      code:"<xsl:value-of select="/sqroot/body/bodyContent/browse/info/code/."/>",
      colkey:"<xsl:value-of select="@id"/>",
      search: params.term, page: params.page
      }
      return query;
      },
      dataType: 'json',
      }
      });
      <xsl:if test="value!=''">
        autosuggestSetValue('<xsl:value-of select="@id"/>','<xsl:value-of select="/sqroot/body/bodyContent/browse/info/code/."/>','<xsl:value-of select="@id"/>', '<xsl:value-of select="value"/>', '', '')
      </xsl:if>
    </script>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/info/states/state/substate">
    <xsl:variable name="titleState">
      <xsl:choose>
        <xsl:when test="@tRecord &gt; 0">
          <xsl:value-of select="@tRecord"/> records in total
        </xsl:when>
        <xsl:when test="@tRecord = 0">
          No record yet
        </xsl:when>
      </xsl:choose>    
    </xsl:variable>
      
    <!--<li data-toggle="tooltip" data-placement="right" title="{$titleState}">
      <a href="javascript:changestateid({@code})">
        <xsl:value-of select="translate(., $smallcase, $uppercase)"/>
        <xsl:if test="@tRecord">
          &#160;
          <span class="label label-default">
            <xsl:value-of select="@tRecord"/>
          </span>
        </xsl:if>
      </a>
    </li>-->

    <li>
      <a href="javascript:changestateid({@code})" title="">
        <xsl:value-of select="translate(., $smallcase, $uppercase)"/>
      </a>
    </li>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/header/column[@mandatory=1]">
    <xsl:variable name="title">
      <xsl:choose>
        <xsl:when test=".!=''">
          <xsl:value-of select="translate(., $smallcase, $uppercase)" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="translate(@fieldName, $smallcase, $uppercase)" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="tvalue">
      <xsl:choose>
        <xsl:when test="@order='asc' or @order='ASC'">
          <xsl:value-of select="$title"/> &amp;nbsp; &lt;ix class="fa fa-sort-alpha-asc" /&gt;
        </xsl:when>
        <xsl:when test="@order='desc' or @order='DESC'">
          <xsl:value-of select="$title"/> &amp;nbsp; &lt;ix class="fa fa-sort-alpha-desc" /&gt;
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="$title"/></xsl:otherwise>
      </xsl:choose>    
    </xsl:variable>
    
    <th title="{$title}" data-order="{@order}">
      <a href="#" onclick="sortBrowse(this, 'header', '{../../info/code}', '{@fieldName}')" data-toggle="tooltip" title="Click to Sort" style="color:black;">
        <xsl:value-of select="$tvalue"/>
      </a>      
    </th>    
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/header/column[@docStatus=1]">
    STATUS
    <xsl:value-of select="translate(titleCaption/., $smallcase, $uppercase)" />
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
    <tr class="odd-tr">
      <xsl:if test="/sqroot/body/bodyContent/browse/info/isDelegator = 0">
        <td><input type="checkbox" data-guid="{@GUID}" class="pinned fa fa-square-o" /></td>
      </xsl:if>
      <input id="mandatory{@GUID}" type="hidden" value="" />
      <xsl:apply-templates select="fields/field[@mandatory=1]" />
      <script>
        //put before mandatory section
        fillMobileItem('<xsl:value-of select="@code"/>', '<xsl:value-of select="@GUID" />', '<xsl:value-of select="$state" />', '<xsl:value-of select="@edit" />', '<xsl:value-of select="@delete" />', '<xsl:value-of select="@wipe" />', '<xsl:value-of select="@force" />', '<xsl:value-of select="/sqroot/body/bodyContent/browse/info/isDelegator"/>');
      </script>
           
      <xsl:if test="count(fields/field[@mandatory=0])>0">
        <td class="expand-td" data-toggle="collapse" data-target="#brodeta-{@GUID}" data-parent="#brodeta-{@GUID}" style="cursor:pointer">
            <table class="fixed-table">
              <tr>
                <td id="summary{@GUID}" name="summary">
                  <xsl:apply-templates select="fields/field[@mandatory=0]" />&#160;
                </td>
              </tr>
            </table>
        </td>
      </xsl:if>

      <xsl:if test="docDelegate">
        <td class="expand-td" style="text-align:center" data-toggle="collapse" data-target="#{@GUID}" data-parent="#{@GUID}">
          <a href="#" data-toggle="tooltip" title="{docDelegate/.}">
            <span class="label label-{docDelegate/@labelColor}">
              <xsl:value-of select="docDelegate/@title" />
            </span>
          </a>
        </td>
      </xsl:if>

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
      
      <xsl:if test="/sqroot/body/bodyContent/browse/info/isDelegator = 0">
        <td class="browse-action-button text-right" style="white-space: nowrap;">
          
          <!--approval icons-->
          <xsl:if test="/sqroot/header/info/code/settingMode='T'">
            <xsl:choose>
              <xsl:when test="$state &lt; 400">
                <a href="javascript:btn_function('{@code}', '{@GUID}', 'execute', '{$pageNo}', 10)">
                  <ix class="fa fa-check" title="Approve"></ix>
                </a>
              </xsl:when>
              <xsl:when test="$allowForce = 1 and $state &lt; 500">
                <a href="javascript:btn_function('{@code}', '{@GUID}', 'force', '{$pageNo}', 10)">
                  <ix class="fa fa-archive" title="Close"></ix>
                </a>
              </xsl:when>
              <xsl:when test="$allowForce = 1 and $state = 500">
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
                <ix class="fa fa-toggle-on" title="Inactive"></ix>
              </a>
            </xsl:when>
            <xsl:when test="$allowOnOff = 0 and $allowDelete = 1 and $state &lt; 500">
              <a href="javascript:btn_function('{@code}', '{@GUID}', 'delete', '{$pageNo}', 10)">
                <ix class="fa fa-trash" title="Delete"></ix>
              </a>
            </xsl:when>
            <xsl:when test="$state = 999">
              <a href="javascript:btn_function('{@code}', '{@GUID}', 'restore', '{$pageNo}', 10)">
                <ix class="fa fa-toggle-off" title="Reactivate"></ix>
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
                <ix class="fa fa-toggle-on" title="Inactive" style="color:LightGray"></ix>
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
      </xsl:if>

    </tr>
    
    <xsl:choose>
      <xsl:when test="/sqroot/body/bodyContent/browse/info/browseMode=2">
        <script>
          $('#brodeta-<xsl:value-of select="@GUID" />').on('shown.bs.collapse', function() {
          //alert('shown');
          }).on('show.bs.collapse', function() {
          //alert('collapse');
          });
        </script>
        <tr class="tr-detail">
          <td colspan="{$tcolspan}" style="padding:0;">
            <div class="browse-data accordian-body collapse" id="brodeta-{@GUID}" style="cursor:default;">
              <div class="row">
                <div class="col-md-12 full-width-a">
                  loading child...
                </div>
              </div>
            </div>
          </td>
        </tr>
      </xsl:when>
      <xsl:otherwise>
        <tr class="tr-detail">
          <td colspan="{$tcolspan}" style="padding:0;">
            <div class="browse-data accordian-body collapse" id="brodeta-{@GUID}" style="cursor:default;">
              <div class="row">
                <div class="col-md-12 full-width-a">

                  <!--Summary-->
                  <xsl:if test="fields/field[@mandatory=0]">
                    <div class="box box-primary box-solid" style="max-width:600px;float:left;margin: 10px 10px 10px 10px;">
                      <div class="box-header with-border">
                        <h6 class="box-title" style="border-bottom:2px dotted #DDDDDD; padding-bottom:5px; margin-bottom:5px;">Content of Summary</h6>
                        <div class="box-tools pull-right">
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
                  <xsl:if test="talks/talk">
                    <xsl:variable name="talkDisplay">
                      <xsl:if test="not(talks/talk)">
                        collapsed-box
                      </xsl:if>
                    </xsl:variable>
                    <div class="box box-danger box-solid direct-chat direct-chat-danger {$talkDisplay}" style="max-width:300px;float:left;margin: 10px 10px 10px 10px;">
                      <div class="box-header with-border">
                        <h3 class="box-title">Document Talk</h3>
                        <div class="box-tools pull-right">
                          <button class="btn btn-box-tool" data-widget="collapse">
                            <ix class="fa fa-plus"></ix>
                          </button>
                        </div>
                      </div>
                      <div class="box-body">
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
                  </xsl:if>
                
                </div>
              </div>
            </div>
          </td>
        </tr>

      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="fields/field[@mandatory=1]">
    <script>
      var m=$('#mandatory<xsl:value-of select="../../@GUID"/>').val();
      if (m!='' &#38;&#38; "<xsl:value-of select="." />" != '') m+='/';
      m+="<xsl:value-of select="." />";
      $('#mandatory<xsl:value-of select="../../@GUID"/>').val(m);
    </script>
    <td id="mandatory{../../@GUID}" class="expand-td" data-toggle="collapse" data-target="#{../@GUID}" data-parent="#{../@GUID}" data-field="{@caption}">
      <xsl:value-of select="." />
    </td>
  </xsl:template>

  <xsl:template match="fields/field[@mandatory='0']">
    <xsl:variable name="tbContent">
      <xsl:choose>
        <xsl:when test="@digit = 0 and .!=''">
          <xsl:value-of select="format-number(., '###,###,###,##0', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 1 and .!=''">
          <xsl:value-of select="format-number(., '###,###,###,##0.0', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 2 and .!=''">
          <xsl:value-of select="format-number(., '###,###,###,##0.00', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 3 and .!=''">
          <xsl:value-of select="format-number(., '###,###,###,##0.000', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 4 and .!=''">
          <xsl:value-of select="format-number(., '###,###,###,##0.0000', 'dot-dec')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test=". != ''">
      <span style="font-weight:bold;">
        <xsl:value-of select="@title" />
      </span>
      &#160;:&#160;
      <span data-field="{@caption}">
      <xsl:choose>
        <xsl:when test="@editor='anchor'">
          <a href="{$tbContent}">
            <xsl:value-of select="$tbContent" />
          </a>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$tbContent" />
          &#160;·&#160;
        </xsl:otherwise>
      </xsl:choose>
      </span>
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
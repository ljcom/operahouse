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
    <script>
      loadScript('OPHContent/cdn/select2/select2.full.min.js');
      loadScript('OPHContent/cdn/editablegrid-master/editablegrid.js');
      loadScript('OPHContent/cdn/editablegrid-master/editablegrid_renderers.js');
      loadScript('OPHContent/cdn/editablegrid-master/editablegrid_editors.js');
      loadScript('OPHContent/cdn/editablegrid-master/editablegrid_validators.js');
      loadScript('OPHContent/cdn/editablegrid-master/editablegrid_utils.js');
      loadScript('OPHContent/cdn/editablegrid-master/editablegrid_charts.js');

      var metadata = [];
      metadata.push({ name: "name", label: "NAME", datatype: "string", editable: true});
      metadata.push({ name: "firstname", label:"FIRSTNAME", datatype: "string", editable: true});
      metadata.push({ name: "age", label: "AGE", datatype: "integer", editable: true});
      metadata.push({ name: "height", label: "HEIGHT", datatype: "double(m,2)", editable: true});
      metadata.push({ name: "country", label: "COUNTRY", datatype: "string", editable: true});
      metadata.push({ name: "email", label: "EMAIL", datatype: "email", editable: true});
      metadata.push({ name: "freelance", label: "FREELANCE", datatype: "boolean", editable: true});
      metadata.push({ name: "lastvisit", label: "LAST VISIT", datatype: "date", editable: true});

      // a small example of how you can manipulate the object in javascript
      metadata[4].values = {};
      metadata[4].values["Europe"] = {"be":"Belgium","fr":"France","uk":"Great-Britain","nl":"Nederland"};
      metadata[4].values["America"] = {"br":"Brazil","ca":"Canada","us":"USA"};
      metadata[4].values["Africa"] = {"ng":"Nigeria","za":"South-Africa","zw":"Zimbabwe"};

      var data = [];
      data.push({id: 1, values: {"country":"uk","age":33,"name":"Duke","firstname":"Patience","height":1.842,"email":"patience.duke@gmail.com","lastvisit":"11\/12\/2002"}});
      data.push({id: 2, values: ["Rogers","Denise",59,1.627,"us","rogers.d@gmail.com","","07\/05\/2003"]});
      data.push({id: 3, values: {"name":"Dujardin","firstname":"Antoine","age":21,"height":1.73,"country":"fr","email":"felix.compton@yahoo.fr","freelance":true,"lastvisit":"21\/02\/1999"}});
      data.push({id: 4, values: {"name":"Conway","firstname":"Coby","age":47,"height":1.96,"country":"za","email":"coby@conwayinc.com","freelance":true,"lastvisit":"01\/12\/2007"}});
      data.push({id: 5, values: {"name":"Shannon","firstname":"Rana","age":24,"height":1.56,"country":"nl","email":"ranna.shannon@hotmail.com","freelance":false,"lastvisit":"07\/10\/2009"}});
      data.push({id: 6, values: {"name":"Benton","firstname":"Jasmine","age":61,"height":1.71,"country":"ca","email":"jasmine.benton@yahoo.com","freelance":false,"lastvisit":"13\/01\/2009"}});
      data.push({id: 7, values: {"name":"Belletoise","firstname":"André","age":31,"height":1.84,"country":"be","email":"belletoise@kiloutou.be","freelance":true,"lastvisit":""}});
      data.push({id: 8, values: {"name":"Santa-Maria","firstname":"Martin","age":37,"height":1.80,"country":"br","email":"martin.sm@gmail.com","freelance":false,"lastvisit":"12\/06\/1995"}});
      data.push({id: 9, values: {"name":"Dieumerci","firstname":"Amédé","age":37,"height":1.81,"country":"ng","email":"dieumerci@gmail.com","freelance":true,"lastvisit":"05\/07\/2009"}});
      data.push({id: 10,values: {"name":"Morin","firstname":"Wanthus","age":46,"height":1.77,"country":"zw","email":"morin.x@yahoo.jsdata.com","freelance":false,"lastvisit":"04\/03\/2004"}});

      editableGrid = new EditableGrid("DemoGridJsData");
      editableGrid.load({"metadata": metadata, "data": data});
      editableGrid.renderGrid("tablecontent", "testgrid");
    </script>
    <style>
      body { font-family:'lucida grande', tahoma, verdana, arial, sans-serif; font-size:11px; }
      h1 { font-size: 15px; }
      a { color: #548dc4; text-decoration: none; }
      a:hover { text-decoration: underline; }
      table.testgrid { border-collapse: collapse; border: 1px solid #CCB; width: 800px; }
      table.testgrid td, table.testgrid th { padding: 5px; border: 1px solid #E0E0E0; }
      table.testgrid th { background: #E5E5E5; text-align: left; }
      input.invalid { background: red; color: #FDFDFD; }
    </style>
    <xsl:if test="/sqroot/header/info/isBrowsable = 0">
      <script>
        document.getElementById("contentWrapper").innerHTML = '<p style="padding:20px 0 0 20px; font-weight:bold;">Sorry, You Do Not Have Authority for This Module.</p><hr />';
      </script>
    </xsl:if>

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
    <section class="content-header">
      <h1>
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
            <button type="button" style="margin-top:10px;" class="btn btn-orange-a" id="newdoc" onclick="window.location='?code={sqroot/header/info/code/id}&amp;guid=00000000-0000-0000-0000-000000000000'">
              NEW <span class="visible-phone">DOCUMENT</span>
            </button>
          </div>
          <script>
            var allowAdd='<xsl:value-of select="sqroot/body/bodyContent/browse/info/permission/allowAdd/." />';
            if (allowAdd!='1') $('#newdoc').prop('disabled', true);
          </script>
        </div>
      </div>

      <!-- header -->

      <!--Browse Filters-->
      <xsl:if test="sqroot/body/bodyContent/browse/info/filters">
        <div class="col-md-12 full-width-a" style="margin:0px;">
          <div id="bfBox" class="box box-default collapsed-box">
            <div class="box-header with-border">
              <button type="button" class="btn btn-box-tool" data-widget="collapse">
                <ix class="fa fa-plus" aria-hidden="true">&#160; Advanced Filters</ix>
              </button>
            </div>
            <div class="box-body">
              <form id="formFilter">
                <xsl:apply-templates select="sqroot/body/bodyContent/browse/info/filters" />
              </form>
            </div>
          </div>
          <script>
            $(document).ready(function () {
            if (getFilter() != "") {
            $("#bfBox").removeClass().addClass("box box-default");
            $("#bfBox ix").removeClass().addClass("fa fa-minus").text(" Advanced Filter (ACTIVE)");
            }
            });
          </script>
        </div>
      </xsl:if>

      <div class="col-md-12 full-width-a" id="tablecontent"></div>
      
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
                  <xsl:if test="/sqroot/body/bodyContent/browse/info/isDelegated = 1">
                    <th width="10">
                      &#160;
                    </th>
                  </xsl:if>
                  <xsl:if test="/sqroot/header/info/code/settingMode='T'">
                    <th width="10">
                      &#160;
                    </th>
                  </xsl:if>
                  <xsl:if test="/sqroot/body/bodyContent/browse/info/isDelegator = 0">
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
                  </xsl:if>
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

  <xsl:template match="sqroot/body/bodyContent/browse/info/filters">
    <div class="row">
      <xsl:apply-templates select="comboFilter"/>
    </div>
    <div class="row">
      <div class="col-md-12">
        <button id="btnFilter" type="button" class="btn btn-success btn-flat" data-loading-text="Applying Filter..." onclick="applySQLFilter(this)" >
          Apply Filters
        </button>
        <button id="btnResetFilter" type="button" class="btn btn-warning btn-flat" data-loading-text="Reseting Filter..." onclick="resetSQLFilter(this)" >
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
      
    <li data-toggle="tooltip" data-placement="right" title="{$titleState}">
      <a href="javascript:changestateid({@code})">
        <xsl:value-of select="translate(., $smallcase, $uppercase)"/>
        <xsl:if test="@tRecord">
          &#160;
          <span class="label label-default">
            <xsl:value-of select="@tRecord"/>
          </span>
        </xsl:if>
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
    <th width="10" title="{$title}">
      <table class="fixed-table">
        <tr>
          <td>
            <xsl:value-of select="$title"/>
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
      <script>
        //put before mandatory section
        fillMobileItem('<xsl:value-of select="@code"/>', '<xsl:value-of select="@GUID" />', '<xsl:value-of select="$state" />', '<xsl:value-of select="@edit" />', '<xsl:value-of select="@delete" />', '<xsl:value-of select="@wipe" />', '<xsl:value-of select="@force" />');
      </script>

      <td class="expand-td" data-toggle="collapse" data-target="#brodeta-{@GUID}" data-parent="#brodeta-{@GUID}">
        <xsl:if test="not(docDelegate)">
          <xsl:attribute name="colspan">2</xsl:attribute>
        </xsl:if>
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
        <td class="browse-action-button" style="white-space: nowrap;">
          <!--approval icons-->
          <xsl:if test="substring(/sqroot/header/info/code/id, 1, 1) = 'T'">
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
          <td colspan="7" style="padding:0;">
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
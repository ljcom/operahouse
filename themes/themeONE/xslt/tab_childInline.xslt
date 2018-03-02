<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>

  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>
  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
  <xsl:variable name="lowerCode">
    <xsl:value-of select="translate(/sqroot/body/bodyContent/browse/info/code, $uppercase, $smallcase)"/>
  </xsl:variable>
  <xsl:variable name="nbCol">
    <xsl:value-of select="count(/sqroot/body/bodyContent/browse/header/column)" />
  </xsl:variable>

  <xsl:template match="/">
    <script>
      var code='<xsl:value-of select="/sqroot/body/bodyContent/browse/info/code"/>';
      cell_init(code);

      var columns_<xsl:value-of select="/sqroot/body/bodyContent/browse/info/code"/>='';
      
    </script>
    <xsl:apply-templates select="sqroot/body/bodyContent/browse/children" />
    
    <div class="row">
      <div class="col-md-12">
        <div class="box-header with-border" style="background:white" data-toggle="collapse" data-target="#content_{/sqroot/body/bodyContent/browse/info/code}">
          <h3 class="dashboard-title">
            <xsl:value-of select="sqroot/body/bodyContent/browse/info/description"/>
          </h3>
        </div>
        <div>
          <input style="width:200px; position:absolute; right:25px; top:5px; padding-right:25px" type="text" id="searchBox_{sqroot/body/bodyContent/browse/info/code}" name="searchBox_{sqroot/body/bodyContent/browse/info/code}"
            class="form-control" placeholder="Enter search key..." value="{sqroot/body/bodyContent/browse/info/search}"
              onkeypress="searchTextChild(event, this.value, '{sqroot/body/bodyContent/browse/info/code}');" />
          <button id="clear{sqroot/body/bodyContent/browse/info/code}" type="button" class="btn btn-flat" style="position:absolute; right:25px; top:5px; background:none; border:none; display:none" >
            <span aria-hidden="true">&#215;</span>
          </button>
          <script>
            $('#clear<xsl:value-of select="sqroot/body/bodyContent/browse/info/code"/>').click(function(event) {
            searchTextChild(event, '', '<xsl:value-of select="sqroot/body/bodyContent/browse/info/code"/>', true);
            });

            $(document).ready(function() {
            if ($('#searchBox_<xsl:value-of select="sqroot/body/bodyContent/browse/info/code"/>').val() != '') {
            $('#clear<xsl:value-of select="sqroot/body/bodyContent/browse/info/code"/>').show();
            }
            });
          </script>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div style="border:0px none white;box-shadow:none;" id="content_{/sqroot/body/bodyContent/browse/info/code}" class="box collapse in">
              <div style="border:0px none white;box-shadow:none;overflow:auto" >
                <table class="table table-condensed strip-table-browse cell-table" style="border-collapse:collapse">
                  <thead>
                    <tr style="background:#3C8DBC; color:white">
                      <xsl:if test="count(/sqroot/body/bodyContent/browse/children/child)>0">
                        <th style="width:28px;"></th>
                      </xsl:if>
                      <th style="width:28px;" class="cell-recordSelectors"></th>
                      <xsl:apply-templates select="sqroot/body/bodyContent/browse/header"/>
                    </tr>
                  </thead>
                  <tbody id="{$lowerCode}">

                    <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row"/>
                  </tbody>
                </table>
              </div>
              <!-- /.box-body -->
              <div class="box-footer clearfix">
                <xsl:if test="(/sqroot/body/bodyContent/browse/info/permission/allowAdd/.)='1' and (/sqroot/body/bodyContent/browse/info/curState/@substateCode &lt; 500 or /sqroot/header/info/code/settingMode/. != 'T')">
                  <button class="btn btn-orange-a" style="margin-right:5px;"
                          onclick="cell_add('{$lowerCode}', columns_{/sqroot/body/bodyContent/browse/info/code}, {count(/sqroot/body/bodyContent/browse/children)}, this);">ADD</button>
                </xsl:if>
                <button id="child_button_save" class="btn btn-orange-a" style="display:none; margin-right:5px" onclick="cell_save();">SAVE</button>
                <button id="child_button_cancel" class="btn btn-gray-a" style="display:none; margin-right:5px" onclick="cell_cancelSave()">CANCEL</button>

                <xsl:if test="(/sqroot/body/bodyContent/browse/info/permission/allowDelete/.)='1' and (/sqroot/body/bodyContent/browse/info/curState/@substateCode &lt; 500 or /sqroot/header/info/code/settingMode/. != 'T')">
                  <button class="btn btn-gray-a" style="margin-right:5px;" onclick="cell_delete('{$lowerCode}', this)">DELETE</button>
                </xsl:if>
                <xsl:if test="(/sqroot/body/bodyContent/browse/info/permission/allowAdd/.)=1 and (/sqroot/body/bodyContent/browse/info/permission/allowExport/.)=1" >
                  <button class="btn btn-gray-a" style="margin-right:5px;"
                          onclick="downloadChild('{/sqroot/body/bodyContent/browse/info/code}', '')">DOWNLOAD</button>
                  <button class="btn btn-gray-a" style="margin-right:5px;" onclick="javascript:$('#import_hidden').click();">UPLOAD...</button>

                  <!--<button type="button" class="buttonCream" id="download" name="download" onclick="javascript:PrintDirect('{/sqroot/body/bodyContent/browse/info/code}', '', 3, '', '', '');">DOWNLOAD</button>
                  <button type="button" class="buttonCream" id="upload" name="upload" onclick="javascript:showSubBrowseView('{/sqroot/body/bodyContent/browse/info/code}','',1,'');">UPLOAD</button>-->
                  <input id ="import_hidden" name="import_hidden" type="file" style="visibility: hidden; width: 0; height: 0;" multiple="" />
                </xsl:if>
                <xsl:if test="/sqroot/body/bodyContent/browse/info/nbPages > 1">
                  <ul class="pagination pagination-sm no-margin pull-right" id="childPageNo"></ul>
                  <script>
                    var code='<xsl:value-of select ="/sqroot/body/bodyContent/browse/info/code"/>';
                    var pageNo = '<xsl:value-of select ="/sqroot/body/bodyContent/browse/info/pageNo"/>';
                    var nbPages = '<xsl:value-of select ="/sqroot/body/bodyContent/browse/info/nbPages"/>';
                    childPageNo('childPageNo', code, pageNo, nbPages);
                  </script>
                </xsl:if>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/children">
    <xsl:apply-templates select="child" />
  </xsl:template>

  <xsl:template match="child">
    <xsl:if test="info/permission/allowBrowse='1'">
      <script>
        function loadChild_<xsl:value-of select ="$lowerCode"/>(GUID) {
        var code='<xsl:value-of select ="code/."/>';
        var pcode='<xsl:value-of select ="$lowerCode"/>';
        var parentKey='<xsl:value-of select ="parentkey/."/>';
        var browsemode='<xsl:value-of select ="browseMode/."/>';
        loadChild(code, parentKey, GUID, null, browsemode, pcode);
        }
      </script>
    </xsl:if>

  </xsl:template>
  <xsl:template match="sqroot/body/bodyContent/browse/header">
    <xsl:apply-templates select="column"/>
  </xsl:template>

  <xsl:template match="column">
    <th>
      <xsl:value-of select="."/>
      <script>
        columns_<xsl:value-of select="/sqroot/body/bodyContent/browse/info/code"/>+='<xsl:value-of select="@editor"/>:<xsl:value-of select="@fieldName"/>, ';
      </script>
    </th>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/content/row">

    <tr id="tr1_{@code}{@GUID}" data-parent="#{/sqroot/body/bodyContent/browse/info/code}" data-target="#{@code}{@GUID}"
        data-code="{@code}" data-guid="{@GUID}"
        onmouseover="this.bgColor='lavender';this.style.cursor='pointer';" onmouseout="this.bgColor='white'">

      <xsl:if test="count(/sqroot/body/bodyContent/browse/children/child)>0">
        <td class="cell-parentSelector"></td>

      </xsl:if>

      <td class="cell-recordSelector"></td>
      <xsl:apply-templates select="fields/field"/>
    </tr>
    <tr id="tr2_{@code}{@GUID}" style="display:none">
      <!--<xsl:variable name="parentGUID">
        <xsl:value-of select ="@GUID"/>
      </xsl:variable>
      <xsl:variable name="parentCode">
        <xsl:value-of select ="@code"/>
      </xsl:variable>-->
      <td colspan="100">
        <!--
        <xsl:for-each select="/sqroot/body/bodyContent/browse/children/child" >
          <div>
            <xsl:if test="info/permission/allowBrowse='1'">
              <input type="hidden" id="PKID" value="child{code/.}"/>
              <input type="hidden" id="filter{code/.}" value="{parentkey/.}='{$parentGUID}'"/>
              <input type="hidden" id="parent{code/.}" value="{parentkey/.}"/>
              <input type="hidden" id="PKName" value="{parentkey/.}"/>
              <div class="box box-solid box-default" style="box-shadow:0px;border:none" id="child{code/.}{$parentGUID}">
                &#160;
              </div>
            </xsl:if>
          </div>
        </xsl:for-each>
        -->
      </td>
    </tr>

  </xsl:template>

  <xsl:template match="fields/field">
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
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="@editor">
        <td class="cell cell-editor-{@editor}" data-id="{@id}" data-field="{@caption}"
          onblur="cell_preview('{@preview}', '{/sqroot/body/bodyContent/browse/info/code/.}', '{../../@GUID}','form{/sqroot/body/bodyContent/browse/info/code/.}', this);">
          <xsl:value-of select="$tbContent"/>
        </td>
      </xsl:when>
      <xsl:otherwise>
        <td class="cell">
          <xsl:value-of select="$tbContent"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

</xsl:stylesheet>

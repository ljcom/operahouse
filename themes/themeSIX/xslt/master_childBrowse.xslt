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

  <xsl:template match="/">
    <script>
      var code='<xsl:value-of select="$lowerCode"/>';
      cell_init(code);
      upload_init(code, function(data) {
      var err=''; s=0;
      $(data).find("sqroot").find("message").each(function (i) {
      var item=$(data).find("sqroot").find("message").eq(i);
      if ($(item).text()!='') err += $(item).text()+' ';
      })

      $(data).find("sqroot").find("guid").each(function (i) {
      var sn=$(data).find("sqroot").find("guid").eq(i);
      if (sn!='') s++;
      })
      var msg='Upload Status: Success: '+s+(err==''?'':' Error: '+err);
      showMessage(msg);
      //setTimeout(function() {location.reload()}, 5000);

      var code='<xsl:value-of select="/sqroot/body/bodyContent/browse/info/code"/>';
      loadChild(code);

      });

      $(document).ready(function(){
        if($('th[data-order="DESC"]').length == 1) $('th[data-order="DESC"]').append(' &lt;ix class="fa fa-sort-alpha-desc" /&gt;');
        else if($('th[data-order="ASC"]').length == 1) $('th[data-order="ASC"]').append(' &lt;ix class="fa fa-sort-alpha-asc" /&gt;');
      });


    </script>
    <div class="row">
      <div class="col-md-12">
        <div class="box-header with-border" style="background:white">
          <h5 class="dashboard-title" style="text-align:center; margin-bottom:20px;">
            <xsl:value-of select="sqroot/body/bodyContent/browse/info/description"/>
          </h5>
          <div style=" margin-bottom:20px;">
            <input style="width:200px; border-radius:2px;" type="text" id="searchBox_{$lowerCode}" name="searchBox_{$lowerCode}"
            class="" placeholder="Enter search key..." value="{sqroot/body/bodyContent/browse/info/search}"
              onkeypress="searchTextChild(event, this.value, '{$lowerCode}');" />
          </div>
          
        </div>
        <div>
          
          <button id="clear{$lowerCode}" type="button" class="btn btn-flat" style="position:absolute; right:25px; top:5px; background:none; border:none; display:none" >
            <span aria-hidden="true">&#215;</span>
          </button>
          <script>
            $('#clear<xsl:value-of select="$lowerCode"/>').click(function(event) {
            searchTextChild(event, '', '<xsl:value-of select="$lowerCode"/>', true);
            });

            $(document).ready(function() {
            if ($('#searchBox_<xsl:value-of select="$lowerCode"/>').val() != '') {
            $('#clear<xsl:value-of select="$lowerCode"/>').show();
            }
            });
          </script>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div style="border:0px none white;box-shadow:none;" id="content_{$lowerCode}" class="box collapse in">
              <div style="border:0px none white;box-shadow:none;">
                <table class="table table-condensed strip-table-browse" style="border-collapse:collapse;">
                  <thead>
                    <tr style="border-top: 5px #DDDDDD solid; color:#6D6D77; font-weight:bold">
                      <th class="cell-recordSelectors" style="width:28px;">&#xA0;</th>
                      <xsl:apply-templates select="sqroot/body/bodyContent/browse/header"/>
                    </tr>
                  </thead>
                  <tbody id="{$lowerCode}">
                    <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row"/>
                    <tr>
                      <td colspan="20" style="padding:0;">
                        <div class="browse-data accordian-body collapse"
                             id="{$lowerCode}00000000-0000-0000-0000-000000000000" aria-expanded="false">
                          Please Wait...
                        </div>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <!-- /.box-body -->
              <div class="box-footer clearfix">
                <xsl:if test="(/sqroot/body/bodyContent/browse/info/permission/allowAdd/.)='1' and (/sqroot/body/bodyContent/browse/info/curState/@substateCode &lt; 500)">
                  <button  class="flat-button-form border-radius-2" data-toggle="collapse"
                          data-target="#{$lowerCode}00000000-0000-0000-0000-000000000000"
                          onclick="showChildForm('{$lowerCode}','00000000-0000-0000-0000-000000000000')">ADD</button>&#160;
                </xsl:if>
                <xsl:if test="(/sqroot/body/bodyContent/browse/info/permission/allowDelete/.)='1' and (/sqroot/body/bodyContent/browse/info/curState/@substateCode &lt; 500)">
                  <button class="flat-button-form flat-btn-grey " onclick="cell_delete('{$lowerCode}', this)">DELETE</button>&#160;
                </xsl:if>
                <xsl:if test="(/sqroot/body/bodyContent/browse/info/permission/allowAdd/.)=1 and (/sqroot/body/bodyContent/browse/info/permission/allowExport/.)=1" >
                  <button class="btn btn-gray-a flat-button-form"
                          onclick="downloadChild('{$lowerCode}', '')">DOWNLOAD</button>&#160;
                  <button class="btn btn-gray-a flat-button-form" onclick="javascript:$('#import_hidden').click();">UPLOAD...</button>&#160;

                  <!--<button type="button" class="buttonCream" id="download" name="download" onclick="javascript:PrintDirect('{$lowerCode}', '', 3, '', '', '');">DOWNLOAD</button>
                  <button type="button" class="buttonCream" id="upload" name="upload" onclick="javascript:showSubBrowseView('{$lowerCode}','',1,'');">UPLOAD</button>-->
                  <input id ="import_hidden" name="import_hidden" type="file" data-code="{$lowerCode}" style="visibility: hidden; width: 0; height: 0;" multiple="" />
                </xsl:if>
                <xsl:if test="/sqroot/body/bodyContent/browse/info/nbPages > 1">
                  <ul class="pagination pagination-sm no-margin pull-right" id="childPageNo"></ul>
                  <script>
                    var code='<xsl:value-of select ="$lowerCode"/>';
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

  <xsl:template match="sqroot/body/bodyContent/browse/header">
    <xsl:apply-templates select="column"/>
  </xsl:template>

  <xsl:template match="column">
    <th style="cursor:pointer;" onclick="sortBrowse(this, 'child', '{../../info/code}', '{@fieldName}')" data-order="{@order}">
      <xsl:value-of select="."/>
    </th>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/content/row">

    <tr id="tr1_{$lowerCode}{@GUID}" data-parent="#{$lowerCode}" data-target="#{$lowerCode}{@GUID}" data-code="{$lowerCode}" data-guid="{@GUID}"
        class="accordion-toggle cell"
        onmouseover="this.bgColor='lavender';this.style.cursor='pointer';" onmouseout="this.bgColor='white'" style="background:#F9F9F9;">
      <td class="cell-recordSelector"></td>
      <xsl:apply-templates select="fields/field"/>
    </tr>
    <tr id="tr2_{$lowerCode}{@GUID}">

      <td colspan="7" style="padding:0;">
        <div class="browse-data accordian-body collapse" id="{$lowerCode}{@GUID}" aria-expanded="false" style="margin:20px 0;">
          Please Wait...
        </div>
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
    <td onclick="showChildForm('{$lowerCode}','{../../@GUID}', '{$lowerCode}')" >
      <xsl:value-of select="$tbContent"/>&#160;
    </td>

  </xsl:template>

</xsl:stylesheet>

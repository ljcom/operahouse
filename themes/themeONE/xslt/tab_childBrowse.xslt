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

      $(function() {

      // We can attach the `fileselect` event to all file inputs on the page
      $(document).on('change', ':file', function() {
      var input = $(this),
      numFiles = input.get(0).files ? input.get(0).files.length : 1,
      label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
      input.trigger('fileselect', [numFiles, label]);

      var file = this.files[0];
      if (file.size > 1024000) {
      alert('max upload size is 1M')
      }
      //submit ajax
      else {var file = $(this)[0].files[0];
      var upload = new Upload(file);

      var url='OPHCore/api/default.aspx?mode=upload&#38;code=<xsl:value-of select="/sqroot/body/bodyContent/browse/info/code"/>&#38;GUID='+getGUID();

      upload.doUpload(url,
      function(data) {
      //success
      var x = $(data).find("sqroot").children().each(function () {
      var msg = $(this).text();
      showMessage('Upload Success');

      })
      location.reload();



      },
      function(error) {
      //error
      showMessage(error);
      });
      }
      });

      // We can watch for our custom `fileselect` event like this
      $(document).ready( function() {
      $(':file').on('fileselect', function(event, numFiles, label) {

      var input = $(this).parents('.input-group').find(':text'),
      //log = numFiles > 1 ? numFiles + ' files selected' : label;
      log = label;
      if( input.length ) {
      input.val(log);
      } else {
      //if( log ) alert(log);
      }

      });
      });

      });
      
      //spreadsheet functions
      /*
      $(.cell).onclick = function (this) {
        alert(this.html());
      };
      */
    </script>
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
              <table class="table table-condensed strip-table-browse" style="border-collapse:collapse;">
                <thead>
                  <tr style="background:#3C8DBC; color:white">
                    <xsl:apply-templates select="sqroot/body/bodyContent/browse/header"/>
                  </tr>
                </thead>
                <tbody id="{/sqroot/body/bodyContent/browse/info/code}">
                  <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row"/>
                  <tr>
                    <td colspan="7" style="padding:0;">
                      <div class="browse-data accordian-body collapse"
                           id="{$lowerCode}00000000-0000-0000-0000-000000000000" aria-expanded="false">
                        Please Wait...
                      </div>
                    </td>
                  </tr>
                </tbody>
              </table>

              <!-- /.box-body -->
              <div class="box-footer clearfix">
                <xsl:if test="(/sqroot/body/bodyContent/browse/info/permission/allowAdd/.)='1' and (/sqroot/body/bodyContent/browse/info/curState/@substateCode &lt; 500 or /sqroot/header/info/code/settingMode/. != 'T')">
                  <button class="btn btn-orange-a accordion-toggle" data-toggle="collapse"
                          data-target="#{$lowerCode}00000000-0000-0000-0000-000000000000"
                          onclick="showChildForm('{$lowerCode}','00000000-0000-0000-0000-000000000000')">ADD</button>&#160;
                </xsl:if>
                <xsl:if test="(/sqroot/body/bodyContent/browse/info/permission/allowAdd/.)=1 and (/sqroot/body/bodyContent/browse/info/permission/allowExport/.)=1" >
                  <button class="btn btn-gray-a"
                          onclick="downloadChild('{/sqroot/body/bodyContent/browse/info/code}', '')">DOWNLOAD</button>&#160;
                  <button class="btn btn-gray-a" onclick="javascript:$('#import_hidden').click();">UPLOAD...</button>&#160;

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

  <xsl:template match="sqroot/body/bodyContent/browse/header">
    <xsl:apply-templates select="column"/>
  </xsl:template>

  <xsl:template match="column">
    <th>
      <xsl:value-of select="."/>
    </th>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
    
    <tr id="tr1_{@code}{@GUID}" data-parent="#{/sqroot/body/bodyContent/browse/info/code}" data-target="#{@code}{@GUID}"
        class="accordion-toggle cell"
        onclick="showChildForm('{@code}','{@GUID}', '{/sqroot/body/bodyContent/browse/info/code}')" onmouseover="this.bgColor='lavender';this.style.cursor='pointer';" onmouseout="this.bgColor='white'">
      <xsl:apply-templates select="fields/field"/>
    </tr>
    <tr id="tr2_{@code}{@GUID}">
      <td colspan="7" style="padding:0;">
        <div class="browse-data accordian-body collapse" id="{@code}{@GUID}" aria-expanded="false">
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
    <td>
      <xsl:value-of select="$tbContent"/>&#160;
    </td>

  </xsl:template>

</xsl:stylesheet>

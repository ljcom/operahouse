<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
  
  <xsl:variable name="code" select="/sqroot/body/bodyContent/info/code" />
  <xsl:variable name="desc" select="/sqroot/body/bodyContent/info/description" />
  <xsl:variable name="exportMode">
    <xsl:choose>
      <xsl:when test="/sqroot/body/bodyContent/info/exportMode=0 or /sqroot/body/bodyContent/info/exportMode='0'">
        0
      </xsl:when>
      <xsl:otherwise>1</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="allowExport" select="/sqroot/body/bodyContent/info/permission/allowExport" />
  <xsl:variable name="parameter" select="/sqroot/body/bodyContent/parameters/parameter" />
  <xsl:variable name="xmlParameter" select="/sqroot/body/bodyContent/parameters/xmlParameter" />

  <xsl:template match="/">
    <script>
      loadScript('OPHContent/themes/<xsl:value-of select="sqroot/header/info/themeFolder"/>/scripts/daterangepicker/daterangepicker.js');
      loadScript('OPHContent/themes/<xsl:value-of select="sqroot/header/info/themeFolder"/>/scripts/select2/select2.full.min.js');

      var deferreds = [];

      //UPLOAD FUNCTIONS
      $(function() {      
        $(document).on('change', ':file', function() {
          $('#btn_exp').button('loading');
          $('#btn_imp').attr('disabled', 'disabled');
          $("body").css("cursor", "progress");
          
          var input = $(this),
          numFiles = input.get(0).files ? input.get(0).files.length : 1,
          label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
          input.trigger('fileselect', [numFiles, label]);

          var file = this.files[0];
          if (file.size > 1024000) {
            alert('max upload size is 1M')
          }          
          else {
            var file = $(this)[0].files[0];
            var upload = new Upload(file);
            var url='OPHCore/api/default.aspx?mode=upload&#38;code=<xsl:value-of select="$code"/>&#38;header=true';

            upload.doUpload(url, function(data) {
              location.reload();
              //loadReport('<xsl:value-of select="$code"/>', tcode);
            },
            function(error) {
              //error
            showMessage(error);
            });
          }
        });
      });

    </script>
    
    <section class="content-header visible-phone">
      <h1>
        Export Data "<xsl:value-of select="$desc"/>"
      </h1>
      <ol class="breadcrumb">
        <li>
          <a href="javascript:goHome()">
            <span>
              <ix class="fa fa-home"></ix>
            </span>&#160;HOME
          </a>
        </li>
          <li>
            <a href="?code={$code}">
              <xsl:value-of select="$desc"/>
            </a>
          </li>
        <li>
          <u>
            Export Data "<xsl:value-of select="$desc"/>"
          </u>
        </li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">      
      <div class="row">
        <div class="col-md-12" style="margin-bottom:30px;margin-top:30px">
          <div style="text-align:left">
            <button id="btn_imp" class="btn btn-orange-a" onclick="downloadModule('{$code}', {$exportMode});">Download Template</button>&#160;
            <button id="btn_exp" class="btn btn-orange-a" onclick="javascript:$('#import_hidden').click();" data-loading-text="Exporting File...(Please wait)" autocomplete="off">
              Export Template Data
            </button>&#160;
            <input id ="import_hidden" name="import_hidden" type="file" style="visibility: hidden; width: 0; height: 0;" multiple="" />
          </div>
        </div>
      </div>
      <!--table upload status-->
      <xsl:apply-templates select="sqroot/body/bodyContent/tables/table" />
    </section>
  </xsl:template>
  
  <xsl:template match='sqroot/body/bodyContent/tables/table'>
    <div class="row">
      <div class="col-md-12">
        <div class="box">
          <div class="box-header">
            <h3 class="box-title">Export Status</h3>
          </div>
          <div class="box-body">
            <table class="table table-bordered">
              <tbody>
                <tr>
                  <th style="width: 150px">Date</th>
                  <th>Comment</th>
                  <th style="width: 80px">Status</th>
                </tr>
                <xsl:apply-templates select="row" />
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="row">
    <tr>
      <td>
        <xsl:if test="dates">
          <xsl:value-of select="dates"/>
        </xsl:if>
      </td>
      <td>
        <xsl:if test="comment">
          <xsl:value-of select="comment"/>
        </xsl:if>
      </td>
      <td>
        <xsl:if test="status">
          <span>
            <xsl:choose>
              <xsl:when test="translate(status, $uppercase, $smallcase) = 'failure'">
                <xsl:attribute name="class">badge bg-red</xsl:attribute>
              </xsl:when>
              <xsl:when test="translate(status, $uppercase, $smallcase) = 'error'">
                <xsl:attribute name="class">badge bg-yellow</xsl:attribute>
              </xsl:when>
              <xsl:when test="translate(status, $uppercase, $smallcase) = 'warning'">
                <xsl:attribute name="class">badge bg-orange</xsl:attribute>
              </xsl:when>
              <xsl:when test="translate(status, $uppercase, $smallcase) = 'attention'">
                <xsl:attribute name="class">badge bg-light-blue</xsl:attribute>
              </xsl:when>
              <xsl:when test="translate(status, $uppercase, $smallcase) = 'success'">
                <xsl:attribute name="class">badge bg-green</xsl:attribute>
              </xsl:when>
            </xsl:choose>
            <xsl:value-of select="status"/>
          </span>
        </xsl:if>
      </td>
    </tr>
  </xsl:template>

</xsl:stylesheet>
<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>

  <xsl:template match="/">
    <!-- Content Header (Page header) -->
    <script>
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder"/>/scripts/daterangepicker/daterangepicker.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder"/>/scripts/select2/select2.full.min.js');

      var xmldoc = ""
      var xsldoc = "OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder"/>/xslt/" + getPage();
      <xsl:if test="sqroot/body/bodyContent/form/info/GUID!='00000000-0000-0000-0000-000000000000'">
        $('#button_save').hide();
        $('#button_cancel').hide();
        $('#button_save2').hide();
        $('#button_cancel2').hide();
      </xsl:if>

      var deferreds = [];

      $(function () {

      <!--//Date picker-->
      $('.datepicker').datepicker({
      autoclose: true
      });

      <!--//Date time picker-->
      $('.datetimepicker').datetimepicker({

      });

      $(".timepicker").timepicker({
      minuteStep: 15,
      template: 'modal',
      appendWidgetTo: 'body',
      showSeconds: false,
      showMeridian: false,
      defaultTime: false
      });

      <!--//iCheck for checkbox and radio inputs-->
      $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
      checkboxClass: 'icheckbox_minimal-blue',
      radioClass: 'iradio_minimal-blue'
      });
      <!--//Red color scheme for iCheck-->
      $('input[type="checkbox"].minimal-red, input[type="radio"].minimal-red').iCheck({
      checkboxClass: 'icheckbox_minimal-red',
      radioClass: 'iradio_minimal-red'
      });
      <!--//Flat red color scheme for iCheck-->
      $('input[type="checkbox"].flat-red, input[type="radio"].flat-red').iCheck({
      checkboxClass: 'icheckbox_flat-green',
      radioClass: 'iradio_flat-green'
      });

      <!--//Colorpicker--><!--
    $(".my-colorpicker1").colorpicker();
    --><!--//color picker with addon--><!--
    $(".my-colorpicker2").colorpicker();

    --><!--//Timepicker--><!--
    $(".timepicker").timepicker({
    showInputs: false
    });-->
      });

      $.when.apply($, deferreds).done(function() {
      preview('1', getCode(), '<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>','formheader', this);
      });

    </script>

    <xsl:variable name="settingmode">
      <xsl:value-of select="/sqroot/body/bodyContent/form/info/settingMode/."/>
    </xsl:variable>
    <xsl:variable name="documentstatus">
      <xsl:value-of select="/sqroot/body/bodyContent/form/info/state/status/."/>
    </xsl:variable>

    <section class="content-header visible-phone">
      <h1 data-toggle="collapse" data-target="#header" id="header_title">
        <xsl:choose>
          <xsl:when test="sqroot/body/bodyContent/form/info/GUID='00000000-0000-0000-0000-000000000000'">
            NEW&#160;<xsl:value-of select="translate(sqroot/body/bodyContent/form/info/Description/., $smallcase, $uppercase)"/>
          </xsl:when>
          <xsl:when test="(sqroot/body/bodyContent/form/info/GUID)!='00000000-0000-0000-0000-000000000000' and $settingmode='T'">
            EDIT&#160;<xsl:value-of select="sqroot/body/bodyContent/form/info/docNo/."/>
          </xsl:when>
          <xsl:otherwise>
            EDIT&#160;<xsl:value-of select="sqroot/body/bodyContent/form/info/id/."/>
          </xsl:otherwise>
        </xsl:choose>

      </h1>
      <ol class="breadcrumb">
        <li>
          <a href="javascript:goHome();">
            <span>
              <ix class="fa fa-home"></ix>
            </span>&#160;HOME
          </a>
        </li>
        <li>
          <a href="javascript: loadBrowse('{sqroot/body/bodyContent/form/info/code/.}');">
            <span>
              <ix class="fa fa-file-o"></ix>
            </span>&#160;<xsl:value-of select="sqroot/body/bodyContent/form/info/Description/."/>
          </a>
        </li>
        <li class="active">
          <xsl:choose>
            <xsl:when test="sqroot/body/bodyContent/form/info/GUID='00000000-0000-0000-0000-000000000000'">
              NEW&#160;<xsl:value-of select="sqroot/body/bodyContent/form/info/Description/."/>
            </xsl:when>
            <xsl:when test="(sqroot/body/bodyContent/form/info/GUID)!='00000000-0000-0000-0000-000000000000' and $settingmode='T'">
              EDIT&#160;<xsl:value-of select="sqroot/body/bodyContent/form/info/docNo/."/>
            </xsl:when>
            <xsl:otherwise>
              EDIT&#160;<xsl:value-of select="sqroot/body/bodyContent/form/info/id/."/>
            </xsl:otherwise>
          </xsl:choose>
        </li>
      </ol>
    </section>


    <!-- START CUSTOM TABS -->
    <!--<h2 class="page-header">CASH</h2>-->
    <section class="content">
      <div class="row">
        <div class="col-md-12">
          <!-- Custom Tabs -->
          <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
              <li class="active">
                <a href="#tab_1" data-toggle="tab">Header</a>
              </li>
              <xsl:for-each select="sqroot/body/bodyContent/form/children/child">
                <li>
                  <a href="#tab_{code}" data-toggle="tab">
                    <xsl:value-of select="childTitle"/>
                  </a>
                </li>
              </xsl:for-each>
            </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="tab_1">
                <!-- Main content -->
                <section class="content">
                  <!--<div class="row visible-phone">
        <div class="col-md-12">
          <div class="view-title">
            <h3>REQUEST FOR RECRUITMENT (HRRR)</h3>
          </div>
        </div>
      </div>-->
                  <!-- title -->
                  <xsl:apply-templates select="sqroot/body/bodyContent"/>
                  <!-- view header -->
                  <div class="row">
                    <div class="col-md-12 device-sm visible-sm device-md visible-md device-lg visible-lg" style="margin-bottom:50px;">
                      <div style="text-align:left">
                        <xsl:choose>
                          <xsl:when test="(/sqroot/body/bodyContent/form/info/GUID/.) = '00000000-0000-0000-0000-000000000000'">
                            <!--location: 0 header; 1 child; 2 browse
              location: browse:10, header form:20, browse anak:30, browse form:40-->

                            <button id="button_save" class="btn btn-orange-a" onclick="saveThemeONE('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}', 20);">SAVE</button>&#160;
                            <button id="button_cancel" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
                          </xsl:when>
                          <xsl:when test="($documentstatus) = 0 or ($documentstatus) = ''">
                            <button id="button_save" class="btn btn-orange-a" onclick="saveThemeONE('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}', 20);">SAVE</button>&#160;
                            <button id="button_cancel" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
                            <xsl:if test="(/sqroot/body/bodyContent/form/info/permission/allowDelete/.)=1">
                              <button id="button_save" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}', 'delete', 1, 20);">DELETE</button>&#160;
                              <!--location: 0 header; 1 child; 2 browse
              location: browse:10, header form:20, browse anak:30, browse form:40-->

                            </xsl:if>
                            <xsl:if test="($settingmode)='T' and ($documentstatus) &lt; 400 ">
                              <button id="button_submit" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}', 'execute', 1, 20)">SUBMIT</button>
                            </xsl:if>
                          </xsl:when>
                          <xsl:when test="($documentstatus) &gt; 99 and ($documentstatus) &lt; 199">
                            <button id="button_save" class="btn btn-orange-a" onclick="saveThemeONE('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}', 20);">SAVE</button>&#160;
                            <button id="button_cancel" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
                            <button id="button_approve" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}', 'execute', 1, 20)">APPROVE</button>
                          </xsl:when>
                          <xsl:when test="($documentstatus) = 300">
                            <button id="button_save" class="btn btn-orange-a" onclick="saveThemeONE('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}', 20);">SAVE</button>&#160;
                            <button id="button_cancel" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
                            <button id="button_reject" class="btn btn-orange-a">REJECT</button>&#160;
                          </xsl:when>
                          <xsl:when test="($documentstatus) &gt;= 400 and ($documentstatus) &lt;= 499">
                            <button id="button_save" class="btn btn-orange-a" onclick="saveThemeONE('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}', 20);">SAVE</button>&#160;
                            <button id="button_cancel" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
                            <button id="button_close" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}', 'force', 1, 20)">CLOSE</button>&#160;
                          </xsl:when>
                          <xsl:otherwise>
                            &#160;
                            <!--<div style="text-align:left">
                <button id="button_save" class="btn btn-orange-a" onclick="submitfunction('formheader','{sqroot/body/bodyContent/form/info/GUID/.}','{sqroot/body/bodyContent/form/info/code/.}');">SAVE</button>&#160;
                <button id="button_cancel" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
              </div>-->
                          </xsl:otherwise>
                        </xsl:choose>
                      </div>

                    </div>
                    <div class="col-md-12 displayblock-phone device-xs visible-xs" style="margin-bottom:20px;">
                      <div style="text-align:center">
                        <xsl:choose>
                          <xsl:when test="(/sqroot/body/bodyContent/form/info/GUID/.) = '00000000-0000-0000-0000-000000000000'">
                            <button id="button_save2" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}', 'save', 1, 20);">SAVE</button>&#160;
                            <button id="button_cancel2" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
                          </xsl:when>
                          <xsl:when test="($documentstatus) = 0 or ($documentstatus) = ''">
                            <button id="button_save2" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}', 'save', 1, 20);">SAVE</button>&#160;
                            <button id="button_cancel2" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
                            <xsl:if test="($settingmode)='T' and ($documentstatus) &lt; 400 ">
                              <button id="button_submit2" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}', 'execute', 1, 20)">SUBMIT</button>
                            </xsl:if>
                          </xsl:when>
                          <xsl:when test="($documentstatus) &gt; 99 and ($documentstatus) &lt; 199">
                            <button id="button_save2" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}', 'save', 1, 20);">SAVE</button>&#160;
                            <button id="button_cancel2" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
                            <button id="button_approve2" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}', 'execute', 1, 20)">APPROVE</button>
                          </xsl:when>
                          <xsl:when test="($documentstatus) = 300">
                            <button id="button_save2" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}', 'save', 1, 20);">SAVE</button>&#160;
                            <button id="button_cancel2" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
                            <button id="button_reject2" class="btn btn-orange-a">REJECT</button>&#160;
                          </xsl:when>
                          <xsl:when test="($documentstatus) &gt;= 400 and ($documentstatus) &lt;= 499">
                            <button id="button_save2" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}', 'save', 1, 20);">SAVE</button>&#160;
                            <button id="button_cancel2" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
                            <button id="button_close2" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}', 'force', 1, 20)">CLOSE</button>&#160;
                          </xsl:when>
                          <xsl:otherwise>
                            &#160;
                            <!--<div style="text-align:left">
                <button id="button_save" class="btn btn-orange-a" onclick="submitfunction('formheader','{sqroot/body/bodyContent/form/info/GUID/.}','{sqroot/body/bodyContent/form/info/code/.}');">SAVE</button>&#160;
                <button id="button_cancel" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
              </div>-->
                          </xsl:otherwise>
                        </xsl:choose>
                      </div>
                    </div>
                  </div>
                  <!-- button view header -->


                </section>
                <!-- /.content -->

              </div>
              <!-- /.tab-pane -->

              <xsl:for-each select="sqroot/body/bodyContent/form/children/child">
                <div class="tab-pane" id="tab_{code}">
                  <xsl:if test="/sqroot/body/bodyContent/form/info/GUID !='00000000-0000-0000-0000-000000000000'">
                    <xsl:apply-templates select="."/>

                  </xsl:if>
                  <!--<xsl:value-of select="code"/>-->
                </div>
              </xsl:for-each>

            </div>
            <!-- /.tab-content -->
          </div>
          <!-- nav-tabs-custom -->
        </div>
        <!-- /.col -->

      </div>
    </section>
    <!-- /.row -->
    <!-- END CUSTOM TABS -->
  </xsl:template>


  <xsl:template match="sqroot/body/bodyContent">
    <xsl:apply-templates select="form"/>
  </xsl:template>

  <xsl:template match="form">
    <script>
      var code = "<xsl:value-of select="info/code/."/>";
      var tblnm =code+"requiredname";
    </script>

    <form role="form" id="formheader" enctype="multipart/form-data">
      <input type="hidden" id="cid" name="cid" value="{/sqroot/body/bodyContent/form/info/GUID/.}" />
      <input type="hidden" name ="{info/code/.}requiredname"/>
      <input type="hidden" name ="{info/code/.}requiredtblvalue"/>

      <xsl:apply-templates select="formPages/formPage[@pageNo&lt;9]"/>
    </form>
  </xsl:template>

  <xsl:template match="formPages/formPage[@pageNo&lt;9]">
    <xsl:apply-templates select="formSections"/>
  </xsl:template>

  <xsl:template match="formSections">
    <xsl:apply-templates select="formSection"/>
  </xsl:template>

  <xsl:template match="formSection ">
    <xsl:if test="@rowTitle/.!=''">
      <div class="col-md-12" data-toggle="collapse" data-target="#section_{@sectionNo}">
        <h3>
          <xsl:value-of select="@rowTitle/."/>&#160;
        </h3>
      </div>
    </xsl:if>
    <xsl:if test="formCols/formCol/formRows">
      <div class="col-md-12 collapse in" id="section_{@sectionNo}">
        <xsl:apply-templates select="formCols"/>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="formCols">
    <xsl:apply-templates select="formCol"/>
  </xsl:template>

  <xsl:template match="formCol">
    <xsl:choose>
      <xsl:when test="@colNo='0'">
        <div class="col-md-12">
          <xsl:apply-templates select="formRows"/>
        </div>
      </xsl:when>
      <xsl:otherwise>
        <div class="col-md-6">
          <xsl:if test="@colNo='1'">
            <xsl:apply-templates select="formRows"/>
          </xsl:if>
          <xsl:if test="@colNo='2'">
            <xsl:apply-templates select="formRows"/>
          </xsl:if>
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="formRows">
    <div class="box box-solid box-default">
      <div class="box-body">
        <xsl:apply-templates select="formRow"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="formRow ">
    <xsl:apply-templates select="fields"/>

  </xsl:template>

  <xsl:template match="fields">
    <xsl:apply-templates select="field"/>
  </xsl:template>

  <xsl:template match="field">
    <xsl:if test="@isNullable=0">
      <script>
        document.getElementsByName(tblnm)[0].value = document.getElementsByName(tblnm)[0].value + ', <xsl:value-of select="@fieldName"/>'
      </script>
    </xsl:if>

    <xsl:variable name="fieldEnabled">
      <xsl:choose>
        <xsl:when test ="@isEditable=1 or (@isEditable=2 and (/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))">enabled</xsl:when>
        <xsl:otherwise>disabled</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test ="@isEditable=0 or (@isEditable=2 and (/sqroot/body/bodyContent/form/info/GUID/. != '00000000-0000-0000-0000-000000000000')) or (/sqroot/body/bodyContent/form/info/permission/allowEdit/.)!='1'">
        <script>
          $('#<xsl:value-of select="@fieldName"/>').attr('disabled', true);
        </script>
      </xsl:when>
    </xsl:choose>

    <div class="form-group {$fieldEnabled}-input">
      <xsl:apply-templates select="textBox"/>
      <xsl:apply-templates select="textEditor"/>
      <xsl:apply-templates select="dateBox"/>
      <xsl:apply-templates select="dateTimeBox"/>
      <xsl:apply-templates select="timeBox"/>
      <xsl:apply-templates select="passwordBox"/>
      <xsl:apply-templates select="checkBox"/>
      <xsl:apply-templates select="mediaBox"/>
      <xsl:apply-templates select="autoSuggestBox"/>
      <xsl:apply-templates select="tokenBox"/>
      <xsl:apply-templates select="radio"/>
    </div>
  </xsl:template>


  <xsl:template match="checkBox">
    <!--Supaya bisa di serialize-->
    <input type="hidden" name="{../@fieldName}" id="{../@fieldName}" value="{value}"/>
    <!--Supaya bisa di serialize-->

    <input type="checkbox" value="{value}" id ="cb{../@fieldName}"  name="cb{../@fieldName}" data-type="checkBox" data-old="{value}"
      onchange="checkCB('{../@fieldName}');preview('{preview/.}', getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','formheader', this);">
      <xsl:if test="value=1">
        <xsl:attribute name="checked">checked</xsl:attribute>
      </xsl:if>
      <xsl:if test="../@isEditable='0' or (../@isEditable='2' and (/sqroot/body/bodyContent/form/info/GUID/. != '00000000-0000-0000-0000-000000000000')) or (/sqroot/body/bodyContent/form/info/permission/allowEdit/.)!='1'">
        <xsl:attribute name="disabled">disabled</xsl:attribute>
      </xsl:if>
    </input>

    <label id="{../@fieldName}caption">
      <xsl:value-of select="titlecaption"/>
    </label>
    <xsl:if test="../@isNullable = 0">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>

    <label id="{../@fieldName}suffixCaption">
      <xsl:value-of select="suffixCaption"/>
    </label>

  </xsl:template>

  <xsl:template match="textEditor">
    <label id="{../@fieldName}caption" data-toggle="collapse" data-target="#section_{@sectionNo}">
      <xsl:value-of select="titlecaption"/>
    </label>
    <xsl:if test="../@isNullable = 0">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>

    <textarea id ="{../@fieldName}" name ="{../@fieldName}" class="form-control">
      <xsl:choose>
        <xsl:when test="value != ''">
          <xsl:value-of select="value"/>
        </xsl:when>
        <xsl:otherwise>&#160;</xsl:otherwise>
      </xsl:choose>
    </textarea>

    <script type="text/javascript">
      CKEDITOR.replace('<xsl:value-of select="../@fieldName"/>');
      CKEDITOR.instances['<xsl:value-of select="../@fieldName"/>'].on('blur', function() {
      var teOldData = $('#<xsl:value-of select="../@fieldName"/>').html();
      var teData = CKEDITOR.instances['<xsl:value-of select="../@fieldName"/>'].getData();
      teData = teData.trim();
      $('#<xsl:value-of select="../@fieldName"/>').html(teData);
      if (teOldData != teData) {
      $('#button_save').show();
      $('#button_cancel').show();
      $('#button_save2').show();
      $('#button_cancel2').show();
      }
      preview('{preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','formheader', this);
      });
    </script>
  </xsl:template>

  <xsl:template match="textBox">
    <label id="{../@fieldName}caption">
      <xsl:value-of select="titlecaption"/>
    </label>
    <xsl:if test="../@isNullable = 0">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>


    <!--digit-->
    <xsl:variable name="tbContent">
      <xsl:choose>
        <xsl:when test="digit = 0 and value!=''">
          <xsl:value-of select="format-number(value, '#,##0', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="digit  = 1 and value!=''">
          <xsl:value-of select="format-number(value, '#,##0.0', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="digit  = 2 and value!=''">
          <xsl:value-of select="format-number(value, '#,##0.00', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="digit  = 3 and value!=''">
          <xsl:value-of select="format-number(value, '#,##0.000', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="digit  = 4 and value!=''">
          <xsl:value-of select="format-number(value, '#,##0.0000', 'dot-dec')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="value"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!--default value-->
    <xsl:variable name="thisvalue">
      <xsl:choose>
        <xsl:when  test="/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000' and defaultvalue != ''">
          <xsl:value-of select="defaultvalue/." />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$tbContent" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>


    <input type="text" class="form-control" Value="{$thisvalue}" data-type="textBox" data-old="{$thisvalue}" name="{../@fieldName}"
           onblur="preview('{preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','formheader', this);" id ="{../@fieldName}"
           oninput="javascript:checkChanges(this)">
      <xsl:if test="../@isEditable=0 or (../@isEditable=2 and (/sqroot/body/bodyContent/form/info/GUID/. != '00000000-0000-0000-0000-000000000000')) or (/sqroot/body/bodyContent/form/info/permission/allowEdit/.)!='1'">
        <xsl:attribute name="disabled">disabled</xsl:attribute>
      </xsl:if>
    </input>
  </xsl:template>

  <xsl:template match="dateBox">
    <label id="{../@fieldName}caption">
      <xsl:value-of select="titlecaption"/>
    </label>
    <xsl:if test="../@isNullable = 0">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>
    <div class="input-group date">
      <div class="input-group-addon">
        <ix class="fa fa-calendar"></ix>
      </div>
      

      
      <input type="text" class="form-control pull-right datepicker" id ="{../@fieldName}" name="{../@fieldName}" Value="{value}" data-type="dateBox" data-old="{value}"
        onblur="preview('{preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','formheader', this);" >
        <xsl:if test="../@isEditable=0">
          <xsl:attribute name="disabled">disabled</xsl:attribute>
        </xsl:if>
      </input>
    </div>
  </xsl:template>

  <xsl:template match="dateTimeBox">
    <label id="{../@fieldName}caption">
      <xsl:value-of select="titlecaption"/>
    </label>
    <div class="input-group date">
      <div class="input-group-addon">
        <ix class="fa fa-calendar"></ix>
      </div>
      <input type="text" class="form-control pull-right datetimepicker" id ="{../@fieldName}" name="{../@fieldName}" Value="{value}" data-type="dateTimeBox" data-old="{value}"
        onblur="preview('{preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','formheader', this);" >
        <xsl:if test="../@isEditable=0">
          <xsl:attribute name="disabled">disabled</xsl:attribute>
        </xsl:if>
      </input>
    </div>
  </xsl:template>

  <xsl:template match="passwordBox">
    <label id="{../@fieldName}caption">
      <xsl:value-of select="titlecaption"/>
    </label>
    <xsl:if test="../@isNullable = 0">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>

    <input type="text" class="form-control" Value="********" data-type="textBox" data-old="" name="{../@fieldName}"
      onblur="preview('{preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','formheader', this);" id ="{../@fieldName}">
      <xsl:if test="../@isEditable=0 or (../@isEditable=2 and (/sqroot/body/bodyContent/form/info/GUID/. != '00000000-0000-0000-0000-000000000000')) or (/sqroot/body/bodyContent/form/info/permission/allowEdit/.)!='1'">
        <xsl:attribute name="disabled">disabled</xsl:attribute>
      </xsl:if>
    </input>

  </xsl:template>

  <xsl:template match="timeBox">
    <script>//timebox</script>
    <label id="{../@fieldName}caption">
      <xsl:value-of select="titlecaption"/>
    </label>
    <xsl:if test="../@isNullable = 0">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>

    <div class="input-group date">
      <div class="input-group-addon">
        <ix class="fa fa-clock-o"></ix>
      </div>
      <input type="text" class="form-control pull-right timepicker" id ="{../@fieldName}" name="{../@fieldName}"
             data-type="timeBox" data-old="{value}" Value="{value}"
             onblur="preview('{preview/.}','{/sqroot/body/bodyContent/form/code/id}', '{/sqroot/body/bodyContent/form/info/GUID/.}','form{/sqroot/body/bodyContent/form/code/id}', this);" >
        <xsl:choose>
          <xsl:when test ="../@isEditable=1 or (../@isEditable=2 and (/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))"></xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="disabled">disabled</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      </input>
    </div>
  </xsl:template>

  <xsl:template match="autoSuggestBox">
    <label id="{../@fieldName}caption">
      <xsl:value-of select="titlecaption"/>
    </label>

    <xsl:if test="../@isNullable = 0">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>

    <select class="form-control select2" style="width: 100%;" name="{../@fieldName}" id="{../@fieldName}"
            data-type="selectBox" data-old="{value/.}" data-oldText="{value/.}" data-value="{value/.}"
      onchange="autosuggest_onchange(this, '{preview/.}', getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}', 'formheader');" >
      <xsl:if test="../@isEditable=0">
        <xsl:attribute name="disabled">disabled</xsl:attribute>
      </xsl:if>

      <option value="NULL">-----Select-----</option>
    </select>

    <script>

      <!--$("#<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/><xsl:value-of select="../@fieldName"/>").select2({-->
      $("#<xsl:value-of select="../@fieldName"/>").select2({
      ajax: {
      url:"OPHCORE/api/msg_autosuggest.aspx",
      data: function (params) {
      var query = {
      code:"<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>",
      colkey:"<xsl:value-of select="../@fieldName"/>",
      search: params.term,
      wf1value: ($("#<xsl:value-of select='whereFields/wf1'/>").val() === undefined ? "" : $("#<xsl:value-of select='whereFields/wf1'/>").val()),
      wf2value: ($("#<xsl:value-of select='whereFields/wf2'/>").val() === undefined ? "" : $("#<xsl:value-of select='whereFields/wf2'/>").val()),
      page: params.page
      }

      return query;
      },
      dataType: 'json',
      }
      });
      <xsl:if test="value!=''">
        deferreds.push(
        autosuggestSetValue('<xsl:value-of select="../@fieldName"/>','<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>','<xsl:value-of select='../@fieldName'/>', '<xsl:value-of select='value'/>', '<xsl:value-of select='whereFields/wf1'/>', '<xsl:value-of select='whereFields/wf2'/>')
        );
      </xsl:if>
    </script>
  </xsl:template>

  <xsl:template match="tokenBox">
    <script type="text/javascript">
      var sURL<xsl:value-of select="../@fieldName"/>='OPHCore/api/msg_autosuggest.aspx?mode=token&amp;code=<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>&amp;colkey=<xsl:value-of select="../@fieldName"/>'
      var noPrepopulate<xsl:value-of select="../@fieldName"/>=1;
      <xsl:if test="value">
        noPrepopulate<xsl:value-of select="../@fieldName"/>=0;
      </xsl:if>
      var cURL<xsl:value-of select="../@fieldName"/>='OPHCore/api/msg_autosuggest.aspx?mode=token&amp;code=<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>&amp;colkey=<xsl:value-of select="../@fieldName"/>&amp;search=<xsl:value-of select="value"/>'

      $(document).ready(function(){
      $.ajax({
      url: cURL<xsl:value-of select="../@fieldName"/>,
      dataType: 'json',
      success: function(data){
      if (noPrepopulate<xsl:value-of select="../@fieldName"/>==1) data='';
      $("#<xsl:value-of select="../@fieldName"/>").tokenInput(
      sURL<xsl:value-of select="../@fieldName"/>,
      {
      hintText: "please type...",
      searchingText: "Searching...",
      preventDuplicates: true,
      allowCustomEntry: true,
      highlightDuplicates: false,
      tokenDelimiter: "*",
      theme:"facebook",
      prePopulate: data,
      onReady: function(x) {
      },
      onAdd: function(x) {
      preview('<xsl:value-of select="preview/."/>', getCode(), '<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>','formheader', this);
      },
      onDelete: function(x) {
      preview('<xsl:value-of select="preview/."/>', getCode(), '<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>','formheader', this);
      }
      }
      );
      }
      });
      });
    </script>

    <label id="{../@fieldName}caption">
      <xsl:value-of select="titlecaption"/>
    </label>

    <xsl:if test="../@isNullable = 0">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>

    <!--digit-->
    <xsl:variable name="tbContent">
      <xsl:value-of select="value"/>
    </xsl:variable>

    <!--default value-->
    <xsl:variable name="thisvalue">
      <xsl:choose>
        <xsl:when  test="/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000' and defaultvalue != ''">
          <xsl:value-of select="defaultvalue/." />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$tbContent" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <input type="text" class="form-control" Value="{$thisvalue}" data-type="tokenBox" data-old="{$thisvalue}" data-newJSON="" data-code="{code/.}"
      data-key="{key}" data-id="{id}" data-name="{name}"
      name="{../@fieldName}" id ="{../@fieldName}">

      <xsl:if test="../@isEditable=0">
        <xsl:attribute name="disabled">disabled</xsl:attribute>
      </xsl:if>
    </input>
  </xsl:template>

  <xsl:template match="mediaBox">
    <label id="{../@fieldName}caption">
      <xsl:value-of select="titlecaption"/>
    </label>
    <xsl:if test="../@isNullable = 0">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>

    <!--default value-->
    <xsl:variable name="thisvalue">
      <xsl:choose>
        <xsl:when  test="/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000' and defaultvalue != ''">
          <xsl:value-of select="defaultvalue/." />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="value"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <div class="input-group">
      <label class="input-group-btn">
        <span class="btn btn-primary">
          Browse <input id ="{../@fieldName}_hidden" name="{../@fieldName}_hidden" type="file" style="display: none;" multiple="" />
        </span>
      </label>
      <input id ="{../@fieldName}" name="{../@fieldName}" Value="{value}" type="text" class="form-control" readonly="" />
      <span class="input-group-btn">
        <button class="btn btn-secondary" type="button" onclick="javascript:popTo('OPHcore/api/msg_download.aspx?fieldAttachment={../@fieldName}&#38;code={/sqroot/body/bodyContent/form/info/code/.}&#38;GUID={/sqroot/body/bodyContent/form/info/GUID/.}');">
          <xsl:if test="/sqroot/body/bodyContent/form/info/GUID='00000000-0000-0000-0000-000000000000'">
            <xsl:attribute name="disabled">disabled</xsl:attribute>
          </xsl:if>
          <ix class="fa fa-paperclip"></ix>&#160;
        </button>
      </span>
    </div>
  </xsl:template>

  <xsl:template match="radio">
    <script>
      function <xsl:value-of select="../@fieldName" />_hide(shownId) {
      $('#accordion_<xsl:value-of select="../@fieldName" />').children().each(function(){
      if ($(this).hasClass('in') &#38;&#38; this.id!=shownId) {
      $(this).collapse('toggle');
      }
      });
      }
    </script>
    <input type="hidden" id="{../@fieldName}" value="{value/.}" />
    <div>
      <label id="{../@fieldName}caption">
        <xsl:value-of select="titlecaption"/>
      </label>
      <xsl:if test="../@isNullable = 0">
        <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
      </xsl:if>
    </div>
    <div class = "btn-group" data-toggle = "radios">
      <xsl:apply-templates select="radioSections/radioSection"/>
    </div>
    <xsl:if test="radioSections/radioSection/radioRows">
      <div class="panel-body" id="accordion_{../@fieldName}" style="box-shadow:none;border:none;display:none;">
        <xsl:for-each select="radioSections/radioSection">
          <!--<xsl:if test="radioSections/radioSection/radioRows/radioRow">-->
          <div id="panel_{../../../@fieldName}_{@radioNo}" class="box collapse" style="box-shadow:none;border:none;">
            <xsl:apply-templates select="radioRows/radioRow/fields" />&#160;
          </div>
          <!--</xsl:if>-->
        </xsl:for-each>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="radioSections/radioSection">

    <xsl:variable name="pandis" select="count(radioRows)"/>

    <xsl:choose>
      <xsl:when test="@fieldName=../../value/.">
        <xsl:choose>
          <xsl:when test="radioRows">
            <label class="radio-inline" for="{../../../@fieldName}_radio_{@radioNo}" onclick="panel_display('accordion_{../../../@fieldName}', 1)" >
              <input type="radio" name="{../../../@fieldName}_radio" id="{../../../@fieldName}_radio_{@radioNo}" value="{@fieldName}" checked="checked" />
              <xsl:value-of select="@radioRowTitle"/>
            </label>
          </xsl:when>
          <xsl:otherwise>
            <label class="radio-inline" for="{../../../@fieldName}_radio_{@radioNo}" onclick="panel_display('accordion_{../../../@fieldName}', 0)" >
              <input type="radio" name="{../../../@fieldName}_radio" id="{../../../@fieldName}_radio_{@radioNo}" value="{@fieldName}" checked="checked" />
              <xsl:value-of select="@radioRowTitle"/>
            </label>
          </xsl:otherwise>
        </xsl:choose>
        <script>
          $('#panel_<xsl:value-of select="../../../@fieldName" />_<xsl:value-of select="@radioNo" />').collapse('show');
        </script>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="radioRows">
            <label class="radio-inline" for="{../../../@fieldName}_radio_{@radioNo}" onclick="panel_display('accordion_{../../../@fieldName}', 1)" >
              <input type="radio" name="{../../../@fieldName}_radio" id="{../../../@fieldName}_radio_{@radioNo}" value="{@fieldName}" />
              <xsl:value-of select="@radioRowTitle"/>
            </label>
          </xsl:when>
          <xsl:otherwise>
            <label class="radio-inline" for="{../../../@fieldName}_radio_{@radioNo}" onclick="panel_display('accordion_{../../../@fieldName}', 0)" >
              <input type="radio" name="{../../../@fieldName}_radio" id="{../../../@fieldName}_radio_{@radioNo}" value="{@fieldName}" />
              <xsl:value-of select="@radioRowTitle"/>
            </label>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>

    <script>
      $('#<xsl:value-of select="../../../@fieldName" />_radio_<xsl:value-of select="@radioNo" />').click(function(){
      <xsl:value-of select="../../../@fieldName" />_hide('panel_<xsl:value-of select="../../../@fieldName" />_<xsl:value-of select="@radioNo" />');
      $('#panel_<xsl:value-of select="../../../@fieldName" />_<xsl:value-of select="@radioNo" />').collapse('show');
      var x=$('input[name=<xsl:value-of select="../../../@fieldName" />_radio]:checked').val();
      $('#<xsl:value-of select="../../../@fieldName" />').val(x);
      });
    </script>
  </xsl:template>

  <xsl:template match="radioRow/fields">
    <xsl:apply-templates select="field" />
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/form/children">

    <xsl:apply-templates select="child"/>

  </xsl:template>


  <xsl:template match="child">
    <xsl:if test="info/permission/allowBrowse='1'">
      <input type="hidden" id="PKID" value="child{code/.}"/>
      <input type="hidden" id="filter{code/.}" value="{parentkey/.}='{/sqroot/body/bodyContent/form/info/GUID/.}'"/>
      <input type="hidden" id="parent{code/.}" value="{parentkey/.}"/>
      <input type="hidden" id="PKName" value="{parentkey/.}"/>

      <script>

        //xmldoc = "OPHCORE/api/default.aspx?code=<xsl:value-of select ="code/."/>&amp;mode=browse&amp;sqlFilter=<xsl:value-of select ="parentkey/."/>='<xsl:value-of select ="/sqroot/body/bodyContent/form/info/GUID/."/>'"
        //showXML('child<xsl:value-of select ="code/."/>', xmldoc, xsldoc + "_childBrowse.xslt", true, true, function () {});

        var code='<xsl:value-of select ="code/."/>';
        var parentKey='<xsl:value-of select ="parentkey/."/>';
        var GUID='<xsl:value-of select ="/sqroot/body/bodyContent/form/info/GUID/."/>';

        loadChild(code, parentKey, GUID);
      </script>


      <div class="box box-solid box-default" style="box-shadow:0px;border:none" id="child{code/.}{/sqroot/body/bodyContent/form/info/GUID/.}">
        &#160;
      </div>

    </xsl:if>
  </xsl:template>

</xsl:stylesheet>

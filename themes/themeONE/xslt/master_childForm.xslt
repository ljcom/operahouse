﻿<?xml version="1.0" encoding="utf-8"?>
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
      loadScript('OPHContent/themes/<xsl:value-of select="sqroot/header/info/themeFolder"/>/scripts/daterangepicker/daterangepicker.js');
      loadScript('OPHContent/themes/<xsl:value-of select="sqroot/header/info/themeFolder"/>/scripts/select2/select2.full.min.js');
      var xmldoc = ""
      var xsldoc = "OPHContent/themes/<xsl:value-of select="sqroot/header/info/themeFolder"/>/xslt/" + getPage();


      $(function() {

      // We can attach the `fileselect` event to all file inputs on the page
      $(document).on('change', ':file', function() {
      var input = $(this),
      numFiles = input.get(0).files ? input.get(0).files.length : 1,
      label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
      input.trigger('fileselect', [numFiles, label]);

      //var file = this.files[0];
      //if (file.size > 1024 {
      //alert('max upload size is 1k')
      //}
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

      $('#child_button_save').hide();
      $('#child_button_cancel').hide();

    </script>


    <!-- Main content -->
    <section class="content">

      <!-- title -->

      <xsl:apply-templates select="sqroot/body/bodyContent"/>

      <!-- view header -->
      <div class="box" style="box-shadow:0px;border:none;">
        <div class="col-md-12" style="margin-bottom:50px;">
          <div style="text-align:left">
            <button id="child_button_save" class="btn btn-orange-a" onclick="saveThemeONE('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}',1);">SAVE</button>&#160;
            <button id="child_button_cancel" class="btn btn-gray-a" onclick="closeChildForm()">CANCEL</button>&#160;
            <xsl:if test="/sqroot/body/bodyContent/form/info/GUID/. != '00000000-0000-0000-0000-000000000000'">
              <button id="child_button_delete"  class="btn btn-gray-a"
                      onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}', 'delete', 1)">DELETE</button>
            </xsl:if>
          </div>
        </div>

        <div class="col-md-12 displayblock-phone" style="margin-bottom:20px;">
          <div style="text-align:center">
            <button id="child_button_save" class="btn btn-orange-a" onclick="saveThemeONE('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}',1);">SAVE</button>&#160;
            <button id="child_button_cancel" class="btn btn-gray-a" onclick="closeChildForm()">CANCEL</button>
          </div>
        </div>
      </div>
      <!-- button view header -->
        <xsl:apply-templates select="sqroot/body/bodyContent/form/children/child"/>
        <!-- /.col -->

      <!-- browse for phone/tablet max width 768 -->
    </section>
    <!-- /.content -->


    <script>
      $(function () {

      <!--//Datemask dd/mm/yyyy-->
      $("#datemask").inputmask("dd/mm/yyyy", {"placeholder": "dd/mm/yyyy"});
      <!--//Datemask2 mm/dd/yyyy-->
      $("#datemask2").inputmask("mm/dd/yyyy", {"placeholder": "mm/dd/yyyy"});
      <!--//Money Euro-->
      $("[data-mask]").inputmask();

      <!--//Date range picker-->
      $('#reservation').daterangepicker();
      <!--//Date range picker with time picker-->
      $('#reservationtime').daterangepicker({timePicker: true, timePickerIncrement: 30, format: 'MM/DD/YYYY h:mm A'});
      <!--//Date range as a button-->
      $('#daterange-btn').daterangepicker(
      {
      ranges: {
      'Today': [moment(), moment()],
      'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
      'Last 7 Days': [moment().subtract(6, 'days'), moment()],
      'Last 30 Days': [moment().subtract(29, 'days'), moment()],
      'This Month': [moment().startOf('month'), moment().endOf('month')],
      'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
      },
      startDate: moment().subtract(29, 'days'),
      endDate: moment()
      },
      function (start, end) {
      $('#daterange-btn span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
      }
      );

      <!--//Date picker-->
      $('#datepicker').datepicker({
      autoclose: true
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

      <!--//Colorpicker-->
      $(".my-colorpicker1").colorpicker();
      <!--//color picker with addon-->
      $(".my-colorpicker2").colorpicker();

      <!--//Timepicker-->
      $(".timepicker").timepicker({
      showInputs: false
      });
      });

      preview(1, '<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>', '<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>','form<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>', this);

    </script>


  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent">

    <xsl:apply-templates select="form"/>

  </xsl:template>

  <xsl:template match="form">

    <script>
      var code = "<xsl:value-of select="info/code/."/>";
      var tblnm =code+"requiredname";


    </script>
    <input type="hidden" name ="{info/code/.}requiredname"/>
    <input type="hidden" name ="{info/code/.}requiredtblvalue"/>
    <input type="hidden" id="PKSAVE{info/code/.}" value="{info/parentKey/.}"/>
    <div class="col-md-12" id="child">
      <form role="form" id="form{info/code/.}">
        <!--<input type="hidden" name="mode" value="save"/>
      <input type="hidden" name="code" value="{info/code/.}"/>-->
        <input type="hidden" name="{info/parentKey/.}" id="PK{info/code/.}" value=""/>
        <script>
          $('#PK'+code).val(getGUID());
        </script>
        <xsl:apply-templates select="formPages/formPage[@pageNo&lt;9]"/>
      </form>
    </div>
  </xsl:template>

  <xsl:template match="formPages/formPage[@pageNo&lt;9]">
    <xsl:apply-templates select="formSections"/>
  </xsl:template>

  <xsl:template match="formSections">

    <xsl:apply-templates select="formSection"/>

  </xsl:template>

  <xsl:template match="formSection ">
    <div class="box" style="box-shadow:0px;border:none;">
      <div class="col-md-12">
        <xsl:apply-templates select="formCols"/>
      </div>
    </div>

  </xsl:template>

  <xsl:template match="formCols">
    <xsl:apply-templates select="formCol"/>
  </xsl:template>

  <xsl:template match="formCol">

    <xsl:if test="@colNo='1'">

      <div class="col-md-6">
        <xsl:apply-templates select="formRows"/>
      </div>
    </xsl:if>
    <xsl:if test="@colNo='2'">
      <div class="col-md-6">
        <xsl:apply-templates select="formRows"/>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="formRows">

    <xsl:apply-templates select="formRow"/>

  </xsl:template>

  <xsl:template match="formRow ">
    <xsl:apply-templates select="fields"/>

  </xsl:template>

  <xsl:template match="fields">

    <xsl:apply-templates select="field"/>

  </xsl:template>

  <xsl:template match="field">

    <xsl:apply-templates select="field[@isEditable>0]"/>
    <xsl:apply-templates select="field[@isEditable=0]"/>

  </xsl:template>

  <xsl:template match="field[@isEditable>0]">

    <xsl:if test="@isNullable=0">
      <script>
        document.getElementsByName(tblnm)[0].value = document.getElementsByName(tblnm)[0].value + ';<xsl:value-of select="@fieldName"/>'
      </script>
    </xsl:if>

    <div class="form-group enabled-input">
      <xsl:apply-templates select="textBox"/>
      <xsl:apply-templates select="dateBox"/>
      <xsl:apply-templates select="mediaBox"/>
      <xsl:apply-templates select="checkBox"/>
      <xsl:apply-templates select="autoSuggestBox"/>
      <xsl:apply-templates select="tokenBox"/>
    </div>
  </xsl:template>

  <xsl:template match="field[@isEditable=0]">

    <xsl:if test="@isNullable=0">
      <script>
        document.getElementsByName(tblnm)[0].value = document.getElementsByName(tblnm)[0].value + ', <xsl:value-of select="@fieldName"/>'
      </script>
    </xsl:if>
    <div class="form-group disabled-input">
      <xsl:apply-templates select="textBox"/>
      <xsl:apply-templates select="dateBox"/>
      <xsl:apply-templates select="mediaBox"/>
      <xsl:apply-templates select="checkBox"/>
      <xsl:apply-templates select="autoSuggestBox"/>
      <xsl:apply-templates select="tokenBox"/>
    </div>
  </xsl:template>

  <xsl:template match="checkBox">
    <!--Supaya bisa di serialize-->
    <input type="hidden" name="{../@fieldName}" value="0"/>
    <!--Supaya bisa di serialize-->


    <input type="checkbox"  value="{value}" id ="{../@fieldName}"  name="{../@fieldName}" onchange="checkCB('{../@fieldName}');preview('preview/.',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','form'+code, this);">
      <xsl:if test="value=1">
        <xsl:attribute name="checked">checked</xsl:attribute>
      </xsl:if>
      <xsl:if test="../@isEditable=0">
        <xsl:attribute name="disabled">disabled</xsl:attribute>
      </xsl:if>

    </input>

    <label id="{../@fieldName}caption">
      <xsl:value-of select="titlecaption"/>
    </label>

  </xsl:template>

  <xsl:template match="textBox">
    <label id="{../@fieldName}caption">
      <xsl:value-of select="titlecaption"/>

    </label>
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

    <input type="text" class="form-control" Value="{$thisvalue}" name="{../@fieldName}" data-old="{value/.}" data-child="Y" onblur="preview('{preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','form'+code, this);" id ="{../@fieldName}">
      <xsl:if test="../@isEditable=0">
        <xsl:attribute name="disabled">disabled</xsl:attribute>
      </xsl:if>
    </input>
  </xsl:template>

  <xsl:template match="dateBox">
    <label id="{../@fieldName}caption">
      <xsl:value-of select="titlecaption"/>
    </label>
    <div class="input-group date">
      <div class="input-group-addon">
        <ix class="fa fa-calendar"></ix>
      </div>
      <input type="text" class="form-control pull-right datepicker" id ="{../@fieldName}" name="{../@fieldName}"
             data-old="{value}" Value="{value}"
             onblur="preview('{preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','form'+code, this);" >
        <xsl:if test="../@isEditable=0">
          <xsl:attribute name="disabled">disabled</xsl:attribute>
        </xsl:if>
      </input>
    </div>
  </xsl:template>

  <xsl:template match="mediaBox">
    <label id="{../@fieldName}caption">
      <xsl:value-of select="titlecaption"/>
    </label>

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
          <ix class="fa fa-paperclip"></ix>&#160;
        </button>
      </span>
    </div>
  </xsl:template>

  <xsl:template match="autoSuggestBox">
    <label id="{../@fieldName}caption">
      <xsl:value-of select="titlecaption"/>
    </label>
    <select class="form-control select2" style="width: 100%;" name="{../@fieldName}" id="{../@fieldName}"
            data-old="{value/.}" data-oldText="{value/.}" data-value="{value/.}" data-child="Y"
            onchange="preview('{preview/.}', code, '{/sqroot/body/bodyContent/form/info/GUID/.}','form'+code, this);">
      <xsl:if test="../@isEditable=0">
        <xsl:attribute name="disabled">disabled</xsl:attribute>
      </xsl:if>

      <option value="NULL">-----Select-----</option>
    </select>

    <script>

      <!--$("#<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/><xsl:value-of select="../@fieldName"/>").select2({-->
      $("#<xsl:value-of select="../@fieldName"/>").select2({
      ajax: {

      url:"OPHCORe/api/msg_autosuggest.aspx",
      data: function (params) {
      var query = {
      search: params.term,
      page: params.page,
      code:"<xsl:value-of select="code"/>",
      id:"<xsl:value-of select="id"/>",
      name:"<xsl:value-of select="name"/>",
      key:"<xsl:value-of select='key'/>",
      wf1: "<xsl:value-of select='whereFields/wf1'/>",
      wf1value: ($("#<xsl:value-of select='whereFields/wf1'/>").val() === undefined ? "" : $("#<xsl:value-of select='whereFields/wf1'/>").val()),
      wf2: "<xsl:value-of select='whereFields/wf2'/>",
      wf2value: ($("#<xsl:value-of select='whereFields/wf2'/>").val() === undefined ? "" : $("#<xsl:value-of select='whereFields/wf2'/>").val())

      }

      return query;
      },
      dataType: 'json',
      //delay: 500
      }
      });
      <xsl:if test="value!=''">
        deferreds.push(
        autosuggestSetValue('<xsl:value-of select="../@fieldName"/>',"<xsl:value-of select="code"/>","<xsl:value-of select="id"/>","<xsl:value-of select="name"/>","<xsl:value-of select='key'/>","<xsl:value-of select='value'/>")
        );
      </xsl:if>

    </script>


  </xsl:template>

  <xsl:template match="tokenBox">
    <label id="{../@fieldName}caption">
      <xsl:value-of select="titlecaption"/>
    </label>

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

    <input type="text" class="form-control" Value="{$thisvalue}" name="{../@fieldName}" data-old="{value/.}" data-child="Y" onblur="preview('{preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','form'+code, this);" id ="{../@fieldName}">
      <xsl:if test="../@isEditable=0">
        <xsl:attribute name="disabled">disabled</xsl:attribute>
      </xsl:if>
    </input>
  </xsl:template>
  
  <xsl:template match="sqroot/body/bodyContent/form/children">
    <div class="offser1">
    <xsl:apply-templates select="child"/>&#160;
    </div>
  </xsl:template>

  <xsl:template match="child">
    <input type="hidden" id="CPKID" value="gchild{code/.}"/>
    <script>

      //xmldoc = "OPHCORE/api/default.aspx?code=<xsl:value-of select ="code/."/>&amp;mode=browse&amp;sqlFilter=<xsl:value-of select ="parentkey/."/>='<xsl:value-of select ="/sqroot/body/bodyContent/form/info/GUID/."/>'"
      //showXML('child<xsl:value-of select ="code/."/>', xmldoc, xsldoc + "_childBrowse.xslt", true, true, function () {});

      var code='<xsl:value-of select ="code/."/>';
      var parentKey='<xsl:value-of select ="parentkey/."/>';
      var GUID='<xsl:value-of select ="/sqroot/body/bodyContent/form/info/GUID/."/>';

      loadChild(code, parentKey, GUID);
    </script>

    <!--div class="col-md-12">
      <div class="box" style="border-top:none;" id="section2">
        <div class="box-header with-border" style="background:none">
          <h3 class="dashboard-title">
            <xsl:value-of select="childTitle/."/>
          </h3>
        </div>
      </div-->
    <div class="box visible-phone" style="box-shadow:0px;border:none;" id="child{code/.}">
      &#160;
    </div>
    <!--/div-->
  </xsl:template>

</xsl:stylesheet>
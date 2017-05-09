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
                <button id="button_save" class="btn btn-orange-a" onclick="saveThemeONE('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}', '');">SAVE</button>&#160;
                <button id="button_cancel" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
              </xsl:when>
              <xsl:when test="($documentstatus) = 0 or ($documentstatus) = ''">
                <button id="button_save" class="btn btn-orange-a" onclick="saveThemeONE('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}', '');">SAVE</button>&#160;
                <button id="button_cancel" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
                <button id="button_save" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}', 'delete');">DELETE</button>&#160;
                <xsl:if test="($settingmode)='T' and ($documentstatus) &lt; 400 ">
                  <button id="button_submit" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}', 'execute')">SUBMIT</button>
                </xsl:if>
              </xsl:when>
              <xsl:when test="($documentstatus) &gt; 99 and ($documentstatus) &lt; 199">
                <button id="button_save" class="btn btn-orange-a" onclick="saveThemeONE('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}', '');">SAVE</button>&#160;
                <button id="button_cancel" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
                <button id="button_approve" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}', 'execute')">APPROVE</button>
              </xsl:when>
              <xsl:when test="($documentstatus) = 300">
                <button id="button_save" class="btn btn-orange-a" onclick="saveThemeONE('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}', '');">SAVE</button>&#160;
                <button id="button_cancel" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
                <button id="button_reject" class="btn btn-orange-a">REJECT</button>&#160;
              </xsl:when>
              <xsl:when test="($documentstatus) &gt;= 400 and ($documentstatus) &lt;= 499">
                <button id="button_save" class="btn btn-orange-a" onclick="saveThemeONE('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}', '');">SAVE</button>&#160;
                <button id="button_cancel" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
                <button id="button_close" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}', 'force')">CLOSE</button>&#160;
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
                <button id="button_save2" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}', 'save');">SAVE</button>&#160;
                <button id="button_cancel2" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
              </xsl:when>
              <xsl:when test="($documentstatus) = 0 or ($documentstatus) = ''">
                <button id="button_save2" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}', 'save');">SAVE</button>&#160;
                <button id="button_cancel2" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
                <xsl:if test="($settingmode)='T' and ($documentstatus) &lt; 400 ">
                  <button id="button_submit2" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}', 'execute')">SUBMIT</button>
                </xsl:if>
              </xsl:when>
              <xsl:when test="($documentstatus) &gt; 99 and ($documentstatus) &lt; 199">
                <button id="button_save2" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}', 'save');">SAVE</button>&#160;
                <button id="button_cancel2" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
                <button id="button_approve2" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}', 'execute')">APPROVE</button>
              </xsl:when>
              <xsl:when test="($documentstatus) = 300">
                <button id="button_save2" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}', 'save');">SAVE</button>&#160;
                <button id="button_cancel2" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
                <button id="button_reject2" class="btn btn-orange-a">REJECT</button>&#160;
              </xsl:when>
              <xsl:when test="($documentstatus) &gt;= 400 and ($documentstatus) &lt;= 499">
                <button id="button_save2" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}', 'save');">SAVE</button>&#160;
                <button id="button_cancel2" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
                <button id="button_close2" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}', 'force')">CLOSE</button>&#160;
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

      <xsl:if test="sqroot/body/bodyContent/form/info/GUID !='00000000-0000-0000-0000-000000000000'">
        <xsl:apply-templates select="sqroot/body/bodyContent/form/children"/>
        <!-- /.col -->
      </xsl:if>
      <!-- browse for phone/tablet max width 768 -->
    </section>
    <!-- /.content -->


    <script>
      $(function () {

      <!--//Datemask dd/mm/yyyy--><!--
    $("#datemask").inputmask("dd/mm/yyyy", {"placeholder": "dd/mm/yyyy"});
    --><!--//Datemask2 mm/dd/yyyy--><!--
    $("#datemask2").inputmask("mm/dd/yyyy", {"placeholder": "mm/dd/yyyy"});
    --><!--//Money Euro--><!--
    $("[data-mask]").inputmask();

    --><!--//Date range picker--><!--
    $('#reservation').daterangepicker();
    --><!--//Date range picker with time picker--><!--
    $('#reservationtime').daterangepicker({timePicker: true, timePickerIncrement: 30, format: 'MM/DD/YYYY h:mm A'});
    --><!--//Date range as a button--><!--
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
    );-->

      <!--//Date picker-->
      $('.datepicker').datepicker({
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

  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent">
    <xsl:apply-templates select="form"/>
  </xsl:template>

  <xsl:template match="form">
    <script>
      var code = "<xsl:value-of select="info/code/."/>";
      var tblnm =code+"requiredname";
    </script>


    <div class="row collapse in" id="header" >
      <div class="col-md-12">
        <form role="form" id="formheader" enctype="multipart/form-data">
          <input type="hidden" id="cid" name="cid" value="{/sqroot/body/bodyContent/form/info/GUID/.}" />
          <input type="hidden" name ="{info/code/.}requiredname"/>
          <input type="hidden" name ="{info/code/.}requiredtblvalue"/>

          <!--<input type="hidden" name="mode" value="save"/>
      <input type="hidden" name="code" value="{info/code/.}"/>-->

          <xsl:apply-templates select="formPages/formPage[@pageNo&lt;9]"/>
        </form>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="formPages/formPage[@pageNo&lt;9]">
    <xsl:apply-templates select="formSections"/>
  </xsl:template>

  <xsl:template match="formSections">
    <xsl:apply-templates select="formSection"/>
  </xsl:template>

  <xsl:template match="formSection ">

    <div class="row">
      <xsl:choose>
        <xsl:when test="@rowTitle/.!=''">
          <div class="col-md-12" data-toggle="collapse" data-target="#section_{@sectionNo}">
            <h3>
              <xsl:value-of select="@rowTitle/."/>&#160;
            </h3>
          </div>
        </xsl:when>
        <xsl:otherwise>
          <div class="col-md-12" data-toggle="collapse" data-target="#section_{@sectionNo}">&#160;</div>
        </xsl:otherwise>
      </xsl:choose>
      <div class="col-md-12 collapse in" id="section_{@sectionNo}">
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
      <xsl:when test ="@isEditable=0 or (@isEditable=2 and (/sqroot/body/bodyContent/form/info/GUID/. != '00000000-0000-0000-0000-000000000000'))">
        <script>
          $('#<xsl:value-of select="@fieldName"/>').attr('disabled', true);
        </script>
      </xsl:when>
    </xsl:choose>


    <div class="form-group {$fieldEnabled}-input">
      <xsl:apply-templates select="textBox"/>
      <xsl:apply-templates select="dateBox"/>
      <xsl:apply-templates select="checkBox"/>
      <xsl:apply-templates select="autoSuggestBox"/>
      <xsl:apply-templates select="tokenBox"/>
      <xsl:apply-templates select="radio"/>
    </div>

  </xsl:template>

  <xsl:template match="checkBox">
    <!--Supaya bisa di serialize-->
    <input type="hidden" name="{../@fieldName}" id="hidden{../@fieldName}" value="0"/>
    <!--Supaya bisa di serialize-->

    <input type="checkbox" value="{value}" id ="{../@fieldName}"  name="{../@fieldName}" data-type="checkBox" data-old="{value}"
      onchange="checkCB('{../@fieldName}');preview('{preview/.}', getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','formheader', this);">
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

    <label id="{../@fieldName}suffixCaption">
      <xsl:value-of select="suffixCaption"/>
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


    <input type="text" class="form-control" Value="{$thisvalue}" data-type="textBox" data-old="{$thisvalue}" name="{../@fieldName}" onblur="preview('{preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','formheader', this);" id ="{../@fieldName}">
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
      <input type="text" class="form-control pull-right datepicker" id ="{../@fieldName}" name="{../@fieldName}" Value="{value}" data-type="dateBox" data-old="{value}"
        onblur="preview('{preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','formheader', this);" >
        <xsl:if test="../@isEditable=0">
          <xsl:attribute name="disabled">disabled</xsl:attribute>
        </xsl:if>
      </input>
    </div>
  </xsl:template>

  <xsl:template match="autoSuggestBox">
    <label id="{../@fieldName}caption">
      <xsl:value-of select="titlecaption"/>
    </label>
    <select class="form-control select2" style="width: 100%;" name="{../@fieldName}" id="{../@fieldName}"
            data-type="selectBox" data-old="{value/.}" data-oldText="{value/.}" data-value="{value/.}"
      onchange="preview('{preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','formheader', this);" >
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
    <script type="text/javascript">

      var sURL='OPHCore/api/msg_autosuggest.aspx?mode=token&amp;code=<xsl:value-of select="code/."/>&amp;key=<xsl:value-of select="key"/>&amp;id=<xsl:value-of select="id"/>&amp;name=<xsl:value-of select="name"/>'
      var noPrepopulate=0;
      <xsl:if test!="value">
        noPrepopulate=1;
      </xsl:if>
      var cURL='OPHCore/api/msg_autosuggest.aspx?mode=token&amp;code=<xsl:value-of select="code/."/>&amp;key=<xsl:value-of select="key"/>&amp;id=<xsl:value-of select="id"/>&amp;name=<xsl:value-of select="name"/>&amp;search=<xsl:value-of select="value"/>'
      
      $(document).ready(function(){
      $.ajax({
      url: cURL,
      dataType: 'json',
      success: function(data){
      if (noPrepopulate==1) data='';
      $("#<xsl:value-of select="../@fieldName"/>").tokenInput(
      sURL,
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


    <input type="text" class="form-control" Value="{$thisvalue}" data-type="tokenBox" data-old="{$thisvalue}" data-newJSON=""
           data-code="{code/.}"
      data-key="{key}" data-id="{id}" data-name="{name}"
      name="{../@fieldName}" id ="{../@fieldName}">

      <xsl:if test="../@isEditable=0">
        <xsl:attribute name="disabled">disabled</xsl:attribute>
      </xsl:if>
    </input>
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
    <div class = "btn-group" data-toggle = "buttons">
      <xsl:apply-templates select="radioSections/radioSection"/>
    </div>
    <div class="panel-body" id="accordion_{../@fieldName}" style="box-shadow:none;border:none;">
      <xsl:for-each select="radioSections/radioSection">
        <div id="panel_{../../../@fieldName}_{@radioNo}" class="box collapse" style="box-shadow:none;border:none;">
          <xsl:apply-templates select="radioRows/radioRow/fields" />&#160;
        </div>
      </xsl:for-each>
    </div>
  </xsl:template>

  <xsl:template match="radioSections/radioSection">
    <label class="radio-inline">
      <xsl:choose>
        <xsl:when test="@fieldName=../../value/.">
          <input type="radio" name="{../../../@fieldName}_radio" id="{../../../@fieldName}_radio_{@radioNo}" value="{@fieldName}" checked="checked" />
          <script>
            $('#panel_<xsl:value-of select="../../../@fieldName" />_<xsl:value-of select="@radioNo" />').collapse('show');
          </script>
        </xsl:when>
        <xsl:otherwise>
          <input type="radio" name="{../../../@fieldName}_radio" id="{../../../@fieldName}_radio_{@radioNo}" value="{@fieldName}" />
        </xsl:otherwise>
      </xsl:choose>
      <xsl:value-of select="@radioRowTitle"/>
    </label>
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
    <input type="hidden" id="PKID" value="child{code/.}"/>
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
    <div class="box visible-phone" style="box-shadow:0px;border:none" id="child{code/.}">
      &#160;
    </div>
    <!--/div-->
  </xsl:template>

</xsl:stylesheet>
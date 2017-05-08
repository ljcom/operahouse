<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:variable name="code" select="sqroot/body/bodyContent/query/info/code" />
  <xsl:variable name="desc" select="sqroot/body/bodyContent/query/info/description" />
  <xsl:variable name="sql" select="sqroot/body/bodyContent/query/info/querySQL" />
  <xsl:variable name="reportName" select="sqroot/body/bodyContent/query/info/reportName" />
  <xsl:variable name="isPDF" select="sqroot/body/bodyContent/query/info/permission/allowPDF" />
  <xsl:variable name="isXLS" select="sqroot/body/bodyContent/query/info/permission/allowXLS" />
  <xsl:variable name="isDownload" select="sqroot/body/bodyContent/query/info/permission/allowDownload" />
  <xsl:variable name="par">
    <xsl:for-each select="sqroot/body/bodyContent/query/queryPages/queryPage/querySections/querySection/queryCols/queryCol/queryRows/.">
      <xsl:text>**</xsl:text>
      <xsl:value-of select="queryRow/fields/field/@fieldName" />
      <xsl:text>**</xsl:text>
      <xsl:text>,</xsl:text>
    </xsl:for-each>
  </xsl:variable>

  <xsl:template match="/">
    <script>
      loadScript('OPHContent/themes/<xsl:value-of select="sqroot/header/info/themeFolder"/>/scripts/daterangepicker/daterangepicker.js');
      loadScript('OPHContent/themes/<xsl:value-of select="sqroot/header/info/themeFolder"/>/scripts/select2/select2.full.min.js');
      var xmldoc = ""
      var xsldoc = "OPHContent/themes/<xsl:value-of select="sqroot/header/info/themeFolder"/>/xslt/" + getPage();
      var deferreds = [];
    </script>
    <section class="content-header visible-phone">
      <h1>
        Report&#160;<xsl:value-of select="$desc"/>&#160;
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
            <span>
              <ix class="fa fa-home"></ix>
            </span>&#160;<xsl:value-of select="sqroot/header/info/code/name"/>&#160;<xsl:value-of select="sqroot/body/bodyContent/query/info/Description/."/> Query Filter
        </li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      <xsl:apply-templates select="sqroot/body/bodyContent"/>
      <div class="row">
        <div class="col-md-12 visible-phone" style="margin-bottom:50px;">
          <div style="text-align:left">
            <xsl:if test="$isPDF = 1 and $isXLS = 0"> 
              <button class="btn btn-orange-a" onclick="genReport('{$code}','{$par}', 1,'{$sql}','{$reportName}');">SHOW PDF</button>&#160;
            </xsl:if>
            <xsl:if test="$isXLS = 1 and $isPDF = 0">
              <button class="btn btn-orange-a" onclick="genReport('{$code}','{$par}', 0,'{$sql}','{$reportName}');">SHOW XLS</button>&#160;
            </xsl:if>
          </div>
        </div>
        <div class="col-md-12 displayblock-phone" style="margin-bottom:20px;">
          <div style="text-align:center">
            <button class="btn btn-orange-a" onclick="submitfunction('formheader',null,'{sqroot/body/bodyContent/query/info/code/.}');">SHOW</button>&#160;
          </div>
        </div>
      </div>
    </section>
    <script>
      $(function () {
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
      });

      $.when.apply($,deferreds).done(function() {
      preview(1,getCode(), null,'formheader');
      });
    </script>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent">
    <xsl:apply-templates select="query"/>
  </xsl:template>

  <xsl:template match="query">
    <script>
      //query
    </script>
   
    <div class="row" id="header" >
      <div class="col-md-12">
        <form role="form" id="formheader">
          <xsl:apply-templates select="queryPages/queryPage"/>
        </form>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="queryPages/queryPage">
    <script>
      //queryPage
    </script>

    <xsl:apply-templates select="querySections"/>
  </xsl:template>

  <xsl:template match="querySections">
    <script>
      //querySections
    </script>

    <xsl:apply-templates select="querySection"/>

  </xsl:template>

  <xsl:template match="querySection">
    <script>
      //querySection
    </script>

    <div class="row">
      <div class="col-md-12">
        <h2>
          <xsl:value-of select="@rowTitle/."/>&#160;
        </h2>
        <xsl:apply-templates select="queryCols"/>
      </div>
    </div>

  </xsl:template>

  <xsl:template match="queryCols">
    <xsl:apply-templates select="queryCol"/>
  </xsl:template>

  <xsl:template match="queryCol">
    <xsl:if test="@colNo='1'">
      <div class="col-md-6">
        <xsl:apply-templates select="queryRows"/>
      </div>
    </xsl:if>
    <xsl:if test="@colNo='2'">
      <div class="col-md-6">
        <xsl:apply-templates select="queryRows"/>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="queryRows">
    <xsl:apply-templates select="queryRow"/>
  </xsl:template>

  <xsl:template match="queryRow ">
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
        //document.getElementsByName(tblnm)[0].value = document.getElementsByName(tblnm)[0].value + ';<xsl:value-of select="@fieldName"/>'
      </script>
    </xsl:if>

    <div class="form-group enabled-input">
      <xsl:apply-templates select="textBox"/>
      <xsl:apply-templates select="dateBox"/>
      <xsl:apply-templates select="checkBox"/>
      <xsl:apply-templates select="comboBox"/>
    </div>
  </xsl:template>

  <xsl:template match="field[@isEditable=0]">
    <xsl:if test="@isNullable=0">
      <script>
        //document.getElementsByName(tblnm)[0].value = document.getElementsByName(tblnm)[0].value + ', <xsl:value-of select="@fieldName"/>'
      </script>
    </xsl:if>
    <div class="form-group disabled-input">
      <xsl:apply-templates select="textBox"/>
      <xsl:apply-templates select="dateBox"/>
      <xsl:apply-templates select="checkBox"/>
      <xsl:apply-templates select="comboBox"/>
    </div>
  </xsl:template>

  <xsl:template match="checkBox">
    <!--Supaya bisa di serialize-->
    <input type="hidden" name="{../@fieldName}" id="hidden{../@fieldName}" value="0"/>
    <!--Supaya bisa di serialize-->


    <input type="checkbox"  value="{value}" id ="{../@fieldName}"  name="{../@fieldName}" onchange="checkCB('{../@fieldName}');preview({preview/.},getCode(), null,'formheader');">
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


    <input type="text" class="form-control" Value="{value}" name="{../@fieldName}" onblur="preview({preview/.},getCode(), null,'formheader');" id ="{../@fieldName}">
      <xsl:if test="../@isEditable=0">
        <xsl:attribute name="disabled">disabled</xsl:attribute>
      </xsl:if>
    </input>
  </xsl:template>

  <xsl:template match="dateBox">
    <label id="{../@fieldName}caption">
      <xsl:value-of select="titleCaption"/>
    </label>
    <div class="input-group date">
      <div class="input-group-addon">
        <ix class="fa fa-calendar"></ix>
      </div>
      <input type="text" class="form-control pull-right datepicker" id ="{../@fieldName}" name="{../@fieldName}" Value="{value}" onblur="preview({preview/.},getCode(), null,'formheader');" >
        <xsl:if test="../@isEditable=0">
          <xsl:attribute name="disabled">disabled</xsl:attribute>
        </xsl:if>
      </input>
    </div>
  </xsl:template>

  <xsl:template match="comboBox">
    <label id="{../@fieldName}caption">
      <xsl:value-of select="titleCaption"/>
    </label>
    <select class="form-control select2" style="width: 100%;" name="{../@fieldName}" id="{../@fieldName}" onchange="preview({preview/.},getCode(), null,'formheader');" >
      <xsl:if test="../@isEditable=0">
        <xsl:attribute name="disabled">disabled</xsl:attribute>
      </xsl:if>
      <option value="NULL">-----Please Select-----</option>
    </select>
    
    <script>
      $("#<xsl:value-of select="../@fieldName"/>").select2({
      ajax: {

      url:"OPHCORE/api/msg_autosuggest.aspx",
      data: function (params) {
      var query = {
      search: params.term,
      page: params.page,
      code:"<xsl:value-of select='comboTable' />",
      key:"<xsl:value-of select='comboKey' />",
      id:"<xsl:value-of select='comboId' />",
      name:"<xsl:value-of select='comboName' />",
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


  

</xsl:stylesheet>

<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:template match="/">
    <style>
      .MyTextBox{
      background: transparent;
      border:none; width:100%; padding:5px; 20px;
      -webkit-animation: animation 2s ease-in-out;
      -moz-animation: animation 2s ease-in-out;

      }
      .MyTextBox:focus{
      box-shadow: 0px 2px 0px 0px rgba(3,154,228,1);
      -webkit-animation: animation 1s ease-in-out;
      -moz-animation: animation 1s ease-in-out;
      }
      .MyTextBox::-webkit-input-placeholder{
        opacity:0.2;
      }
    </style>
    <script>
      loadScript('OPHContent/themes/themeOne/scripts/select2/select2.full.min.js');
      var deferreds = [];
    </script>

    <xsl:apply-templates select="sqroot/body/bodyContent"/>

    <xsl:if test="sqroot/body/bodyContent/form/info/GUID !='00000000-0000-0000-0000-000000000000'">
      <xsl:apply-templates select="sqroot/body/bodyContent/form/children"/>
    </xsl:if>

  </xsl:template>


  <xsl:template match="sqroot/body/bodyContent">
    <div class="ms-hero-page-override ms-hero-img-coffee ms-bg-fixed ms-hero-bg-primary">
      <div class="container">
        <div class="text-center mt-2">
          <img src="ophcontent/themes/themeoperahouse/assets/img/useracct.png" alt="..." class="ms-avatar-hero animated zoomIn animation-delay-7" />
          <h1 class="color-white mt-4 animated fadeInUp animation-delay-10">
           <xsl:value-of select="form/formPages/formPage[@pageNo=1]/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='AccountId']/textBox/value/."/>
          </h1>
          <h3 class="color-medium no-mb animated fadeInUp animation-delay-10">
            <xsl:value-of select="form/formPages/formPage[@pageNo=1]/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='CompanyName']/textBox/value/."/>
          </h3>
        </div>
      </div>
    </div>

    <div class="container">
      <div class="card card-hero card-primary animated fadeInUp animation-delay-7">
        <div class="card-header-100">
          <div class="row">
            <div class="col-md-12">
              <div class="card-block">
                <h2 class="color-primary no-mb">Account Information</h2>
              </div>
            </div>
            
          </div>
        </div>
        <div class="row">
          
          <form method="post" id="formaccount">
            <xsl:apply-templates select="form"/>
            <div class="col-md-12">
              <a href="#" class="btn btn-raised btn-primary right" style="margin-left:20px;padding:10px 50px;" onclick="savethemeOPERAHOUSE('account', getGUID(), '', 'formaccount')">
                Save
              </a>
            </div>
          </form>
          <!--<div class="col-md-6">
            <div class="card-block">
              <h2 class="color-primary no-mb">Account Information</h2>
            </div>
            <form method="post" id="formaccount">
              <table class="table table-no-border table-striped">
                <xsl:apply-templates select="form"/>
                <tr>
                  <th style="width:200px;">
                  </th>
                  <td>
                    <a href="#" class="btn btn-raised btn-primary right" style="padding:10px 30px;">
                      Save
                    </a>
                  </td>
                </tr>
              </table>
            </form>
          </div>-->
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="form">
    <xsl:apply-templates select="formPages/formPage[@pageNo&lt;9]"/>
  </xsl:template>


  <xsl:template match="formSections">
    <xsl:apply-templates select="formSection"/>
  </xsl:template>

  <xsl:template match="formSection">
    <div class="col-md-6">
      <table class="table table-no-border table-striped">
        <xsl:apply-templates select="formCols"/>
      </table>
    </div>
    
  </xsl:template>

  <xsl:template match="formCols">
    <xsl:apply-templates select="formCol"/>
  </xsl:template>

  <xsl:template match="formCol">
    <xsl:apply-templates select="formRows"/>
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
    <xsl:apply-templates select="textBox"/>
    <xsl:apply-templates select="autoSuggestBox"/>    
  </xsl:template>

  <xsl:template match="textBox">
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
    <tr>
      <th style="width:200px;">
        <!--<i class="zmdi zmdi-account mr-1 color-royal"></i>-->
        <xsl:value-of select="titlecaption/."/>
      </th>
      <td>
        <input type="text" class="MyTextBox"  Value="{$thisvalue}" data-type="textBox" data-old="{$thisvalue}" name="{../@fieldName}"
           onblur="preview('{preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','formheader', this);" id ="{../@fieldName}"
           oninput="javascript:checkChanges(this)" placeholder="{titlecaption/.}">
            
        </input>
      </td>
    </tr>
  </xsl:template>

  <!--<xsl:template match="autoSuggestBox">
    <tr>
      <th>
        --><!--<i class="zmdi zmdi-account mr-1 color-royal"></i>--><!--
        <xsl:value-of select="titlecaption/."/>
      </th>
      <td>
        <input type="text" value="{value/.}" class="MyTextBox"/>
      </td>
    </tr>
    
    
  </xsl:template>-->

  <xsl:template match="autoSuggestBox">
    <tr>
      <th style="width:200px;">
        <!--<i class="zmdi zmdi-account mr-1 color-royal"></i>-->
        <xsl:value-of select="titlecaption"/>
      </th>
      <td>
        <select class="form-control select2" style="width: 100%;" name="{../@fieldName}" id="{../@fieldName}"
           data-type="selectBox" data-old="{value/.}" data-oldText="{value/.}" data-value="{value/.}" data-child="Y"
           onchange="preview('{preview/.}', '{/sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}','form{/sqroot/body/bodyContent/form/info/code/.}', this);">
          <xsl:choose>
            <xsl:when test ="../@isEditable=1 or (../@isEditable=2 and (/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))"></xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="disabled">disabled</xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>

          <option value="NULL">-----Select-----</option>
        </select>
      </td>
    </tr>
    
    <!--<label id="{../@fieldName}caption">
      <xsl:value-of select="titlecaption"/>
    </label>
    
    <xsl:if test="../@isNullable = 0">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>-->

    <script>
      <!--$("#<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/><xsl:value-of select="../@fieldName"/>").select2({-->
      $("#<xsl:value-of select="../@fieldName"/>").select2({
      ajax: {

      url:"OPHCORE/api/msg_autosuggest.aspx",
      data: function (params) {
      var query = {
      search: params.term,
      page: params.page,
      code:"<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>",
      colkey:"<xsl:value-of select="../@fieldName"/>"
      }

      return query;
      },
      dataType: 'json',
      //delay: 500
      }
      });
      <xsl:if test="value!=''">
        deferreds.push(
        autosuggestSetValue('<xsl:value-of select="../@fieldName"/>','<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>','<xsl:value-of select='../@fieldName'/>', '<xsl:value-of select='value'/>', '<xsl:value-of select='whereFields/wf1'/>', '<xsl:value-of select='whereFields/wf2'/>')
        );
      </xsl:if>
    </script>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/form/children">
    <xsl:apply-templates select="child"/>
  </xsl:template>


  <xsl:template match="child">
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

    <div id="child{code/.}{/sqroot/body/bodyContent/form/info/GUID/.}">
      &#160;
    </div>
  </xsl:template>
</xsl:stylesheet>

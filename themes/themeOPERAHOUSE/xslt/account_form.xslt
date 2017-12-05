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
          <!--<img src="ophcontent/themes/themeoperahouse/assets/img/useracct.png" alt="..." class="ms-avatar-hero animated zoomIn animation-delay-7" />-->
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
        <div class="card-header-50">
          <a href="index.aspx?env=front&amp;code=userprofile&amp;GUID={/sqroot/header/info/user/userGUID}" class="btn btn-s btn-primary" style="margin-top:0px">
            <i class="fa fa-arrow-left"></i> BACK TO PROFILE
          </a>
          
          <!--<ul class="nav nav-tabs nav-tabs-full nav-tabs-4 shadow-2dp" role="tablist">
            <li role="presentation">
              <a class="withoutripple" data-scroll="" href="index.aspx?env=front&amp;code=userprofile&amp;GUID={/sqroot/header/info/user/userGUID}" >
                <i class="zmdi zmdi-arrow-left"></i>
                <span class="hidden-xs">Back To Profile</span>
              </a>
            </li>
            
            <li role="presentation">
              <a class="withoutripple" data-scroll="" href="#childaccountdetail" >
                <i class="zmdi zmdi-accounts-list"></i>
                <span class="hidden-xs">Package</span>
              </a>
            </li>
            <li role="presentation">
              <a href="{form/formPages/formPage[@pageNo=1]/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='pageURL']/textBox/value/.}" target="new" class="withoutripple">
                <i class="zmdi zmdi-globe"></i>
                <span class="hidden-xs">Go To Website</span>
              </a>
            </li>
            
            
            
          </ul>-->
        </div>
        <div class="text-center">
          <h2 class="no-m ms-site-title color-primary center-block ms-site-title-lg mt-2 animated zoomInDown animation-delay-5">
            <xsl:value-of select ="/sqroot/header/info/title/."/>
          </h2>
          <p class="lead lead-lg color-default text-center center-block mt-2 mb-2 mw-800 text-uppercase fw-300 animated fadeInUp animation-delay-7">
            <xsl:value-of select ="/sqroot/header/info/code/additionalDesc/."/>
          </p>
        </div>
        <div class="row">
          <form class="form-horizontal" id="form{/sqroot/body/bodyContent/form/info/code/.}" method="post">
            <fieldset>
              <xsl:apply-templates select="form"/>
            </fieldset>
          </form>

        </div>
        <div class="row">
          <div class="col-md-8">
            &#xA0;
          </div>
          <div class="col-md-4 text-right">
            <div class="col-md-6">
              <a href="javascript:void(0)" class="btn btn-raised btn-block btn-primary mt-4"  onclick="savethemeOPERAHOUSE(getCode(), getGUID(), '', 'form{/sqroot/body/bodyContent/form/info/code/.}')">
                Save
              </a>
            </div>
            <div class="col-md-6">
              <a href="javascript:void(0)" class="btn btn-raised btn-block btn-default mt-4">
                Cancel
              </a>
            </div>
          </div>
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
    <div class="col-md-6">
      <xsl:apply-templates select="formRows"/>
    </div>
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
    <div class="form-group">
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

  <xsl:template match="textBox">
    <label id="{../@fieldName}caption" for="inputUser" class="col-md-3 control-label" style="margin:0px;">
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

    <xsl:variable name="fieldEnabled">
      <xsl:choose>
        <xsl:when test ="../@isEditable=1 or (../@isEditable=2 and (/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))">enabled</xsl:when>
        <xsl:otherwise>disabled</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <div class="col-md-8">
      <input type="text" class="form-control {$fieldEnabled}-input" Value="{$thisvalue}" data-type="textBox" data-old="{$thisvalue}" name="{../@fieldName}" 
             onblur="preview('{preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','formheader', this);" id ="{../@fieldName}"
             oninput="javascript:checkChanges(this)" spellcheck="false">
        <xsl:if test="../@isEditable='0' or (../@isEditable='2' and (/sqroot/body/bodyContent/form/info/GUID/. != '00000000-0000-0000-0000-000000000000'))">
          <xsl:attribute name="disabled">disabled</xsl:attribute>
        </xsl:if>
        <xsl:if test="../@isEditable='1'">
          <xsl:attribute name="placeholder">Please Enter <xsl:value-of select="titlecaption" /></xsl:attribute>
        </xsl:if>
      </input>
    </div>
  </xsl:template>

  <xsl:template match="passwordBox">
    <label id="{../@fieldName}caption" for="inputUser" class="col-md-3 control-label">
      <xsl:value-of select="titlecaption"/>
    </label>
    <xsl:if test="../@isNullable = 0">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>

    <xsl:variable name="fieldEnabled">
      <xsl:choose>
        <xsl:when test ="../@isEditable=1 or (../@isEditable=2 and (/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))">enabled</xsl:when>
        <xsl:otherwise>disabled</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <div class="col-md-8">
      <input type="password" class="form-control {$fieldEnabled}-input" Value="********" data-type="textBox" data-old="" name="{../@fieldName}"
        onblur="preview('{preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','formheader', this);" id ="{../@fieldName}" spellcheck="false">

      </input>
    </div>

  </xsl:template>


  <xsl:template match="autoSuggestBox">
    <label id="{../@fieldName}caption" for="inputUser" class="col-md-3 control-label" style="margin:0px;">
      <xsl:value-of select="titlecaption"/>
    </label>
    <div class="col-md-8">
      <select class="form-control select2"  name="{../@fieldName}" id="{../@fieldName}"
         data-type="selectBox" data-old="{value/.}" data-oldText="{value/.}" data-value="{value/.}" data-child="Y"
         onchange="preview('{preview/.}', '{/sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}','form{/sqroot/body/bodyContent/form/info/code/.}', this);">


        <option value="NULL">
          Please Select <xsl:value-of select="titlecaption"/>
        </option>
      </select>
    </div>


    <!--<label id="{../@fieldName}caption">
      <xsl:value-of select="titlecaption"/>
    </label>
    
    <xsl:if test="../@isNullable = 0">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>-->

    <script>
      <!--$("#<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/><xsl:value-of select="../@fieldName"/>").select2({-->
      var wf1 = '<xsl:value-of select='whereFields/wf1'/>';
      var wf1value = '';
      if (wf1 != ''){
      var wf1value<xsl:value-of select="../@fieldName"/> = $("#<xsl:value-of select='whereFields/wf1'/>").val()
      }

      $("#<xsl:value-of select="../@fieldName"/>").select2({
      ajax: {

      url:"OPHCORE/api/msg_autosuggest.aspx",
      data: function (params) {
      var query = {
      search: params.term,
      page: params.page,
      code:"<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>",
      colkey:"<xsl:value-of select="../@fieldName"/>",
      wf1 : '<xsl:value-of select='whereFields/wf1'/>',
      wf1value: wf1value<xsl:value-of select="../@fieldName"/>
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
      <xsl:if test="not(value) and (../@fieldName)='Package'">
        deferreds.push(
        autosuggestSetValue('<xsl:value-of select="../@fieldName"/>','<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>','<xsl:value-of select='../@fieldName'/>', getQueryVariable("package"), '<xsl:value-of select='whereFields/wf1'/>', '<xsl:value-of select='whereFields/wf2'/>')
        );
      </xsl:if>
      <xsl:if test="not(value) and (../@fieldName)='PackagePrice'">
        deferreds.push(
        autosuggestSetValue('<xsl:value-of select="../@fieldName"/>','<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>','<xsl:value-of select='../@fieldName'/>', getQueryVariable("plan"), '<xsl:value-of select='whereFields/wf1'/>', '<xsl:value-of select='whereFields/wf2'/>')
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

    <div id="child{code/.}">
      <div id="child{code/.}{/sqroot/body/bodyContent/form/info/GUID/.}">
        &#160;
      </div>
    </div>
  </xsl:template>
</xsl:stylesheet>

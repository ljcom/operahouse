﻿<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:template match="/">
    <script>
      loadScript('OPHContent/themes/themeOne/scripts/select2/select2.full.min.js');
      
      var deferreds = [];
    </script>
    <h1 class="color-primary text-center">Order Form</h1>

    <form class="form-horizontal" id="formorders" method="post">
      <fieldset>
        <div class="col-md-12" data-toggle="collapse" data-target="#section_{@sectionNo}" style="display:none">
          <h3>
            Customer Information
          </h3>
        </div>
        <div class="col-md-12">
          <div class="col-md-6">
            <div class="form-group" style="display:none">
              <label id="AccountIdcaption" for="inputUser" class="col-md-3 control-label" style="margin:0px;">Name</label>
              <div class="col-md-8">
                <input class="form-control" type="text" id="username" value="{/sqroot/header/info/user/userName}" disabled=""/>
              </div>
            </div>
            <div class="form-group" style="display:none">
              <label id="AccountIdcaption" for="inputUser" class="col-md-3 control-label" style="margin:0px;">Name</label>
              <div class="col-md-8">
                <input class="form-control" type="text" id="userguid" name="userguid" value="{/sqroot/header/info/user/userGUID}" disabled=""/>
              </div>
            </div>
          </div>
        </div>
        <xsl:apply-templates select="sqroot/body/bodyContent"/>
      </fieldset>
    </form>
        <div class="row">
          <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-raised btn-primary btn-block mt-4" onclick="savethemeOPERAHOUSE('orders', '00000000-0000-0000-0000-000000000000', '', 'formorders')">Submit</button>
          </div>
        </div>

    
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent">
    <xsl:apply-templates select="form"/>
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

    <div class="col-md-8">
      <input type="text" class="form-control" Value="{$thisvalue}" data-type="textBox" data-old="{$thisvalue}" name="{../@fieldName}" placeholder="Please Enter {titlecaption}"
             onblur="preview('{preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','formheader', this);" id ="{../@fieldName}"
             oninput="javascript:checkChanges(this)">
        <xsl:if test="../@isEditable='0' or (../@isEditable='2' and (/sqroot/body/bodyContent/form/info/GUID/. != '00000000-0000-0000-0000-000000000000'))">
          <xsl:attribute name="disabled">disabled</xsl:attribute>
        </xsl:if>
      </input>
    </div>
  </xsl:template>

  <xsl:template match="passwordBox">
    <label id="{../@fieldName}caption" for="inputUser" class="col-md-2 control-label">
      <xsl:value-of select="titlecaption"/>
    </label>
    <xsl:if test="../@isNullable = 0">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>

    <div class="col-md-9">
      <input type="password" class="form-control" Value="********" data-type="textBox" data-old="" name="{../@fieldName}"
        onblur="preview('{preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','formheader', this);" id ="{../@fieldName}">

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


        <option value="NULL"> Please Select <xsl:value-of select="titlecaption"/> </option>
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
</xsl:stylesheet>

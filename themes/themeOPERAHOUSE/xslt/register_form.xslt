<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:template match="/">

    
   
    <form class="form-horizontal">
      <fieldset>
        <xsl:apply-templates select="sqroot/body/bodyContent"/>
        <div class="row">
          <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-raised btn-primary btn-block mt-4">Register Now</button>
          </div>
        </div>
      </fieldset>
    </form>
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
    <label id="{../@fieldName}caption" for="inputUser" class="col-md-2 control-label">
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

    <div class="col-md-9">
      <input type="text" class="form-control" Value="{$thisvalue}" data-type="textBox" data-old="{$thisvalue}" name="{../@fieldName}"
             onblur="preview('{preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','formheader', this);" id ="{../@fieldName}"
             oninput="javascript:checkChanges(this)">

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

</xsl:stylesheet>

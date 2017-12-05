<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:template match="/">
    <script>
      loadScript('OPHContent/themes/themeOne/scripts/select2/select2.full.min.js');

      var deferreds = [];
    </script>
    <xsl:apply-templates select="sqroot/body/bodyContent"/>

  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="notiModalClose">
        <span aria-hidden="true">
          <i class="zmdi zmdi-close"></i>
        </span>
      </button>
      <h3 class="modal-title" id="notiModalLabel">
        <xsl:value-of select ="/sqroot/header/info/code/name/."/>
      </h3>
    </div>
    <div class="modal-body">
      <form class="form-horizontal" id="form{/sqroot/body/bodyContent/form/info/code/.}" method="post">
        <input class="form-control" type="hidden" id="userguid" name="userguid" value="{/sqroot/header/info/user/userGUID}"/>
        <input class="form-control" type="hidden" id="cartid" name="cartid" value=""/>
        <script>
          $("#cartid").val(getCookie('cartID'));
        </script>
        <fieldset>
          <xsl:apply-templates select="form"/>
        </fieldset>
      </form>
    </div>
    <div class="col-md-12" id="modalalert" style="display:none;">
      <div class="alert alert-primary alert-dismissible">
        <button type="button" class="close" onclick="$('#modalalert').hide()">
          <i class="zmdi zmdi-close"></i>
        </button>
        <div id="modalalertmsg">Message</div>
      </div>
    </div>
    <div class="modal-footer" id="notiModalFooter">
      <button type="button" class="btn btn-primary btn-raised"  onclick="savethemeOPERAHOUSE('{/sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}',  '', 'form{/sqroot/body/bodyContent/form/info/code/.}', '1')">Add To Cart</button>
      <button type="button" class="btn btn-primary btn-raised" data-dismiss="modal" onclick=" $('#notiModal').hide()">Close</button>
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
    <div class="col-md-12">
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
          <xsl:attribute name="placeholder">Please Enter <xsl:value-of select="titlecaption" />
        </xsl:attribute>
         
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
      <xsl:if test="@addCombo = '1'">
        <div class="col-md-10">
          <select class="form-control select2"  name="{../@fieldName}" id="{../@fieldName}"
           data-type="selectBox" data-old="{value/.}" data-oldText="{value/.}" data-value="{value/.}" data-child="Y"
           onchange="preview('{preview/.}', '{/sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}','form{/sqroot/body/bodyContent/form/info/code/.}', this);" >
            <xsl:if test="../@isEditable='0' or (../@isEditable='2' and (/sqroot/body/bodyContent/form/info/GUID/. != '00000000-0000-0000-0000-000000000000'))">
              <xsl:attribute name="disabled">disabled</xsl:attribute>
            </xsl:if>
            <option value="NULL">
              Please Select <xsl:value-of select="titlecaption"/>
            </option>
          </select>
        </div>
        <div class="col-md-2">
          <a class="btn-circle btn-circle-xs btn-circle-primary" title="Add New {titlecaption}" href="index.aspx?code={@comboCode}&amp;GUID=00000000-0000-0000-0000-000000000000" target="new">
            <i class="fa fa-plus"></i>
          </a>
        </div>
      </xsl:if>
      <xsl:if test="@addCombo = '0'">
        <div class="col-md-12">
          <select class="form-control select2"  name="{../@fieldName}" id="{../@fieldName}"
           data-type="selectBox" data-old="{value/.}" data-oldText="{value/.}" data-value="{value/.}" data-child="Y"
           onchange="preview('{preview/.}', '{/sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}','form{/sqroot/body/bodyContent/form/info/code/.}', this);" >
            <xsl:if test="../@isEditable='0' or (../@isEditable='2' and (/sqroot/body/bodyContent/form/info/GUID/. != '00000000-0000-0000-0000-000000000000'))">
              <xsl:attribute name="disabled">disabled</xsl:attribute>
            </xsl:if>
            <option value="NULL">
              Please Select <xsl:value-of select="titlecaption"/>
            </option>
          </select>
        </div>
      </xsl:if>


     
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
      wf1value: ('<xsl:value-of select='whereFields/wf1'/>' != '') ? $("#<xsl:value-of select='whereFields/wf1'/>").val() : ''
      }

      return query;
      },
      dataType: 'json',
      //delay: 500
      }
      });
      <xsl:if test="not(value) and (../@fieldName)='Package'">

        if (getCookie('packageguid') &amp;&amp; getCookie('packageguid') != 'undefined'){
        deferreds.push(
        autosuggestSetValue('<xsl:value-of select="../@fieldName"/>','<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>','<xsl:value-of select='../@fieldName'/>', getCookie('packageguid'), '<xsl:value-of select='whereFields/wf1'/>', '<xsl:value-of select='whereFields/wf2'/>')
        );
        }
      </xsl:if>
      <xsl:if test="not(value) and (../@fieldName)='PackagePrice'">

        if (getCookie('planguid') &amp;&amp; getCookie('planguid') != 'undefined'){
        deferreds.push(
        autosuggestSetValue('<xsl:value-of select="../@fieldName"/>','<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>','<xsl:value-of select='../@fieldName'/>', getCookie('planguid'), '<xsl:value-of select='whereFields/wf1'/>', '<xsl:value-of select='whereFields/wf2'/>')
        );
        }
      </xsl:if>
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


</xsl:stylesheet>

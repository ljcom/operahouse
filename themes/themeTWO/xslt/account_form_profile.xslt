<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
    <div class="col-xs-12">
      <div class="innerWrapper profile">
        <div class="orderBox">
          <h4>profile</h4>
        </div>
        <div class="row">
          <div class="col-md-2 col-sm-3 col-xs-12">
            <div class="thumbnail">
              <img src="OPHCOntent/themes/themeTWO/images/doc-talk-icon2.png" alt="profile-image" />
              <div class="caption">
                <a href="#" class="btn btn-primary btn-block" role="button">Change Avatar</a>
              </div>
            </div>
          </div>
          <div class="col-md-10 col-sm-9 col-xs-12">
            
            <!--<xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows" />-->
            <form class="form-horizontal" method="post" id="userform">
              <!--<input type="text" name="cfunctionlist" value="{/sqroot/body/bodyContent/form/info/GUID/.}"/>-->
              <xsl:apply-templates select="sqroot/body/bodyContent/form/formPages/formPage[@pageNo = '1']/formSections/formSection/formCols/formCol/formRows" />
              <!--<div class="alert alert-success alert-dismissable">
                <a href="#" class="close" data-dismiss="alert" aria-label="close">×</a>
                <strong>Save Success</strong> This alert box could indicate a successful or positive action.
              </div>-->
              <div class="form-group">
                <div class="col-md-offset-10 col-md-2 col-sm-offset-9 col-sm-3">
                  <a class="btn btn-primary btn-block" onClick="SaveData('caUSERFRON', 'userform', '', '{/sqroot/body/bodyContent/form/info/GUID/.}')">SAVE INFO</a>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>

  </xsl:template>
  
  <xsl:template match="sqroot/body/bodyContent/form/formPages/formPage[@pageNo = '1']/formSections/formSection/formCols/formCol/formRows">
    <xsl:apply-templates select="formRow" />
  </xsl:template>

  <xsl:template match="formRow">
    <xsl:apply-templates select="fields/field/textBox" />
    <xsl:apply-templates select="fields/field/passwordBox" />
  </xsl:template>
    
 <xsl:template match="fields/field/textBox">
   <!--<xsl:value-of select="$isEditable" />-->
  <div class="form-group">
    <label for="" class="col-md-2 col-sm-3 control-label"><xsl:value-of select="titlecaption/." /></label>
    <div class="col-md-10 col-sm-9">
    <xsl:choose>
      <xsl:when test="../@isEditable = 1">
        <input type="text" class="form-control" id="{../@fieldName}" name="{../@fieldName}" placeholder="" value="{value/.}" />
      </xsl:when>
      <xsl:otherwise>
        <input type="text" class="form-control" id="{../@fieldName}" name="{../@fieldName}" placeholder="" value="{value/.}" readonly="readonly"/>
      </xsl:otherwise>
    </xsl:choose>  
      
    </div>
  </div>
 </xsl:template>
  
 <xsl:template match="fields/field/passwordBox">
  <div class="form-group">
    <label for="" class="col-md-2 col-sm-3 control-label"><xsl:value-of select="titlecaption/." /></label>
    <div class="col-md-10 col-sm-9">
      <xsl:choose>
        <xsl:when test="../@isEditable = 1">
          <input type="password" class="form-control" id="{../@fieldName}" name="{../@fieldName}" placeholder="Please type your old or new password" value="{value/.}" />
        </xsl:when>
        <xsl:otherwise>
          <input type="password" class="form-control" id="{../@fieldName}" name="{../@fieldName}" placeholder="" value="{value/.}" readonly="readonly" />
        </xsl:otherwise>
      </xsl:choose> 
    </div>
  </div>
 </xsl:template>
    
  
</xsl:stylesheet>

<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>
  <xsl:variable name="lowerCode">
    <xsl:value-of select="translate(/sqroot/body/bodyContent/form/info/code, $uppercase, $smallcase)"/>
  </xsl:variable>
  <xsl:variable name="allowAccess" select="/sqroot/body/bodyContent/form/info/permission/allowAccess" />
  <xsl:variable name="allowForce" select="/sqroot/body/bodyContent/form/info/permission/allowForce" />
  <xsl:variable name="allowDelete" select="/sqroot/body/bodyContent/form/info/permission/allowDelete" />
  <xsl:variable name="allowWipe" select="/sqroot/body/bodyContent/form/info/permission/allowWipe" />
  <xsl:variable name="allowOnOff" select="/sqroot/body/bodyContent/form/info/permission/allowOnOff" />
  <xsl:variable name="settingMode" select="/sqroot/body/bodyContent/form/info/settingMode/." />
  <xsl:variable name="docState" select="/sqroot/body/bodyContent/form/info/state/parentState/."/>
  <xsl:variable name="isRequester" select="/sqroot/body/bodyContent/form/info/document/isRequester"/>
  <xsl:variable name="cid" select="translate(/sqroot/body/bodyContent/form/info/GUID/., 'ABCDEF', 'abcdef')"/>

  <xsl:template match="/">
    <!-- Content Header (Page header) -->
    <script>
      <!--loadScript('OPHContent/cdn/daterangepicker/daterangepicker.js');
      loadScript('OPHContent/cdn/select2/select2.full.min.js');-->

      <!--var xmldoc = ""
      var--> <!--xsldoc = "OPHContent/themes/<xsl:value-of select="sqroot/header/info/themeFolder"/>/xslt/" + getPage();-->

      $('.datepicker').datepicker({
      autoclose: true
      });
      <!--//Date time picker-->
      <!--$('.datetimepicker').datetimepicker({

      });-->
      <!--$(".timepicker").timepicker({
      minuteStep: 15,
      template: 'modal',
      appendWidgetTo: 'body',
      showSeconds: false,
      showMeridian: false,
      defaultTime: false
      });-->

      upload_init('<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>');

      <!--
      $(function() {

      // We can attach the `fileselect` event to all file inputs on the page
      $(document).on('change', ':file', function() {
      var input = $(this),
      numFiles = input.get(0).files ? input.get(0).files.length : 1,
      label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
      
      input.trigger('fileselect', [numFiles, label]);
      alert(label);

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
-->
      //upload_init('<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>');
      
	  function <xsl:value-of select="$lowerCode" />_save(location) {
      saveThemeONE('<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/." />',
      '<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/." />', location, '',
      (function(d) {<xsl:value-of select="$lowerCode" />_saveafter(d)}), (function(d) {<xsl:value-of select="$lowerCode" />_savebefore(d)}));
      }

      function <xsl:value-of select="$lowerCode" />_saveafter(d) {}
      function <xsl:value-of select="$lowerCode" />_savebefore(d) {}

	  preview(1, '<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>', '<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>','form<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>', this);
			
																	
																						  
																																			 
	   

																   
																	

	 
    </script>

    <!-- Main content -->
    <section class="content">

      <!-- title -->

      <xsl:apply-templates select="sqroot/body/bodyContent"/>
      <script>
        $.when.apply($, deferreds).done(function() {
        preview(1, '<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>', '<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>','form<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>', this);
        });
      </script>		   

      <!-- view header -->
      <div class="row" style="box-shadow:0px;border:0;">
        <div class="col-md-12" style="margin-bottom:50px;">
          <div style="text-align:left">
            <!--location: 0 header; 1 child; 2 browse
              location: browse:10, header form:20, browse anak:30, browse form:40-->

            <xsl:if test="(/sqroot/body/bodyContent/form/info/permission/allowAdd=1 and (/sqroot/body/bodyContent/form/info/state/parentState/.=0 or /sqroot/body/bodyContent/form/info/state/parentState/.=300))">
              <button id="child_button_addSave" class="btn btn-orange-a"
			  onclick="{$lowerCode}_save(41);">SAVE &amp; ADD NEW</button>&#160;
            </xsl:if>

            <button id="child_button_save" class="btn btn-orange-a btn-none"
            onclick="{$lowerCode}_save(40);">SAVE</button>&#160;
            <button id="child_button_cancel" class="btn btn-gray-a btn-none"
            onclick="closeChildForm('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}')">CANCEL</button>&#160;

            <xsl:if test="(/sqroot/body/bodyContent/form/info/GUID/.)!='00000000-0000-0000-0000-000000000000'">
              <script>
																																						 
                $('#child_button_addSave').hide();
						 
                $('#child_button_save').hide();
                $('#child_button_cancel').hide();
              </script>
            </xsl:if>

          </div>
        </div>


      </div>
      <!-- button view header -->
      <xsl:apply-templates select="sqroot/body/bodyContent/form/children/child"/>
      <!-- /.col -->

      <!-- browse for phone/tablet max width 768 -->
    </section>
    <!-- /.content -->
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
      <input type="hidden" id="chid" name="chid" value="{/sqroot/body/bodyContent/form/info/GUID/.}" />
	
    <div class="col-md-12" id="child">
      <form role="form" id="form{info/code/.}">
        <input type="hidden" name="{info/parentKey/.}" id="PK{info/code/.}" value=""/>
        <script>
		//cannot use cid because grandchildren not using cid as parent
          var childCode = 'child' + code;
          var parentGUID = $("div[id*='" + childCode + "']").attr('id')
          parentGUID = parentGUID.replace(childCode, '');
          $('#PK'+code).val(parentGUID);
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
    <div class="box box-solid box-default" style="box-shadow:0px;border:none;">
      <div class="col-md-12">
        <xsl:if test="@rowTitle/.!=''">
          <h3>
            <xsl:value-of select="@rowTitle/."/>&#160;
          </h3>
        </xsl:if>
        <xsl:apply-templates select="formCols"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="formCols">
    <xsl:apply-templates select="formCol"/>
  </xsl:template>

  <xsl:template match="formCol">
      <xsl:variable name="colMax">
      <xsl:for-each select="../formCol/.">
        <xsl:sort select="@colNo" data-type="number" order="descending"/>
        <xsl:if test="position() = 1">
          <xsl:value-of select="@colNo"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$colMax=0">
        <div class="col-md-12" data-cm="{$colMax}">
          <xsl:apply-templates select="formRows"/>
        </div>
      </xsl:when>
      <xsl:when test="$colMax=1 or $colMax=2">
        <div class="col-md-6" data-cm="{$colMax}">
          <xsl:if test="@colNo='1'">
            <xsl:apply-templates select="formRows"/>
          </xsl:if>
          <xsl:if test="@colNo='2'">
            <xsl:apply-templates select="formRows"/>
          </xsl:if>
        </div>
      </xsl:when>
      <xsl:when test="$colMax=3">
        <div class="col-md-4" data-cm="{$colMax}">
          <xsl:if test="@colNo='1'">
            <xsl:apply-templates select="formRows"/>
          </xsl:if>
          <xsl:if test="@colNo='2'">
            <xsl:apply-templates select="formRows"/>
          </xsl:if>
          <xsl:if test="@colNo='3'">
            <xsl:apply-templates select="formRows"/>
          </xsl:if>
        </div>
      </xsl:when>
      <xsl:when test="$colMax=4">
        <div class="col-md-3" data-cm="{$colMax}">
          <xsl:if test="@colNo='1'">
            <xsl:apply-templates select="formRows"/>
          </xsl:if>
          <xsl:if test="@colNo='2'">
            <xsl:apply-templates select="formRows"/>
          </xsl:if>
          <xsl:if test="@colNo='3'">
            <xsl:apply-templates select="formRows"/>
          </xsl:if>
          <xsl:if test="@colNo='4'">
            <xsl:apply-templates select="formRows"/>
          </xsl:if>
        </div>
      </xsl:when>


    </xsl:choose>
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
        <xsl:when test ="((@isEditable='1' and ($docState='' or $docState=0 or $docState=300 
							or $cid = '00000000-0000-0000-0000-000000000000' or /sqroot/body/bodyContent/form/info/parentMode/.='C' or /sqroot/body/bodyContent/form/info/parentMode/.='M' )) 
                        or (@isEditable='2' and $cid = '00000000-0000-0000-0000-000000000000')
                        or (@isEditable='3' and $docState&lt;400)
                        or (@isEditable='4' and $docState&lt;500))">enabled</xsl:when>
        <xsl:otherwise>disabled</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test ="$fieldEnabled='disabled'">
        <script>
          $('#<xsl:value-of select="@fieldName"/>').attr('disabled', true);
        </script>
      </xsl:when>
    </xsl:choose>
    <script>
      //alert('<xsl:value-of select="@isEditable" />');
    </script>

    <div class="form-group {$fieldEnabled}-input">
      <xsl:apply-templates select="textBox"/>
      <xsl:apply-templates select="textEditor"/>
      <xsl:apply-templates select="textArea"/>
      <xsl:apply-templates select="dateBox"/>
      <xsl:apply-templates select="dateTimeBox"/>
      <xsl:apply-templates select="timeBox"/>
      <xsl:apply-templates select="passwordBox"/>
	  <xsl:apply-templates select="hiddenBox"/>

      <xsl:apply-templates select="checkBox"/>
      <xsl:apply-templates select="mediaBox"/>
	  <xsl:apply-templates select="imageBox"/>
      <xsl:apply-templates select="autoSuggestBox"/>
      <xsl:apply-templates select="tokenBox"/>
      <xsl:apply-templates select="radio"/>
    </div>
  </xsl:template>
  <xsl:template match="hiddenBox">
    <input type="hidden" Value="{value}" data-type="hiddenBox" data-old="{value}" name="{../@fieldName}"
           id ="{../@fieldName}"/>
  </xsl:template>

  <xsl:template match="checkBox">
    <!--Supaya bisa di serialize-->
    <input type="hidden" name="{../@fieldName}" id="{../@fieldName}" value="{value}"/>
    <!--Supaya bisa di serialize-->

    <input type="checkbox" value="{value}" id ="cb{../@fieldName}"  name="cb{../@fieldName}" data-type="checkBox" data-old="{value}" data-child="Y"
      onchange="checkCB('{../@fieldName}');preview('{preview/.}', '{/sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}','form{/sqroot/body/bodyContent/form/info/code/.}', this);">
      <xsl:if test="value=1">
        <xsl:attribute name="checked">checked</xsl:attribute>
      </xsl:if>
      <xsl:choose>
        <xsl:when test ="../@isEditable=1 or (../@isEditable=2 and (/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))"></xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="disabled">disabled</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </input>

    <label id="{../@fieldName}caption" name="{../@fieldName}caption">
      <xsl:value-of select="titlecaption"/>
    </label>
    <xsl:if test="../@isNullable = 0">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>
    <label id="{../@fieldName}suffixCaption" name="{../@fieldName}suffixCaption">
      <xsl:value-of select="suffixCaption"/>
    </label>

  </xsl:template>

  <xsl:template match="textBox">
    <label id="{../@fieldName}caption" name="{../@fieldName}caption">
      <xsl:value-of select="titlecaption"/>
    </label>
    <xsl:if test="../@isNullable = 0">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>
    <!--digit-->
    <xsl:variable name="tbContent">
      <xsl:choose>
        <xsl:when test="digit = 0 and value!=''">
          <xsl:value-of select="format-number(value, '###,###,###,##0', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="digit  = 1 and value!=''">
          <xsl:value-of select="format-number(value, '###,###,###,##0.0', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="digit  = 2 and value!=''">
          <xsl:value-of select="format-number(value, '###,###,###,##0.00', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="digit  = 3 and value!=''">
          <xsl:value-of select="format-number(value, '###,###,###,##0.000', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="digit  = 4 and value!=''">
          <xsl:value-of select="format-number(value, '###,###,###,##0.0000', 'dot-dec')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="value"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="align">
      <xsl:choose>
        <xsl:when test="align=0">left</xsl:when>
        <xsl:when test="align=1">center</xsl:when>
        <xsl:when test="align=2">right</xsl:when>
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

    <input type="text" class="form-control" Value="{$thisvalue}" name="{../@fieldName}"
           data-old="{value/.}" data-child="Y"
           onblur="preview('{preview/.}', '{/sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}','form{/sqroot/body/bodyContent/form/info/code/.}', this);"
           oninput="javascript:checkChanges(this)"
           id ="{../@fieldName}">
      <xsl:attribute name="style">
        text-align:<xsl:value-of select="$align"/>
      </xsl:attribute>
    </input>
  </xsl:template>

  <xsl:template match="textEditor">
    <label id="{../@fieldName}caption" name="{../@fieldName}caption">
      <xsl:value-of select="titlecaption"/>
    </label>
    <xsl:if test="../@isNullable = 0">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>

    <textarea id ="{../@fieldName}" name ="{../@fieldName}" class="form-control" data-child="Y">
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
      $('#child_button_save').show();
      $('#child_button_addSave').show();
      $('#child_button_cancel').show();
      }
      preview('{preview/.}',getCode(), '{$cid}','formheader', this);
      });
    </script>
    <!--<script type="text/javascript">
      var oldval=$('#<xsl:value-of select="../@fieldName"/>').val();
      $('#<xsl:value-of select="../@fieldName"/>').data('old', oldval);
      <xsl:choose>
        <xsl:when test="skin='CKEditor'">
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
        </xsl:when>
        <xsl:otherwise>
          $('#<xsl:value-of select="../@fieldName"/>').on('blur', function() {
          preview('{preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','formheader', this);
          });
        </xsl:otherwise>
      </xsl:choose>
    </script>-->
  </xsl:template>

  <xsl:template match="textArea">
    <label id="{../@fieldName}caption">
      <xsl:value-of select="titlecaption"/>
    </label>
    <xsl:if test="../@isNullable = 0 and 
                    ((../@isEditable='1' and ($docState='' or $docState=0 or $docState=300 or $cid = '00000000-0000-0000-0000-000000000000' or $settingMode='C' or $settingMode='M')) 
                        or (../@isEditable='2' and $cid = '00000000-0000-0000-0000-000000000000')
                        or (../@isEditable='3' and ($docState&lt;400 or $cid = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='4' and ($docState&lt;500 or $cid = '00000000-0000-0000-0000-000000000000')))">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>

    <!--default value-->
    <xsl:variable name="thisValue">
      <xsl:choose>
        <xsl:when  test="$cid = '00000000-0000-0000-0000-000000000000' and defaultvalue != ''">
          <xsl:value-of select="defaultvalue/." />
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="value and value != ''">
              <xsl:value-of select="value"/>
            </xsl:when>
            <xsl:otherwise>&#160;</xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <textarea class="form-control" placeholder="input text..." name="{../@fieldName}" id ="{../@fieldName}" 
	  data-type="textArea" style="max-width:100%; min-width:100%; min-height:55px;" rows="10"
      onblur="preview('{preview/.}',getCode(), '{$cid}','', this);" oninput="javascript:checkChanges(this)" >
																																																						  
															   
			   
      <xsl:value-of select="$thisValue"/>
    </textarea>
    <script>
      $('#<xsl:value-of select="../@fieldName"/>').val($.trim($('#<xsl:value-of select="../@fieldName"/>').val()));
    </script>

  </xsl:template>

  <xsl:template match="dateBox">
    <label id="{../@fieldName}caption" name="{../@fieldName}caption">
      <xsl:value-of select="titlecaption"/>
    </label>
    <xsl:if test="../@isNullable = 0">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>
    <div class="input-group date">
      <div class="input-group-addon">
        <ix class="fa fa-calendar"></ix>
      </div>
      <input type="text" class="form-control pull-right datepicker" id ="{../@fieldName}" name="{../@fieldName}"
             data-type="dateBox" data-old="{value}" Value="{value}" data-child="Y"
             onblur="preview('{preview/.}','{/sqroot/body/bodyContent/form/code/id}', '{/sqroot/body/bodyContent/form/info/GUID/.}','form{/sqroot/body/bodyContent/form/code/id}', this);" >
					
																																									   
						 
																   
						  
					 
      </input>
    </div>
  </xsl:template>

  <xsl:template match="dateTimeBox">
    <label id="{../@fieldName}caption" name="{../@fieldName}caption">
      <xsl:value-of select="titlecaption"/>
    </label>
    <xsl:if test="../@isNullable = 0">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>
    <div class="input-group date">
      <div class="input-group-addon">
        <ix class="fa fa-calendar"></ix>
      </div>
      <input type="text" class="form-control pull-right datetimepicker" id ="{../@fieldName}" name="{../@fieldName}" Value="{value}" data-type="dateTimeBox" data-old="{value}"
        onblur="preview('{preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','formheader', this);" >
										
																 
				 
      </input>
    </div>
  </xsl:template>

  <xsl:template match="timeBox">
    <script>//timebox</script>
    <label id="{../@fieldName}caption" name="{../@fieldName}caption">
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
             data-type="timeBox" data-old="{value}" Value="{value}" data-child="Y"
             onblur="preview('{preview/.}','{/sqroot/body/bodyContent/form/code/id}', '{/sqroot/body/bodyContent/form/info/GUID/.}','form{/sqroot/body/bodyContent/form/code/id}', this);" >
					
																																									   
						 
																   
						  
					 
      </input>
    </div>
  </xsl:template>

  <xsl:template match="mediaBox">
    <label id="{../@fieldName}caption" name="{../@fieldName}caption">
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
          Browse <input id ="{../@fieldName}_hidden" name="{../@fieldName}_hidden" type="file" 
            data-code="{/sqroot/body/bodyContent/form/info/code}" data-child="Y" style="display: none;" multiple="" />
        </span>
      </label>
      <input id ="{../@fieldName}" name="{../@fieldName}" value="{value}" data-old="{value}" type="text" 
        class="form-control" style="width:400px" readonly="" />
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

  <xsl:template match="imageBox">
    <label id="{../@fieldName}caption" name="{../@fieldName}caption">
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
    <input id ="{../@fieldName}_hidden" name="{../@fieldName}_hidden" type="file" 
          data-code="{/sqroot/body/bodyContent/form/info/code}" data-child="Y" style="display: none;" multiple="" />
    <div class="input-group">
      <label class="input-group-btn">
        <span class="btn btn-secondary">
          Browse 
        </span>
      </label>
      <input id ="{../@fieldName}" name="{../@fieldName}" value="{value}" data-old="{value}" type="text" 
        class="form-control" style="width:400px" readonly="" />
      <span class="input-group-btn">
        <button class="btn btn-secondary" type="button" onclick="javascript:popTo('OPHcore/api/msg_download.aspx?fieldAttachment={../@fieldName}&#38;code={/sqroot/body/bodyContent/form/info/code/.}&#38;GUID={/sqroot/body/bodyContent/form/info/GUID/.}');">
          <xsl:if test="/sqroot/body/bodyContent/form/info/GUID='00000000-0000-0000-0000-000000000000'">
            <xsl:attribute name="disabled">disabled</xsl:attribute>
          </xsl:if>
          <ix class="fa fa-paperclip"></ix>&#160;
        </button>
      </span>
    </div>
    <style>
      #img_<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/> {
      border-radius: 5px;
      cursor: pointer;
      transition: 0.3s;
      }

      #myImg_<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>:hover {opacity: 0.7;}

      /* The Modal (background) */
      .modal {
      display: none; /* Hidden by default */
      position: fixed; /* Stay in place */
      z-index: 100; /* Sit on top */
      padding-top: 100px; /* Location of the box */
      left: 0;
      top: 0;
      width: 100%; /* Full width */
      height: 100%; /* Full height */
      overflow: auto; /* Enable scroll if needed */
      background-color: rgb(0,0,0); /* Fallback color */
      background-color: rgba(0,0,0,0.9); /* Black w/ opacity */
      margin-top:50px;
      }

      .modal-content {
      margin: auto;
      display: block;
      width: 80%;
      max-width: 700px;
      }

      #caption_<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/> {
      margin: auto;
      display: block;
      width: 80%;
      max-width: 700px;
      text-align: center;
      color: #ccc;
      padding: 10px 0;
      height: 150px;
      }

      .modal-content, #caption_<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/> {
      -webkit-animation-name: zoom;
      -webkit-animation-duration: 0.6s;
      animation-name: zoom;
      animation-duration: 0.6s;
      }

      @-webkit-keyframes zoom {
      from {-webkit-transform:scale(0)}
      to {-webkit-transform:scale(1)}
      }

      @keyframes zoom {
      from {transform:scale(0)}
      to {transform:scale(1)}
      }

      /* The Close Button */
      .close {
      position: absolute;
      top: 15px;
      right: 35px;
      color: white;
      font-size: 40px;
      font-weight: bold;
      transition: 0.3s;
      opacity:100;
      }

      .close:hover,
      .close:focus {
      color: #bbb;
      text-decoration: none;
      cursor: pointer;
      }

      @media only screen and (max-width: 700px){
      .modal-content {
      width: 100%;
      }
      }
    </style>
    <img id="img_{/sqroot/body/bodyContent/form/info/GUID/.}" onclick="popUpImg('{/sqroot/body/bodyContent/form/info/GUID/.}')" alt="{value}" src="OPHContent/documents/{/sqroot/header/info/suba}/{value}" style="margin-top:10px;width:100%;border:5px gray solid;"></img>
    <span style="color:blue;cursor:pointer;" onclick="popUpImg('{/sqroot/body/bodyContent/form/info/GUID/.}')">Click here to view the image.</span>
    <div id="myImage_{/sqroot/body/bodyContent/form/info/GUID/.}" class="modal">
      <span class="close" onclick="javascript:$('#myImage_{/sqroot/body/bodyContent/form/info/GUID/.}').hide();">X</span>
      <img class="modal-content" id="img01_{/sqroot/body/bodyContent/form/info/GUID/.}"/>
      <div id="caption_{/sqroot/body/bodyContent/form/info/GUID/.}"></div>
    </div>
  </xsl:template>

  <xsl:template match="autoSuggestBox">
    <label id="{../@fieldName}caption" name="{../@fieldName}caption">
      <xsl:value-of select="titlecaption"/>
    </label>
    <xsl:if test="../@isNullable = 0">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>
    <select class="form-control select2" style="width: 100%;" name="{../@fieldName}" id="{../@fieldName}" data-type="selectBox"
      data-old="{value/.}" data-oldText="{value/.}" data-value="{value/.}" data-child="Y"
        onchange="autosuggest_onchange(this, '{preview/.}', '{/sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}','form{/sqroot/body/bodyContent/form/info/code/.}', this);">
      <option></option>
    </select>

    <!--AutoSuggest Add New Form Modal-->
    <xsl:if test="(@allowAdd&gt;=1 or @allowEdit=1) and ../@isEditable=1">
      <div id="addNew{../@fieldName}" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
                <span aria-hidden="true">&#215;</span>
              </button>
              <div style="float:left;margin-top:-15px;">
                <h3>
                  <xsl:value-of select="titlecaption"/>
                </h3>
                <span>(Quick Add New Data Set)</span>
              </div>
              <div style="float:left">
                <a id="link{../@fieldName}" data-toggle="tooltip" data-placement="right" title="Click to see more detail" style="cursor:pointer;" onclick="">
                  <ix class="fa fa-external-link fa-2x"></ix>
                </a>
                <script>
                  $('#link<xsl:value-of select="../@fieldName"/>').click(function(){
                  var guid = (isGuid($('#<xsl:value-of select="../@fieldName"/>').val())) ? $('#<xsl:value-of select="../@fieldName"/>').val() : '00000000-0000-0000-0000-000000000000';
                  var url = '?code=<xsl:value-of select="@comboCode"/>&amp;guid=' + guid;
                  window.open(url);
                  });
                </script>
              </div>
            </div>
            <div class="modal-body">
              <div class="row" id="modalForm{../@fieldName}">
                &#160;
              </div>
            </div>
            <script>
              if ($('body').children('#addNew<xsl:value-of select="../@fieldName"/>').length == 1) {
              $('body').children('#addNew<xsl:value-of select="../@fieldName"/>').remove();
              }
              $('#addNew<xsl:value-of select="../@fieldName"/>').appendTo("body");
              $('#addNew<xsl:value-of select="../@fieldName"/>').on('show.bs.modal', function (event) {
              $('#<xsl:value-of select="../@fieldName"/>').select2('close');
              $('#modalForm<xsl:value-of select="../@fieldName"/>').append('<div class="col-md-12"></div>');
              $('#modalForm<xsl:value-of select="../@fieldName"/>').children('.col-md-12').append('<div style="float:left;"></div>');
              $('#modalForm<xsl:value-of select="../@fieldName"/>').children('.col-md-12').append('<div style="float:left; margin-left:10px;font-size:20px;">Please wait...</div>');
              $('#modalForm<xsl:value-of select="../@fieldName"/>').children('.col-md-12').children('div:first').append('<ix class="fa fa-spinner fa-pulse fa-2x fa-fw"></ix>');
              }).on('shown.bs.modal', function (event) {
              if (isGuid($('#<xsl:value-of select="../@fieldName"/>').val()) &amp;&amp; $(event.relatedTarget).data('action') == 'edit' ) {
              loadModalForm('modalForm<xsl:value-of select="../@fieldName"/>', '<xsl:value-of select="@comboCode"/>', $('#<xsl:value-of select="../@fieldName"/>').val());
              }
              else {
              loadModalForm('modalForm<xsl:value-of select="../@fieldName"/>', '<xsl:value-of select="@comboCode"/>', '00000000-0000-0000-0000-000000000000');
              }
              }).on('hide.bs.modal', function(event){
              $('#modalForm<xsl:value-of select="../@fieldName"/>').children('div').remove();
              $('#modalForm<xsl:value-of select="../@fieldName"/>').children('form').remove();
              $('#modalForm<xsl:value-of select="../@fieldName"/>').children('button').remove();
              $('#addNew<xsl:value-of select="../@fieldName"/> .modal-footer').children('button[id*="btn_save"]').remove();
              $('#modalForm<xsl:value-of select="../@fieldName"/>').text('&#160;');
              });
            </script>
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal" >Cancel</button>
            </div>
          </div>
        </div>
      </div>

      <xsl:if test="@allowAdd&gt;=1">
        <span class="select2-search select2-box--dropdown" id="select2-{../@fieldName}-addNew" style="display:none;">
          <ul class="select2-results__options" role="tree" aria-expanded="true" aria-hidden="false">
            <li class="select2-results__option" role="treeitem" aria-selected="false">
              <a data-toggle="modal" data-target="#addNew{../@fieldName}" data-backdrop="static" data-action="new">
                Add New <xsl:value-of select="titlecaption"/>
              </a>
            </li>
          </ul>
        </span>
        <script>
          $("#<xsl:value-of select="../@fieldName"/>").on("select2:open", function(e) {
          var s2id = $("span[class*='select2-dropdown select2-dropdown']").children('.select2-results').children().attr('id');
          s2id = s2id.split('select2-').join('').split('-results').join('');
          if (s2id == '<xsl:value-of select="../@fieldName"/>') {
          $('#select2-<xsl:value-of select="../@fieldName"/>-addNew').appendTo("span[class*='select2-dropdown select2-dropdown']").show();
          }
          });
        </script>
      </xsl:if>
      <xsl:if test="@allowEdit=1">
        <span id="editForm{../@fieldName}" data-toggle="modal" data-target="#addNew{../@fieldName}" data-backdrop="static" data-action="edit"

          style="cursor: pointer;margin: 8px 45px 0px 0px;position: absolute;top: 0px;right: 0px; display:none">
          <ix class="far fa-pencil-alt" title= "Edit" data-toggle="tooltip"></ix>
        </span>

        <script>
          $("#<xsl:value-of select="../@fieldName"/>").on("select2:select", function(e) {
          $selection = $('#select2-<xsl:value-of select="../@fieldName"/>-container').parents('.selection');
          if ($selection.children('#editForm<xsl:value-of select="../@fieldName"/>').length == 0)
          $('#editForm<xsl:value-of select="../@fieldName"/>').appendTo($selection);
          $('#editForm<xsl:value-of select="../@fieldName"/>').show();
          });
        </script>
      </xsl:if>
    </xsl:if>

    <xsl:if test="@allowEdit=1">
      <span id="removeForm{../@fieldName}" style="cursor: pointer;margin: 8px 30px 0px 0px;position: absolute;top: 0px;right: 0px; display:none">
        <ix class="far fa-times" title= "Remove Selection" data-toggle="tooltip" onclick="javascript: $('#{../@fieldName}').val(null).trigger('change');$('#editForm{../@fieldName}').hide();$('#removeForm{../@fieldName}').hide();"></ix>
      </span>
      <script>
        $("#<xsl:value-of select="../@fieldName"/>").on("select2:select", function(e) {
        $selection = $('#select2-<xsl:value-of select="../@fieldName"/>-container').parents('.selection');
        if ($selection.children('#removeForm<xsl:value-of select="../@fieldName"/>').length == 0)
        $('#removeForm<xsl:value-of select="../@fieldName"/>').appendTo($selection);
        $('#removeForm<xsl:value-of select="../@fieldName"/>').show();
        });
      </script>
    </xsl:if>

    <script>
      try {
      $("#<xsl:value-of select="../@fieldName"/>").select2({
      placeholder: 'Select <xsl:value-of select="titlecaption"/>',
      onAdd: function(x) {
      preview('<xsl:value-of select="preview/."/>', getCode(), '<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>','formheader', this);
      },
      onDelete: function(x) {
      preview('<xsl:value-of select="preview/."/>', getCode(), '<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>','formheader', this);
      },
      ajax: {

      url:"OPHCORE/api/msg_autosuggest.aspx",
      delay : 0,
      data: function (params) {
      var query = {
      code:"<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>",
      colkey:"<xsl:value-of select="../@fieldName"/>",
      search: params.term==undefined?'':params.term.toString().split('+').join('%2B'),
      wf1value: ('<xsl:value-of select='whereFields/wf1'/>'==='' || $("#<xsl:value-of select='whereFields/wf1'/>").val() === undefined ? "" : $("#<xsl:value-of select='whereFields/wf1'/>").val()),
      wf2value: ('<xsl:value-of select='whereFields/wf2'/>'==='' || $("#<xsl:value-of select='whereFields/wf2'/>").val() === undefined ? "" : $("#<xsl:value-of select='whereFields/wf2'/>").val()),
      parentCode: getCode(),
      page: params.page
      }
      return query;
      },
      dataType: 'json',
      }
      });
      }
      catch(err) {
      console.log(err.message);
      }
      <xsl:if test="value!=''">
        //deferreds.push(
        //autosuggest_setValue(deferreds, '<xsl:value-of select="../@fieldName"/>','<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>','<xsl:value-of select='../@fieldName'/>', '<xsl:value-of select='value'/>', '<xsl:value-of select='whereFields/wf1'/>', '<xsl:value-of select='whereFields/wf2'/>')
		autosuggest_defaultValue('<xsl:value-of select="../@fieldName"/>','<xsl:value-of select='value'/>','<xsl:value-of select='translate(combovalue, "&#39;", "\&#39;")'/>') 
        //);
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


    <label id="{../@fieldName}caption" name="{../@fieldName}caption">
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

    <input type="text" class="form-control" Value="{$thisvalue}" data-type="tokenBox" data-old="{$thisvalue}" data-newJSON="" data-code="{code/.}" data-child="Y"
      data-key="{key}" data-id="{id}" data-name="{name}"
      name="{../@fieldName}" id ="{../@fieldName}">

    </input>
  </xsl:template>

  <xsl:template match="radio">
    <xsl:variable name="radioVal">
      <xsl:choose>
        <xsl:when test="($cid) = '00000000-0000-0000-0000-000000000000'">
          <xsl:value-of select="defaultvalue" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="value" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <script>
      function <xsl:value-of select="../@fieldName" />_hide(shownId) {
      $('#accordion_<xsl:value-of select="../@fieldName" />').children().each(function(){
      if ($(this).hasClass('in') &#38;&#38; this.id!=shownId) {
      $(this).collapse('toggle');
      }
      });

      }
      <xsl:if test="$radioVal != ''">
        panel_display('<xsl:value-of select="../@fieldName"/>', '<xsl:value-of select="$radioVal"/>', true);
      </xsl:if>

    </script>
																						 
    <div>
      <label id="{../@fieldName}caption">
        <xsl:value-of select="titlecaption"/>
      </label>
		  
      <xsl:if test="../@isNullable = 0 and 
                    ((../@isEditable='1' and ($docState='' or $docState=0 or $docState=300 or $cid = '00000000-0000-0000-0000-000000000000')) 
                        or (../@isEditable='2' and $cid = '00000000-0000-0000-0000-000000000000')
                        or (../@isEditable='3' and ($docState&lt;400 or $cid = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='4' and ($docState&lt;500 or $cid = '00000000-0000-0000-0000-000000000000')))">
        <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
      </xsl:if>
    </div>
    <div class = "btn-group" data-toggle = "radios">
      <xsl:apply-templates select="radioSections/radioSection"/>
    </div>
    <xsl:if test="radioSections/radioSection/radioRows">
      <div class="panel-body" id="accordion_{../@fieldName}" style="box-shadow:none;border:none;display:block;">
        <xsl:for-each select="radioSections/radioSection">
          <!--<xsl:if test="radioSections/radioSection/radioRows/radioRow">-->
          <div id="panel_{../../../@fieldName}_{@radioNo}" class="box collapse" style="box-shadow:none;border:none;padding-bottom:0;padding-top:0;margin-bottom:0">
            <xsl:apply-templates select="radioRows/radioRow/fields" />
          </div>
          <!--</xsl:if>-->
        </xsl:for-each>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="radioSections/radioSection">
    <label class="radio-inline">
      <xsl:choose>
        <xsl:when test="@fieldName=../../value/.">
          <input type="radio" name="{../../../@fieldName}" id="{../../../@fieldName}_radio_{@radioNo}" value="{@fieldName}" checked="checked" />
          <script>
            $('#panel_<xsl:value-of select="../../../@fieldName" />_<xsl:value-of select="@radioNo" />').collapse('show');
          </script>
        </xsl:when>
        <xsl:otherwise>
          <input type="radio" name="{../../../@fieldName}" id="{../../../@fieldName}_radio_{@radioNo}" value="{@fieldName}" />
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
      <xsl:if test="../../../@isEditable=0">
        $('#<xsl:value-of select="../../../@fieldName" />_<xsl:value-of select="@radioNo" />').attr('disabled', true);
      </xsl:if>
    </script>
  </xsl:template>

  <xsl:template match="radioRow/fields">
    <xsl:apply-templates select="field" />
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/form/children">
    <div class="offser1">
      <xsl:apply-templates select="child"/>&#160;
    </div>
  </xsl:template>

  <xsl:template match="child">
    <input type="hidden" id="CPKID" value="gchild{code/.}"/>
    <input type="hidden" id="childKey{code/.}" value="{parentkey/.}"/>
    <input type="hidden" id="filter{code/.}" value="{parentkey/.}='{/sqroot/body/bodyContent/form/info/GUID/.}'"/>
    <input type="hidden" id="parent{code/.}" value="{parentkey/.}"/>
    <script>

      //xmldoc = "OPHCORE/api/default.aspx?code=<xsl:value-of select ="code/."/>&amp;mode=browse&amp;sqlFilter=<xsl:value-of select ="parentkey/."/>='<xsl:value-of select ="/sqroot/body/bodyContent/form/info/GUID/."/>'"
      //showXML('child<xsl:value-of select ="code/."/>', xmldoc, xsldoc + "_childBrowse.xslt", true, true, function () {});

      var code='<xsl:value-of select ="code/."/>';
      var parentKey='<xsl:value-of select ="parentkey/."/>';
      var GUID='<xsl:value-of select ="/sqroot/body/bodyContent/form/info/GUID/."/>';
      var browsemode='<xsl:value-of select ="browseMode/."/>';
      loadChild(code, parentKey, GUID, null, browsemode);
    </script>

    <!--div class="col-md-12">
      <div class="box" style="border-top:none;" id="section2">
        <div class="box-header with-border" style="background:none">
          <h3 class="dashboard-title">
            <xsl:value-of select="childTitle/."/>
          </h3>
        </div>
      </div-->
    <div class="box box-solid box-default visible-phone" style="box-shadow:0px;border:none;" id="child{code/.}{/sqroot/body/bodyContent/form/info/GUID/.}">
      &#160;
    </div>
    <!--/div-->
  </xsl:template>

</xsl:stylesheet>

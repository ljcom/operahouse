<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="abcdefghijklmnopqrstuvwxyz" />
  <xsl:variable name="uppercase" select="ABCDEFGHIJKLMNOPQRSTUVWXYZ" />
  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>
  <xsl:variable name="lowerCode"><xsl:value-of select="translate(/sqroot/body/bodyContent/form/info/code, $uppercase, $smallcase)"/></xsl:variable>
  <xsl:variable name="allowAdd" select="/sqroot/body/bodyContent/form/info/permission/allowAdd" />
  <xsl:variable name="allowEdit" select="/sqroot/body/bodyContent/form/info/permission/allowEdit" />
  <xsl:variable name="allowAccess" select="/sqroot/body/bodyContent/form/info/permission/allowAccess" />
  <xsl:variable name="allowForce" select="/sqroot/body/bodyContent/form/info/permission/allowForce" />
  <xsl:variable name="allowDelete" select="/sqroot/body/bodyContent/form/info/permission/allowDelete" />
  <xsl:variable name="allowWipe" select="/sqroot/body/bodyContent/form/info/permission/allowWipe" />
  <xsl:variable name="allowOnOff" select="/sqroot/body/bodyContent/form/info/permission/allowOnOff" />
  <xsl:variable name="settingMode" select="/sqroot/body/bodyContent/form/info/settingMode/." />
  <xsl:variable name="docState" select="/sqroot/body/bodyContent/form/info/state/status/."/>
  <xsl:variable name="isRequester" select="/sqroot/body/bodyContent/form/info/document/isRequester"/>
  <xsl:variable name="isApprover" select="/sqroot/body/bodyContent/form/info/document/isApprover"/>
  <xsl:variable name="cid" select="translate(/sqroot/body/bodyContent/form/info/GUID/., 'ABCDEF', 'abcdef')"/>

  <xsl:template match="/">
    <!-- Content Header (Page header) -->
    <script>
      //loadScript('OPHContent/cdn/daterangepicker/daterangepicker.js');
      //loadScript('OPHContent/cdn/select2/select2.full.min.js');

      form_init();
      //loadContent(0, true);
      var xmldoc = ""
      var xsldoc = "OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder"/>/xslt/" + getPage();

      <xsl:if test="/sqroot/body/bodyContent/form/info/GUID!='00000000-0000-0000-0000-000000000000'">
        $('#button_save').hide();
        $('#button_cancel').hide();
        $('#button_save2').hide();
        $('#button_cancel2').hide();
      </xsl:if>

      var deferreds = [];
      cell_defer(deferreds);

      $(function () {

        <!--//Date picker-->
        $('.datepicker').datepicker({autoclose: true});
        <!--//Date time picker-->
        


      
        });

        upload_init('<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>');

        <!--//iCheck for checkbox and radio inputs-->
        /*
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
        */
        <!--//Colorpicker--><!--
        $(".my-colorpicker1").colorpicker();
        --><!--//color picker with addon--><!--
        $(".my-colorpicker2").colorpicker();

        --><!--//Timepicker--><!--
        $(".timepicker").timepicker({
        showInputs: false
        });-->
      //});
      setCookie('<xsl:value-of select="translate(/sqroot/body/bodyContent/form/info/code/., $uppercase, $smallcase)"/>_curstateid', '<xsl:value-of select="$docState"/>');
	  </script>
    <script>
      function <xsl:value-of select="$lowerCode" />_save(location) {
        $('#button_save').button('loading');
        $('#button_save2').button('loading');
        $('#button_cancel').button('loading');
        $('#button_cancel2').button('loading');
        saveThemeONE('<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/." />','<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/." />', location, '', 
        (function(d) {<xsl:value-of select="$lowerCode" />_saveafter(d);
        $('#button_save').button('reset');
        $('#button_save2').button('reset');
        $('#button_cancel').button('reset');
        $('#button_cancel2').button('reset');

        }), (function(d) {<xsl:value-of select="$lowerCode" />_savebefore(d)}));
      }


      function <xsl:value-of select="$lowerCode" />_saveafter(d) {}
      function <xsl:value-of select="$lowerCode" />_savebefore(d) {}
      <xsl:if test="sqroot/body/bodyContent/form/info/buttons">
        buttons=<xsl:value-of select="sqroot/body/bodyContent/form/info/buttons"/>;
        loadExtraButton(buttons, 'form-action-button', 20);	
      </xsl:if>

      var docno='<xsl:value-of select="/sqroot/body/bodyContent/form/info/docNo/."/>';
      if (docno!='') $('#docNo').html(docno);
      var docrefno='<xsl:value-of select="/sqroot/body/bodyContent/form/info/refNo/."/>';
      if (docrefno!='') $('#docRefNo').html(docrefno);
      var docid='<xsl:value-of select="/sqroot/body/bodyContent/form/info/id/."/>';
      if (docid!='') $('#docId').html(docId);
      var docdate='<xsl:value-of select="/sqroot/body/bodyContent/form/info/docDate/."/>';
      if (docdate!='') $('#docDate').html(docdate);
      
        
    </script>

    <xsl:variable name="head">
      <xsl:choose>
        <xsl:when test="sqroot/body/bodyContent/form/info/GUID='00000000-0000-0000-0000-000000000000'">
          NEW
        </xsl:when>
        <xsl:when test="(($allowEdit>=1 or $allowAdd>=1 or $allowDelete>=1) and ($docState=0 or $docState=300))
							or (($allowEdit>=3 or $allowDelete>=3) and $docState&lt;=300)
							or (($allowEdit>=4 or $allowAdd>=4 or $allowDelete>=4) and $docState&lt;=400)">
          EDIT
        </xsl:when>
        <xsl:otherwise>
          VIEW
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>


    <section class="flat-row flat-contact-form style5">
      <div class="container">
        <!--header-->
        <!--<div class="row">
          <div class="col-md-12">
            <div class="flat-title">
              <h2 class="font-weight-3">
                <xsl:value-of select="sqroot/header/info/code/name/." />
              </h2>
            </div>
          </div>
        </div>-->
        
        
        <!--<div class="row">
          <div class="col-md-12">
            <h5 style="margin-bottom:30px; text-align:center;">
              Document Information
            </h5>
          </div>
          <div class="col-md-2">
            <span style="font-weight:bold">Document Number</span>
            <br/>
            INVC18F0007
          </div>
          <div class="col-md-2">
            <span style="font-weight:bold">Document Number</span>
            <br/>
            INVC18F0007
          </div>
          <div class="col-md-2">
            <span style="font-weight:bold">Document Number</span>
            <br/>
            INVC18F0007
          </div>
          <div class="col-md-2">
            <span style="font-weight:bold">Document Number</span>
            <br/>
            INVC18F0007
          </div>
        </div>-->
        <!--content-->
        <div class="row">
          <div class="form-contact-form style3 v2 two">
            <div class="formcontainer" style="font-size:14px; font-family:poppins; ">
              <div class="docinfo" style="width:20%; float:left;">
                <div style="background:#f7f7f7; padding:10px; border-radius:2px; margin-bottom:10px;">
                   <div style="font-size:16px;margin-bottom:20px;border-bottom:0px solid gray; padding:10px 0px 10px 0px;">
                    <h5 style="font-size:16px; margin-bottom:20px; border-bottom:2px solid gray; padding:10px 0px 10px 0px;">
                      Document Information
                    </h5>
                    <span>
                      <xsl:choose>
                        <xsl:when test="$settingMode='T'">
                          <div style="font-size:9pt;">
                            DOC NO: 
                          </div>
                          <div style="font-size:14pt;" id="docNo">
                            <xsl:value-of select="/sqroot/body/bodyContent/form/info/docNo/."/>&#160;
                          </div>                        
                          <div style="font-size:9pt;">
                            DOC REF NO: 
                          </div>
                          <div style="font-size:14pt;" id="docRefNo">
                            <xsl:value-of select="/sqroot/body/bodyContent/form/info/refNo/."/>&#160;
                          </div>
                          <div style="font-size:9pt;">
                            DOC DATE: 
                          </div>
                          <div style="font-size:14pt;" id="docDate">
                            <xsl:value-of select="/sqroot/body/bodyContent/form/info/docDate/."/>&#160;
                          </div>
                        </xsl:when>
                        <xsl:otherwise>
                          <div style="font-size:9pt;">
                            ID:
                          </div>
                          <div style="font-size:9pt;" id="docId">
                            <xsl:value-of select="/sqroot/body/bodyContent/form/info/id/."/>&#160;
                          </div>
                          <!--xsl:value-of select="/sqroot/body/bodyContent/form/info/id/."/-->
                        </xsl:otherwise>
                      </xsl:choose>
                    </span>
                  </div>

                  <xsl:apply-templates select="/sqroot/body/bodyContent/form/info"/>
                </div>
                <xsl:if test="/sqroot/body/bodyContent/form/approvals/approval">
                  <div style="background:#f7f7f7; padding:10px; border-radius:2px; margin-bottom:10px;">
                    <h5 style="font-size:16px; margin-bottom:20px; border-bottom:2px solid gray; padding:10px 0px 10px 0px;">
                      Approval List
                    </h5>
                    <xsl:apply-templates select="/sqroot/body/bodyContent/form/approvals"/>
                  </div>
                </xsl:if>
                <div style="background:#f7f7f7; padding:10px; border-radius:2px; margin-bottom:10px;">
                  <!-- search form -->
                  <script>
                    $("#searchBox").val(getSearchText());
                    var c=getQueryVariable('code').toLowerCase();
                    try {
                    $($('.treeview').children().find('a[href$="='+c+'"]')[0].parentNode.parentNode.parentNode.parentNode.parentNode).addClass('active');
                    $($('.treeview').children().find('a[href$="='+c+'"]')[0].parentNode.parentNode.parentNode).addClass('active');
                    $($('.treeview').children().find('a[href$="='+c+'"]')[0].parentNode).addClass('active');
                    } catch(e) {}
                  </script>                
                  <h5 style="font-size:16px; margin-bottom:20px; border-bottom:2px solid gray; padding:10px 0px 10px 0px;">
                    Search Documents
                  </h5>
                  <div class="input-group sidebar-form">
                    <input type="text" id="searchBox" name="searchBox" class="form-control" placeholder="Search..." 
                      style="border-top-left-radius:4px;border-bottom-left-radius:4px;max-width:130px"
                      onkeypress="return searchText(event, this.value, 20);" value="" />
                    <span class="input-group-btn">
                      <button type="button" name="search" id="search-btn" class="btn btn-flat" onclick="searchText(event, null, 20);">
                        <ix class="fa fa-search" aria-hidden="true"></ix>
                      </button>
                      <button type="button" name="draft" id="draft-btn" class="btn btn-flat" onclick="loadSearchResult('', 1);">
                        <ix class="fa fa-pen-square" aria-hidden="true"></ix>
                      </button>
                    </span>
                  </div>   
                  <li class="treeview hidden" id="tabSearchResult">
                    <a href="#">
                      <span>
                        <ix class="fa fa-search"></ix>
                      </span>
                      <span class="info">&#160;SEARCH RESULT</span>
                      <span class="pull-right-container">
                        <ix class="fa fa-angle-left pull-right"></ix>
                      </span>
                    </a>
                    <ul class="treeview-menu view-left-sidebar info">
                      <div class="direct-chat-messages" style="height:350px" id="searchResult">
                        <li>
                          <a class="info" href="#">
                            <span>
                              <ix class="fa fa-header"></ix>
                            </span >No results
                          </a>
                        </li>
                      </div>
                    </ul>
                  </li>                  
                </div>                   

                <xsl:if test="$settingMode!='C' and /sqroot/body/bodyContent/form/info/permission/ShowDocTalk/.=1">
                  <script>
                    setTimeout(function () { refreshTalk('<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID" />', '', 20); }, 1000 * 60);
                  </script>
                  <div style="background:#f7f7f7; padding:10px; border-radius:2px; margin-bottom:10px;">
                    <h5 style="font-size:16px; margin-bottom:20px; border-bottom:2px solid gray; padding:10px 0px 10px 0px;">
                      DOC TALK
                    </h5>
                    <!--xsl:apply-templates select="/sqroot/body/bodyContent/form/talks/talk"/-->
                    
                    <div id="chatMessages" class="direct-chat-messages">
                      <xsl:apply-templates select="/sqroot/body/bodyContent/form/talks/talk"/>
                      <script>
                        var d = $('.direct-chat-messages');
                        d.scrollTop(d.prop("scrollHeight"));
                      </script>
                      <!-- /.direct-chat-msg -->
                    </div>
                  
                  
                    <div class="input-group">
                      <input type="text" id="message" name="message" placeholder="Type Message ..." class="form-control" 
                        style="border-top-left-radius:4px;border-bottom-left-radius:4px;max-width:150px"
                        onkeypress="javascript:enterTalk('{@GUID}', event, '20')" autocomplete="off"/>
                      <span class="input-group-btn">
                        <button type="button" class="btn btn-primary btn-flat" onclick="javascript:submitTalk('{@GUID}', '20')">Send</button>
                      </span>
                    </div>
                  </div>
                </xsl:if>                
              </div>
              <div class="formcontent"  style="width:100%;">
                <xsl:apply-templates select="sqroot/body/bodyContent"/>
                <script>
                  $.when.apply($, deferreds).done(function() {
                  preview('1', getCode(), '<xsl:value-of select="$cid"/>','', this);
                  });
                </script>                
              </div>
              <div style="clear:both">&#160;</div>
            </div>
            
            <!--buttons-->
            <div class="row">
              <div class="col-md-2">
                &#160;
              </div>
              <div class="col-md-10 device-sm visible-sm device-md visible-md device-lg visible-lg" style="margin-bottom:50px;">
                <div class="" style="text-align:center">
                  <!--location: 0 header; 1 child; 2 browse location: browse:10, header form:20, browse anak:30, browse form:40-->
                  <xsl:choose>
                    <xsl:when test="($cid) = '00000000-0000-0000-0000-000000000000'">
                      <button id="button_save" class="flat-button-form border-radius-2" data-loading-text="SAVE (please wait...)" onclick="&#123;$lowerCode}_save(20,null,'',null, $(this));">
                        <xsl:value-of select="/sqroot/body/bodyContent/form/info/btnsavecaption"/> </button>&#160;
                      <button id="button_cancel" class="flat-button-form flat-btn-grey border-radius-2" data-loading-text="CANCEL" onclick="saveCancel()">CANCEL</button>&#160;
                    </xsl:when>
                    <xsl:when test="$docState = 0 or $docState = ''">
                      <button id="button_save" class="flat-button-form border-radius-2" data-loading-text="SAVE (please wait...)" onclick="&#123;$lowerCode}_save(20,null,'',null, $(this));">
                        <xsl:value-of select="/sqroot/body/bodyContent/form/info/btnsavecaption"/> </button>&#160;
                      <button id="button_cancel" class="flat-button-form flat-btn-grey border-radius-2" data-loading-text="CANCEL" onclick="saveCancel()">CANCEL</button>&#160;
                      <xsl:if test="($settingMode)='T' and ($docState) &lt; 400 ">
                        <button id="button_submit" class="flat-button-form border-radius-2" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}', 'execute', 1, 20)">SUBMIT</button>&#160;
                      </xsl:if>
                      <xsl:if test="(($allowDelete>=1) and ($docState=0 or $docState=300))
							                or (($allowDelete>=4) and ($docState&lt;100 or $docState&gt;=300))">
                        <button id="button_delete" class="flat-button-form flat-btn-grey border-radius-2" data-loading-text="DELETE (please wait...)" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}', 'delete', 1, 20,null,'',null, $(this));">DELETE</button>&#160;
                      </xsl:if>
                    </xsl:when>
                    <xsl:when test="($docState) &gt;= 100 and ($docState) &lt; 300">
                      <button id="button_save" class="flat-button-form border-radius-2" data-loading-text="SAVE (please wait...)" onclick="&#123;$lowerCode}_save(20,null,'',null, $(this));">
                        <xsl:value-of select="/sqroot/body/bodyContent/form/info/btnsavecaption"/> </button>&#160;
                      <button id="button_cancel" class="flat-button-form flat-btn-grey border-radius-2" data-loading-text="CANCEL" onclick="saveCancel()">CANCEL</button>&#160;
                      <xsl:if test="$isApprover=1">
                        <button id="button_approve" class="flat-button-form border-radius-2" data-loading-text="APPROVE (please wait...)" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{$cid}', 'execute', 1, 20,null,'',null, $(this));">APPROVE</button>&#160;
                        <button id="button_reject" class="flat-button-form border-radius-2" data-loading-text="REJECT (please wait...)" onclick="rejectPopup('{sqroot/body/bodyContent/form/info/code/.}', '{$cid}', 'force', 1, 20);">REJECT</button>&#160;
                      </xsl:if>
                    </xsl:when>

                    <xsl:when test="($docState) = 300">
                      <button id="button_save" class="flat-button-form border-radius-2" data-loading-text="SAVE (please wait...)" onclick="&#123;$lowerCode}_save(20,null,'',null, $(this));">
                        <xsl:value-of select="/sqroot/body/bodyContent/form/info/btnsavecaption"/> </button>&#160;
                      <xsl:if test="$isRequester=1">
                        <button id="button_submit" class="flat-button-form border-radius-2" data-loading-text="RE-SUBMIT (please wait...)" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{$cid}', 'execute', 1, 20,null,'',null, $(this));">RE-SUBMIT</button>&#160;
                      </xsl:if>
                      <button id="button_cancel" class="flat-button-form flat-btn-grey border-radius-2" data-loading-text="CANCEL" onclick="saveCancel()">CANCEL</button>&#160;&#160;

                    </xsl:when>
                    <xsl:when test="($docState) &gt;= 400 and ($docState) &lt;= 499">
                      <button id="button_save" class="flat-button-form border-radius-2" data-loading-text="SAVE (please wait...)" onclick="&#123;$lowerCode}_save(20,null,'',null, $(this));">
                        <xsl:value-of select="/sqroot/body/bodyContent/form/info/btnsavecaption"/> </button>&#160;
                      <button id="button_cancel" data-loading-text="CANCEL" class="flat-button-form flat-btn-grey border-radius-2" onclick="saveCancel()">CANCEL</button>&#160;
                      <xsl:if test="$allowForce=1">
                        <button id="button_close" class="flat-button-form border-radius-2" data-loading-text="CLOSE (please wait...)" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{$cid}', 'force', 1, 20,null,'',null, $(this));">CLOSE</button>&#160;
                      </xsl:if>
                    </xsl:when>
                    <xsl:when test="($docState) &gt;= 500 and ($docState) &lt;= 899">
                      <button id="button_reopen" class="flat-button-form border-radius-2" data-loading-text="REOPEN (please wait...)" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{$cid}', 'reopen', 1, 20,null,'',null, $(this));">REOPEN</button>&#160;                    
                    </xsl:when>
                    <xsl:otherwise>
                      &#160;
                    </xsl:otherwise>
                  </xsl:choose>
                </div>

              </div>
              <div class="col-md-12 displayblock-phone device-xs visible-xs" style="margin-bottom:20px;">
                <div style="text-align:center">
                  <xsl:choose>
                    <xsl:when test="($cid) = '00000000-0000-0000-0000-000000000000'">
                <button id="button_save2" data-loading-text="SAVE (please wait...)" class="flat-button-form border-radius-2" onclick="&#123;$lowerCode}_save(20,null,'',null, $(this));">
                  <xsl:value-of select="/sqroot/body/bodyContent/form/info/btnsavecaption"/> </button>&#160;
                <button id="button_cancel2" class="flat-button-form flat-btn-grey border-radius-2" data-loading-text="CANCEL" onclick="saveCancel()">CANCEL</button>&#160;
              </xsl:when>
              <xsl:when test="($docState) = 0 or ($docState) = ''">
                <button id="button_save2" data-loading-text="SAVE (please wait...)" class="flat-button-form border-radius-2" onclick="&#123;$lowerCode}_save(20,null,'',null, $(this));">
                  <xsl:value-of select="/sqroot/body/bodyContent/form/info/btnsavecaption"/> </button>&#160;
                <button id="button_cancel2" data-loading-text="CANCEL" class="flat-button-form flat-btn-grey border-radius-2" onclick="saveCancel()">CANCEL</button>&#160;
                <xsl:if test="($settingMode)='T' and ($docState) &lt; 400 ">
                  <button id="button_submit2" class="flat-button-form border-radius-2" data-loading-text="SUBMIT (please wait...)" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{$cid}', 'execute', 1, 20,null,'',null, $(this));">SUBMIT</button>&#160;
                </xsl:if>
              </xsl:when>
              <xsl:when test="($docState) &gt; 99 and ($docState) &lt; 199">
                <button id="button_save2" data-loading-text="SAVE (please wait...)" class="flat-button-form border-radius-2" onclick="&#123;$lowerCode}_save(20,null,'',null, $(this));">
                  <xsl:value-of select="/sqroot/body/bodyContent/form/info/btnsavecaption"/> </button>&#160;
                <button id="button_cancel2" class="flat-button-form flat-btn-grey border-radius-2" data-loading-text="CANCEL" onclick="saveCancel()">CANCEL</button>&#160;
                <button id="button_approve2" class="flat-button-form border-radius-2" data-loading-text="APPROVE (please wait...)" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{$cid}', 'execute', 1, 20,null,'',null, $(this));">APPROVE</button>&#160;
              </xsl:when>
              <xsl:when test="($docState) = 300">
                <button id="button_save2" data-loading-text="SAVE (please wait...)" class="flat-button-form border-radius-2" onclick="&#123;$lowerCode}_save(20,null,'',null, $(this));">
                  <xsl:value-of select="/sqroot/body/bodyContent/form/info/btnsavecaption"/> </button>&#160;
                <button id="button_cancel2" class="flat-button-form flat-btn-grey border-radius-2" data-loading-text="CANCEL" onclick="saveCancel()">CANCEL</button>&#160;
                <button id="button_reject2" class="flat-button-form border-radius-2" data-loading-text="REJECT (please wait...)">REJECT</button>&#160;
              </xsl:when>
              <xsl:when test="($docState) &gt;= 400 and ($docState) &lt;= 499">
                <button id="button_save2" data-loading-text="SAVE (please wait...)" class="flat-button-form border-radius-2" onclick="&#123;$lowerCode}_save(20,null,'',null, $(this));">
                  <xsl:value-of select="/sqroot/body/bodyContent/form/info/btnsavecaption"/> </button>&#160;
                <button id="button_cancel2" class="flat-button-form flat-btn-grey border-radius-2" data-loading-text="CANCEL" onclick="saveCancel()">CANCEL</button>&#160;
                <xsl:if test="$allowForce=1">
                  <button id="button_close2" class="flat-button-form border-radius-2" data-loading-text="CLOSE (please wait...)" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{$cid}', 'force', 1, 20,null,'',null, $(this));">CLOSE</button>&#160;
                </xsl:if>
                </xsl:when>
                    <xsl:otherwise>
                      &#160;
                    </xsl:otherwise>
                  </xsl:choose>
                </div>
              </div>
            </div>
            <!-- button view header -->

            <xsl:if test="sqroot/body/bodyContent/form/info/GUID !='00000000-0000-0000-0000-000000000000'">
              <xsl:apply-templates select="/sqroot/body/bodyContent/form/children"/>
            </xsl:if>
          </div>
        </div>
      <!--reject modal-->
      <div id="rejectModal" class="modal fade" role="dialog" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
          <!-- Modal content-->
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal">&#215;</button>
              <h4 class="modal-title" id="rejectTitle">Reject Reason</h4>
            </div>
            <div class="modal-body" id="rejectContent">
              <p>Please mention your reject reason: (required)</p>
              <textarea id="rejectComment" placeholder="Enter your reject reason." class="form-control">&#160;</textarea>
            </div>
            <div class="modal-footer">
              <button id="rejectBtn" type="button" class="btn btn-secondary" data-dismiss="modal" style="visibility:hidden">Reject</button>
              <button id="rejectCancelBtn" type="button" class="btn btn-primary btn-default" data-dismiss="modal">Cancel</button>
            </div>            
            </div>
          </div>
        </div>
      </div>
      <!-- /.content -->
      
    </section>
    <!-- /.flat-contact-simple -->
    
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent">
  <script>
      var code = "<xsl:value-of select="info/code/."/>";
      var tblnm =code+"requiredname";
    </script>

    <form role="form" id="formheader" enctype="multipart/form-data">
    
      <input type="hidden" id="cid" name="cid" value="{$cid}" />
      <input type="hidden" name ="{info/code/.}requiredname"/>
      <input type="hidden" name ="{info/code/.}requiredtblvalue"/>

      <xsl:apply-templates select="form"/>      
    </form>
    
  </xsl:template>

  <xsl:template match="form">
    <xsl:apply-templates select="formPages/formPage[@pageNo&lt;9]"/>
  </xsl:template>

  <xsl:template match="formPages/formPage[@pageNo&lt;9]">
    <xsl:apply-templates select="formSections"/>
  </xsl:template>
  



  <xsl:include href="_elements.xslt" />
  <xsl:include href="_form_sidebar.xslt" />



</xsl:stylesheet>

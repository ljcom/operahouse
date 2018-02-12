﻿<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
    <section class="mainContent clearfix stepsWrapper" >
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <div class="panel with-nav-tabs innerWrapper clearfix stepsPage">
              <div class="panel-heading"  style="border-bottom:0;">
                <ul class="nav nav-tabs" id="cart-tabs"  style="border-bottom:0;">
                  <div class="row progress-wizard" style="border-bottom:0; padding-bottom:20px;">
                    <div class="col-xs-6 progress-wizard-step disabled">
                      <div class="text-center progress-wizard-stepnum">Shipping Address</div>
                      <div class="progress">
                        <div class="progress-bar">a</div>
                      </div>
                      <a href="#tab1default" data-toggle="tab" class="progress-wizard-dot">|</a>
                    </div>
                    <div class="col-xs-6 progress-wizard-step disabled">
                      <div class="text-center progress-wizard-stepnum">Review</div>
                      <div class="progress">
                        <div class="progress-bar">a</div>
                      </div>
                      <a  href="#tab4default" data-toggle="tab" class="progress-wizard-dot">|</a>
                    </div>
                  </div>
                </ul>
              </div>
              <div class="panel-body">
                <div class="tab-content">
                  <div class="tab-pane fade in active" id="tab1default">
                    <form action="" class="row" method="POST" role="form">
                      <xsl:apply-templates select="sqroot/body/bodyContent/form/formPages/formPage" />
                      <div class="col-xs-12">
                        <div class="well well-lg clearfix">
                          <ul class="pager">
                            <li class="previous">
                              <a href="?code=tapcs1&amp;GUID={sqroot/body/bodyContent/form/info/GUID/.}">back</a>
                            </li>
                            <li class="next">
                              <a href="#tab4default"  data-toggle="tab"  onclick="#">Continue</a>
                            </li>
                          </ul>
                        </div>
                      </div>
                    </form>
                  </div>
                  <div class="tab-pane fade" id="tab4default">
                    <div class="col-xs-12">
                      <div class="page-header">
                        <h4>order review</h4>
                      </div>
                    </div>
                    <div class="col-sm-6 col-xs-12">
                      <div class="panel panel-default">
                        <div class="panel-heading">
                          <h4 class="panel-title">Shipping Address</h4>
                        </div>
                        <div class="panel-body">
                          <address>
                            <strong id="">
                              <xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage[@pageNo='1']/formSections/formSection[@sectionNo='1']/formCols/formCol[@colNo='1']/formRows/formRow[@rowNo='1']/fields/field/textBox/value/." />
                            </strong>
                            <br />
                            <span id="PCSO_CustomerAddress_browse">a</span>
                            <br />
                            <span id="PCSO_City_browse">b</span>
                            <br/>
                            <span id="PCSO_Country_browse">c</span>
                          </address>
                          <script>
                            document.getElementById("PCSO_CustomerAddress_browse").innerHTML = document.getElementById("PCSO_CustomerAddress").value
                            document.getElementById("PCSO_City_browse").innerHTML = document.getElementById("PCSO_City").value
                            document.getElementById("PCSO_Country_browse").innerHTML = document.getElementById("PCSO_Country").value
                          </script>
                        </div>
                      </div>
                    </div>
                    <div class="col-xs-12">
                      <div class="panel panel-default">
                        <div class="panel-heading">
                          <h4 class="panel-title">Order Details</h4>
                        </div>
                        <div class="panel-body">
                          <div class="row">
                            <div class="col-sm-4 col-xs-12">
                              <address>
                                <a href="#">
                                  Email:
                                  <span id="PCSO_personalEmail_browse">d</span>
                                </a> <br />
                                Phone : +<span id="PCSO_Phone_browse">e</span>
                              </address>
                            </div>
                            <div class="col-sm-8 col-xs-12">
                              <address>
                                <span>Additional Information: </span>
                                <br />
                                <p>For Additional Information</p>
                              </address>
                            </div>
                            <script>
                              document.getElementById("PCSO_personalEmail_browse").innerHTML = document.getElementById("PCSO_personalEmail").value
                              document.getElementById("PCSO_Phone_browse").innerHTML = document.getElementById("PCSO_Phone").value
                            </script>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="col-xs-12">
                      <div class="cartListInner">
                        <div class="table-responsive" id="contentcart">
                          <script>
                            var GUIDs = '<xsl:value-of select="sqroot/body/bodyContent/form/info/GUID/." />';
                            //var GUIDs = getCookie("cartID");
                            LoadNewPart('cart_browse_child2', 'contentcart', 'tapcs1deta', "PCSOGUID = '"+GUIDs+"'", '', 1, 200);
                          </script>
                        </div>
                        <div class="totalAmountArea">
                          <div class="col-sm-4 col-sm-offset-8 col-xs-12">
                            <ul class="list-unstyled">
                              <li>
                                Total (Include PPN) <span>
                                  Rp.  <xsl:value-of select="format-number(sqroot/body/bodyContent/form/formPages/formPage[@pageNo='1']/formSections/formSection/formCols/formCol[@colNo='5']/formRows/formRow[@rowNo='2']/fields/field/textBox/value/., '#,##0', 'dot-dec')" />
                                </span>
                              </li>
                            </ul>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="col-xs-12">
                      <div class="well well-lg clearfix">
                        <ul class="pager">
                          <form id="cartForm" method="POST">
                            <input type="hidden" value="{sqroot/body/bodyContent/form/info/GUID/.}" id="PCSOGUID" name="PCSOGUID"/>
                            <li class="previous">
                              <a  data-toggle="tab"  href="#tab1default">back</a>
                            </li>
                            <li class="next">
                              <a style="cursor:pointer;" onclick="SaveData('taPCS1','cartForm', 'index.aspx?code=tapcs3')">Confirm</a>
                            </li>
                          </form>
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>


  </xsl:template>


  <xsl:template match="sqroot/body/bodyContent/form/formPages/formPage">
    <xsl:if test="@pageNo = '1'">
      <xsl:apply-templates select="formSections/formSection" />
    </xsl:if>
  </xsl:template>

  <xsl:template match="formSections/formSection">
    <div class="col-xs-12">
      <div class="page-header">
        <h4>
          <xsl:value-of select="@rowTitle" />
        </h4>
      </div>
    </div>
    <div class="row">
      <div class="col-sm-12">
        <xsl:apply-templates select="formCols/formCol" />
      </div>
    </div>
  </xsl:template>

  <xsl:template match="formCols/formCol">
    <xsl:if test="@colNo = '1'">
      <div class="col-sm-6">
        <xsl:apply-templates select="formRows/formRow" />
      </div>
    </xsl:if>
    <xsl:if test="@colNo = '2'">
      <div class="col-sm-6">
        <xsl:apply-templates select="formRows/formRow" />
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="formRows/formRow">
    <div class="form-group  col-xs-12">
      <label>
        <xsl:value-of select="fields/field/textBox/titlecaption/." />
      </label>
      <input type="text" class="form-control" id="PCSO_{fields/field/@fieldName/.}" value="{fields/field/textBox/value/.}" readonly="" />
    </div>
  </xsl:template>
  <!--<xsl:template match="sqroot/body/bodyContent/form/formPages/formPage[@pageNo='1']/formSections/formSection[@sectionNo='1']/formCols/formCol[@colNo='1']/formRows/formRow">
     
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/form/formPages/formPage[@pageNo='3']/formSections/formSection[@sectionNo='1']/formCols/formCol[@colNo='1']/formRows/formRow">
     <div class="form-group col-sm-6 col-xs-12">
        <label><xsl:value-of select="fields/field/textBox/titlecaption/." /></label>
        <input type="text" class="form-control" id="{fields/field/@fieldName/.}" value="{fields/field/textBox/value/.}" />
      </div>
  </xsl:template>-->
</xsl:stylesheet>

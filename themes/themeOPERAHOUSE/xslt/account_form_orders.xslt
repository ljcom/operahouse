<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
    <div class="col-xs-12">
      <div class="innerWrapper singleOrder">
        <div class="orderBox">
          <h4>
            Order No :   <xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage[@pageNo='1']/formSections/formSection[@sectionNo='1']/formCols/formCol[@colNo='1']/formRows/formRow[@rowNo='1']/fields/field/textBox/value/." />
          </h4>
        </div>
        <div class="row">
          <div class="col-sm-6 col-xs-12">
            <div class="panel panel-default">
              <div class="panel-heading">
                <h4 class="panel-title">Shipping Address</h4>
              </div>
              <div class="panel-body">
                <address>
                  <strong id="">
                    <xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage[@pageNo='1']/formSections/formSection[@sectionNo='2']/formCols/formCol[@colNo='1']/formRows/formRow[@rowNo='1']/fields/field/textBox/value/." />
                  </strong>
                  <br />
                  <span id="PCSO_CustomerAddress_browse">
                    <xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage[@pageNo='1']/formSections/formSection[@sectionNo='2']/formCols/formCol[@colNo='1']/formRows/formRow[@rowNo='2']/fields/field/textBox/value/." />
                  </span>
                  <br />
                  <span id="PCSO_City_browse">
                    <xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage[@pageNo='1']/formSections/formSection[@sectionNo='2']/formCols/formCol[@colNo='1']/formRows/formRow[@rowNo='3']/fields/field/textBox/value/." />
                  </span>
                  <br/>
                  <span id="PCSO_Country_browse">
                    <xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage[@pageNo='1']/formSections/formSection[@sectionNo='2']/formCols/formCol[@colNo='1']/formRows/formRow[@rowNo='4']/fields/field/textBox/value/." />
                  </span>
                </address>
              </div>
            </div>
          </div>
          <div class="col-sm-6 col-xs-12">
            <div class="panel panel-default">
              <div class="panel-heading">
                <h4 class="panel-title">Payment Method</h4>
              </div>
              <div class="panel-body">
                <address>
                  <span>Deducted From Salary</span>
                </address>
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
                        <span id="PCSO_personalEmail_browse">
                          <xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage[@pageNo='1']/formSections/formSection[@sectionNo='3']/formCols/formCol[@colNo='1']/formRows/formRow[@rowNo='1']/fields/field/textBox/value/." />
                        </span>
                      </a> <br />
                      Phone : +<span id="PCSO_Phone_browse">

                        <xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage[@pageNo='1']/formSections/formSection[@sectionNo='3']/formCols/formCol[@colNo='1']/formRows/formRow[@rowNo='2']/fields/field/textBox/value/." />
                      </span>
                    </address>
                  </div>
                  <div class="col-sm-8 col-xs-12">
                    <address>
                      <span>Additional Information: </span>
                      <br />
                      <p>For Additional Information</p>
                    </address>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-xs-12" style="margin-bottom:20px;">
            <div class="cartListInner">
              <div class="table-responsive" id="orders">
                Loading Please Wait...
                <script>
                  var GUIDs = getQueryVariable("GUID");
                  //var GUIDs = getCookie("cartID");
                  LoadNewPart('account_form_orders_child', 'orders', 'tapcs3deta', "PCSOGUID = '"+GUIDs+"'", '');
                </script>
              </div>
              <div class="totalAmountArea">
                <div class="col-sm-4 col-sm-offset-8 col-xs-12">
                  <ul class="list-unstyled">
                    <li>
                      Sub Total <span>
                        Rp.  <xsl:value-of select="format-number(sqroot/body/bodyContent/form/formPages/formPage[@pageNo='1']/formSections/formSection[@sectionNo='4']/formCols/formCol[@colNo='1']/formRows/formRow[@rowNo='1']/fields/field/textBox/value/., '#,##0', 'dot-dec')" />
                      </span>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
          <!--<div class="col-xs-12">
            <div class="btn-group" role="group" aria-label="...">
              <button type="button" class="btn btn-default">Print</button>
              <button type="button" class="btn btn-default">Save to pdf</button>
              <button type="button" class="btn btn-default">cancel order</button>
            </div>
          </div>-->
        </div>
      </div>
    </div>
  </xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
    

    <!-- MAIN CONTENT SECTION -->
    <section class="mainContent clearfix stepsWrapper" >
      <div class="container">
        <div class="row">
          <div class="col-xs-12">
            <div class="innerWrapper clearfix stepsPage">
              <div class="row progress-wizard" style="border-bottom:0;">
                <div class="col-xs-3 progress-wizard-step complete fullBar">
                  <div class="text-center progress-wizard-stepnum">Billing &amp; Shipping Address</div>
                  <div class="progress"><div class="progress-bar">a</div></div>
                  <a href="#" onclick="ChangePages('', 'contentWrapper')" class="progress-wizard-dot">a</a>
                </div>
                <div class="col-xs-3 progress-wizard-step complete fullBar">
                  <div class="text-center progress-wizard-stepnum">Shipping Method</div>
                  <div class="progress"><div class="progress-bar">a</div></div>
                  <a href="#" onclick="ChangePages('_shiping', 'contentWrapper')" class="progress-wizard-dot">a</a>
                </div>
                <div class="col-xs-3 progress-wizard-step active">
                  <div class="text-center progress-wizard-stepnum">Payment Method</div>
                  <div class="progress"><div class="progress-bar">a</div></div>
                  <a href="#" onclick="ChangePages('_payment', 'contentWrapper')" class="progress-wizard-dot">a</a>
                </div>
                <div class="col-xs-3 progress-wizard-step disabled">
                  <div class="text-center progress-wizard-stepnum">Review</div>
                  <div class="progress"><div class="progress-bar">a</div></div>
                  <a  href="#" onclick="ChangePages('_review', 'contentWrapper')"  class="progress-wizard-dot">a</a>
                </div>
              </div>
              <form action="" class="row" method="POST" role="form">
                <div class="col-xs-12">
                  <div class="page-header">
                    <h4>Payment Information</h4>
                  </div>
                </div>
                <div class="form-group col-sm-4 col-xs-12">
                  <label for="">Payment By</label>
                  <span class="step-drop">
                    <select name="guiest_id3" id="guiest_id3" class="select-drop">
                      <option value="0">Deducted from Salary</option>
                      <option value="1">Credit Card</option>
                      <option value="2">Payment Gateway</option>
                    </select>
                  </span>
                </div>
                <div class="col-xs-12">
                  <div class="well well-lg clearfix">
                    <ul class="pager">
                      <li class="previous">
                        <a href="#" onclick="ChangePages('_shiping', 'contentWrapper')">back</a>
                      </li>
                      <li class="next">
                        <a href="#" onclick="ChangePages('_review', 'contentWrapper')">Continue</a>
                      </li>
                    </ul>
                  </div>
                </div>
              </form> 
            </div>
          </div>
        </div>
      </div>
    </section>
    
    
   

  </xsl:template>
  
</xsl:stylesheet>

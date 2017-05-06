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
                <div class="col-xs-3 progress-wizard-step complete">
                  <div class="text-center progress-wizard-stepnum">Billing &amp; Shipping Address</div>
                  <div class="progress"><div class="progress-bar">a</div></div>
                  <a href="#" onclick="ChangePages('', 'contentWrapper')" class="progress-wizard-dot">a</a>
                </div>
                <div class="col-xs-3 progress-wizard-step disabled">
                  <div class="text-center progress-wizard-stepnum">Shipping Method</div>
                  <div class="progress"><div class="progress-bar">a</div></div>
                  <a href="#" onclick="ChangePages('_shiping', 'contentWrapper')" class="progress-wizard-dot">a</a>
                </div>
                <div class="col-xs-3 progress-wizard-step disabled">
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
                    <h4>Billing information</h4>
                  </div>
                </div>
                <div class="form-group col-sm-6 col-xs-12">
                  <label for="">First Name</label>
                  <input type="text" class="form-control" id="" />
                </div>
                <div class="form-group col-sm-6 col-xs-12">
                  <label for="">Last Name</label>
                  <input type="text" class="form-control" id="" />
                  </div>
                <div class="form-group col-sm-6 col-xs-12">
                  <label for="">Email</label>
                  <input type="email" class="form-control" id="" />
                </div>
                <div class="form-group col-sm-6 col-xs-12">
                  <label for="">Company</label>
                  <input type="text" class="form-control" id="" />
                </div>
                <div class="form-group col-sm-6 col-xs-12">
                  <label for="">Address</label>
                  <input type="text" class="form-control" id="" />
                </div>
                <div class="form-group col-sm-6 col-xs-12">
                  <label for="">Phone</label>
                  <input type="text" class="form-control" id="" />
                </div>
                <div class="form-group col-sm-6 col-xs-12">
                  <label for="">City</label>
                  <input type="text" class="form-control" id="" />
                </div>
                <div class="form-group col-sm-6 col-xs-12">
                  <label for="">Zip Code</label>
                  <input type="text" class="form-control" id="" />
                </div>
                <div class="form-group col-sm-6 col-xs-12">
                  <label for="">Country</label>
                  <input type="text" class="form-control" id="" />
                </div>
                <div class="form-group col-sm-6 col-xs-12">
                  <label for="">Fax</label>
                  <input type="text" class="form-control" id="" />
                  </div>
                <div class="form-group col-sm-6 col-xs-12">
                  <label for="">First Name</label>
                  <textarea class="form-control">aad</textarea>
                </div>
                <div class="col-xs-12">
                  <div class="page-header">
                    <h4>Shipping information</h4>
                  </div>
                </div>
                <div class="col-xs-12 checkboxArea">
                  <input id="checkbox1" type="checkbox" name="checkbox" value="1" checked="checked" />
                  <label for="checkbox1">
                    <span>_</span>
                    Same as billing Information </label>
                </div>
                <div class="col-xs-12">
                  <div class="well well-lg clearfix">
                    <ul class="pager">
                      <li class="previous"><a href="#" class="hideContent">back</a></li>
                      <li class="next"><a href="#" onclick="ChangePages('_shiping', 'contentWrapper')">Continue</a></li>
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

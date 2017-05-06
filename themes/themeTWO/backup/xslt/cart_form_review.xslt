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
                <div class="col-xs-3 progress-wizard-step complete fullBar">
                  <div class="text-center progress-wizard-stepnum">Payment Method</div>
                  <div class="progress"><div class="progress-bar">a</div></div>
                  <a href="#" onclick="ChangePages('_payment', 'contentWrapper')" class="progress-wizard-dot">a</a>
                </div>
                <div class="col-xs-3 progress-wizard-step complete">
                  <div class="text-center progress-wizard-stepnum">Review</div>
                  <div class="progress"><div class="progress-bar">a</div></div>
                  <a  href="#" onclick="ChangePages('_review', 'contentWrapper')"  class="progress-wizard-dot">a</a>
                </div>
              </div>
              <form action="" class="row" method="POST" role="form">
                <div class="col-xs-12">
                  <div class="page-header">
                    <h4>order review</h4>
                  </div>
                </div>
                <div class="col-sm-6 col-xs-12">
                  <div class="panel panel-default">
                    <div class="panel-heading">
                      <h4 class="panel-title">Billing Address</h4>
                    </div>
                    <div class="panel-body">
                      <address>
                        <strong>Adam Smith</strong>
                        <br/>
                          9/4 C Babor Road, Mohammad pur, <br/>
                            Shyamoli, Dhaka <br/>
                        Bangladesh
                      </address>
                    </div>
                  </div>
                </div>
                <div class="col-sm-6 col-xs-12">
                  <div class="panel panel-default">
                    <div class="panel-heading">
                      <h4 class="panel-title">Shipping Address</h4>
                    </div>
                    <div class="panel-body">
                      <address>
                        <strong>Adam Smith</strong><br/>
                        9/4 C Babor Road, Mohammad pur, <br/>
                        Shyamoli, Dhaka <br/>
                        Bangladesh
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
                        <span>Credit Card - VISA</span>
                      </address>
                    </div>
                  </div>
                </div>
                <div class="col-sm-6 col-xs-12">
                  <div class="panel panel-default">
                    <div class="panel-heading">
                      <h4 class="panel-title">Shipping Method</h4>
                    </div>
                    <div class="panel-body">
                      <address>
                        <span>Post Air Mail</span>
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
                            <a href="#">Email: adamsmith@bigbag.com</a> <br/>
                            <span>Phone: +884 5452 6432</span>
                          </address>
                        </div>
                        <div class="col-sm-8 col-xs-12">
                          <address>
                            <span>Additional Information: </span><br/>
                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip</p>
                          </address>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-xs-12">
                  <div class="cartListInner">
                    <div class="table-responsive">
                      <table class="table">
                        <thead>
                          <tr>
                            <th></th>
                            <th>Product Name</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Sub Total</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                            <td class="col-xs-2">
                              <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">x</span></button>
                              <span class="cartImage"><img src="OPHContent/themes/themeTWO/images/product/eye/HYPERSHARP-WING-cart.jpg" alt="image" /></span>
                            </td>
                            <td class="col-xs-4">Hypersharp Wing</td>
                            <td class="col-xs-2">Rp. xxx.xxx</td>
                            <td class="col-xs-2"><input type="text" placeholder="1" /></td>
                            <td class="col-xs-2">Rp. xxx.xxx</td>
                          </tr>
                          <tr>
                          <td class="col-xs-2">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">x</span></button>
                            <span class="cartImage"><img src="OPHContent/themes/themeTWO/images/product/eye/lashsensa-cart.jpg" alt="image" /></span>
                          </td>
                          <td class="col-xs-4">Lash Sensational</td>
                          <td class="col-xs-2">Rp. xxx.xxx</td>
                          <td class="col-xs-2"><input type="text" placeholder="1" /></td>
                          <td class="col-xs-2">Rp. xxx.xxx</td>
                        </tr>
                        </tbody>
                      </table>
                    </div>
                    <div class="row totalAmountArea">
                      <div class="col-sm-4 col-sm-offset-8 col-xs-12">
                        <ul class="list-unstyled">
                          <li>Sub Total <span>Rp. xxx.xxx</span></li>
                          <li>UK Vat <span>Rp. xxx</span></li>
                          <li>Grand Total <span class="grandTotal">Rp. xxx.xxx</span></li>
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>
                 <div class="col-xs-12">
                  <div class="well well-lg clearfix">
                    <ul class="pager">
                    <li class="previous"><a href="#" onclick="ChangePages('_payment', 'contentWrapper')">Back</a></li>
                      <li class="next"><a href="#" onclick="ChangePages('_complete', 'contentWrapper')">Confirm</a></li>
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

<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
    

    <!-- MAIN CONTENT SECTION -->
    <section class="mainContent clearfix cartListWrapper" >
      <div class="container">
        <div class="row">
          <div class="col-xs-12">
            <div class="cartListInner">
              <form action="#">
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
                          <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">x</span>
                          </button>
                          <span class="cartImage">
                            <img src="OPHContent/themes/themeTWO/images/product/eye/HYPERSHARP-WING-cart.jpg" alt="image" />
                          </span>
                        </td>
                        <td class="col-xs-4">Hypersharp Wing</td>
                        <td class="col-xs-2">Rp. xxx.xxx</td>
                        <td class="col-xs-2">
                          <input type="text" placeholder="1" />
                        </td>
                        <td class="col-xs-2">Rp. xxx.xxx</td>
                      </tr>
                      <tr>
                        <td class="col-xs-2">
                          <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">x</span>
                          </button>
                          <span class="cartImage">
                            <img src="OPHContent/themes/themeTWO/images/product/eye/lashsensa-cart.jpg" alt="image" />
                          </span>
                        </td>
                        <td class="col-xs-4">Lash Sensational</td>
                        <td class="col-xs-2">Rp. xxx.xxx</td>
                        <td class="col-xs-2">
                          <input type="text" placeholder="1" />
                        </td>
                        <td class="col-xs-2">Rp. xxx.xxx</td>
                      </tr>
                    </tbody>
                  </table>
                </div>
                <div class="updateArea">
                  <div class="input-group">
                    <input type="text" class="form-control" placeholder="I have a discount coupon" aria-describedby="basic-addon2" />
                      <a href="#" class="btn input-group-addon" id="basic-addon2">apply coupon</a>
                    </div>
                  <a href="#" class="btn">update cart</a>
                </div>
                
                <div class="totalAmountArea">
                  <div class="col-sm-4 col-sm-offset-8 col-xs-12">
                    <ul class="list-unstyled">
                      <li>Sub Total <span>Rp. xxx.xxx</span></li>
                      <li>UK Vat <span>Rp. xxx</span></li>
                      <li>Grand Total <span class="grandTotal">Rp. xxx.xxx</span></li>
                    </ul>
                  </div>
                </div>
                <div class="checkBtnArea">
                  <a href="checkout-step-1.html" class="btn btn-primary btn-block">checkout<ix class="fa fa-arrow-circle-right" aria-hidden="true"></ix></a>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </section>
    
    
   

  </xsl:template>
  
</xsl:stylesheet>

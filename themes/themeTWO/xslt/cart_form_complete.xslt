<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
    

    <!-- MAIN CONTENT SECTION -->
    <section class="mainContent clearfix setp5" >
      <div class="container">
        <div class="row">
          <div class="col-xs-12">
            <div class="thanksContent">
                <h2>Thank You For Your Order <small>You will receive an email of your order details</small></h2>
                <h3>Shipping Details</h3>
                <div class="thanksInner">
                  <div class="row">
                    <div class="col-sm-6 col-xs-12 tableBlcok">
                      <address>
                        <span>Shipping address:</span> <a href="mailto:adamsmith@bigbag.com">adamsmith@bigbag.com</a> <br/>
                        <span>Email:</span> <a href="mailto:adamsmith@bigbag.com">adamsmith@bigbag.com</a> <br/>
                        <span>Phone:</span> +884 5452 6432
                      </address>
                    </div>
                    <div class="col-sm-6 col-xs-12">
                      <div class="well">
                        <h2><small>Order ID</small>9547</h2>
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
  
</xsl:stylesheet>

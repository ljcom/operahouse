<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
    <div class="col-xs-12">
      <div class="innerWrapper">
        <div class="orderBox myAddress wishList">
          <h4>Wishlist</h4>
          <div class="table-responsive">
            <table class="table">
              <thead>
                <tr>
                  <th></th>
                  <th>Product Name</th>
                  <th>Unit Price</th>
                  <th>Stock Status</th>
                  <th></th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td class="col-md-2 col-sm-3">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true"></span></button>
                    <span class="cartImage"><img src="OPHContent/themes/themeTWO/images/product/eye/HYPERSHARP-WING-cart.jpg" alt="image" /></span>
                  </td>
                  <td>Hypersharp Wing</td>
                  <td>Rp. xxx.xxx</td>
                  <td>In Stock</td>
                  <td>
                    <a class="btn btn-default" href="#">Add to Cart</a>
                  </td>
                </tr>
                <tr>
                  <td class="col-md-2 col-sm-3">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true"></span></button>
                    <span class="cartImage"><img src="OPHContent/themes/themeTWO/images/product/eye/lashsensa-cart.jpg" alt="image" /></span>
                  </td>
                  <td>Lash Sensational</td>
                  <td>Rp. xxx.xxx</td>
                  <td>In Stock</td>
                  <td>
                    <a class="btn btn-default" href="#">Add to Cart</a>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>
  
</xsl:stylesheet>

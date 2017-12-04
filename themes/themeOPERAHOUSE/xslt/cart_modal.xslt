<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:template match="/">
    <script>
      loadScript('OPHContent/themes/themeOne/scripts/select2/select2.full.min.js');

      var deferreds = [];
    </script>
    <xsl:apply-templates select="sqroot/body/bodyContent"/>

  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">
          <i class="zmdi zmdi-close"></i>
        </span>
      </button>
      <h3 class="modal-title">
        <!--<xsl:value-of select ="/sqroot/header/info/code/name/."/>-->
        <i class="fa fa-shopping-cart" aria-hidden="true"></i> Your Cart
      </h3>
    </div>
    <div class="modal-body" style="padding:20px 5px;">
      <div class="bs-example">
        <div class="table-responsive">
          <div class="card">
            <table class="table  table-striped">
              <thead>
                <tr>
                  <xsl:apply-templates select="/sqroot/body/bodyContent/browse/header/column"/>
                  <!--<th>Action</th>-->
                </tr>
              </thead>
              <tbody>
                <xsl:apply-templates select="/sqroot/body/bodyContent/browse/content/row"/>
                <tr>
                  <td colspan="3" align="right">
                    <strong>
                    <xsl:value-of select ="/sqroot/body/bodyContent/browse/header/column[@fieldName='Subtotal']/."/>
                    </strong>
                  </td>
                  <td>
                    <xsl:value-of select ="/sqroot/body/bodyContent/browse/content/row/fields/field[@caption='Subtotal']/."/>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        <!-- /.table-responsive -->
      </div>
     
        
    </div>
    <div class="col-md-12" id="modalalert" style="display:none;">
      <div class="alert alert-primary alert-dismissible">
        <button type="button" class="close" onclick="$('#modalalert').hide()">
          <i class="zmdi zmdi-close"></i>
        </button>
        <div id="modalalertmsg">Message</div>
      </div>
    </div>
    <div class="modal-footer" id="notiModalFooter">
      <button type="button" class="btn btn-primary btn-raised" onclick="window.location.href='index.aspx?code=orders'">Shopping Cart</button>
      <button type="button" class="btn btn-primary btn-raised" data-dismiss="modal" onclick=" $('#notiModal').hide()">Close</button>
    </div>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/header/column">
    <xsl:if test="(@fieldName)!='Subtotal'">
      <th>      
        <xsl:value-of select ="titleCaption/."/>
      </th>
    </xsl:if>
  </xsl:template>


  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
    <tr>
      <xsl:apply-templates select="fields/field"/>
      
    </tr>
  </xsl:template>


  <xsl:template match="fields/field">
    <xsl:if test="(@caption)!='Subtotal'">
      <td>
        <xsl:value-of select ="."/>
      </td>
    </xsl:if>
  </xsl:template>


</xsl:stylesheet>

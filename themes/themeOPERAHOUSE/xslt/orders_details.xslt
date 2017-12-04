<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:template match="/">
   
    <!--<div class="container mt-4">-->
      <!--<h2 class="color-primary text-center"> <xsl:value-of select ="/sqroot/header/info/code/name/."/></h2>-->
      <!--<p class="lead text-center center-block mb-4 mw-800">Suscipit placeat dolor iste, amet libero quidem aliquam expedita dicta repellendus ut modi sed mollitia dolorem tempore obcaecati incidunt est asperiores.</p>-->
    <div class="card card-default animated fadeInUp animation-delay-7">
      <div class="card-header" style="background:#EFE9F4">
        <i class="fa fa-shopping-cart" aria-hidden="true"></i>
        <xsl:value-of select ="/sqroot/header/info/code/name/."/>
      </div>
      <div class="card-block">
        <div class="bs-example">
          <div class="table-responsive">
            <div class="card">
              <table class="table table-bordered table-striped">
                <thead>
                  <tr>
                    <xsl:apply-templates select="sqroot/body/bodyContent/browse/header/column"/>
                    <th>Action</th>
                  </tr>
                </thead>
                <tbody>
                  <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row"/>
                </tbody>
              </table>
            </div>
          </div>
          <!-- /.table-responsive -->
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/header/column">
    <th>
      <xsl:value-of select ="titleCaption/."/>
    </th>
  </xsl:template>


  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
    <tr>
      <xsl:apply-templates select="fields/field"/>
      <td>
        <a href="javascript:void(0)" onclick="LoadNewPartView('orders_details_modal', 'childmodalcontent', 'ordersdetails', '{@GUID}')" class="btn-circle btn-circle-default " data-toggle="modal" data-target="#childmodal">
          <i class="fa fa-pencil"></i>
        </a>
        <a href="javascript:void(0)" class="btn-circle btn-circle-default" data-toggle="tooltip" data-placement="bottom" title="Delete">
          <i class="fa fa-close"></i>
        </a>
      </td>
    </tr>
  </xsl:template>


  <xsl:template match="fields/field">
    <td>
      <xsl:value-of select ="."/>
    </td>
  </xsl:template>



</xsl:stylesheet>

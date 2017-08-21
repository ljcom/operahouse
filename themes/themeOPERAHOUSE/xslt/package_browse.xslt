<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:template match="/">
    <script>
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/assets/js/app.min.js');

      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/assets/js/ecommerce.js');
    </script>
    <div class="ms-hero-page ms-hero-img-city2 ms-hero-bg-info mb-6">
      <div class="text-center color-white mt-6 mb-6 index-1">
        <h1>Operahouse Systems</h1>
        <p class="lead lead-lg">
          Welcome to the Operahouse. Discover the latest products at incredible prices.
          <br/> Don't forget to check our daily offers.</p>
        <a href="javascript:void(0)" class="btn btn-raised btn-white color-danger">
          <i class="zmdi zmdi-label"></i> Latest offers
        </a>
      </div>
    </div>

    <div class="container">
      <div class="row">
        <div class="col-md-3">
          <div class="card card-primary">
            <div class="card-header">
              <h3 class="card-title">Filter List</h3>
            </div>
            <div class="card-block">
              <form class="form-horizontal" id="Filters">
                <h4 class="mb-1 no-mt">Category</h4>
                <fieldset>
                  <div class="form-group no-mt">
                    <div class="checkbox ml-2">
                      <label>
                        <input type="checkbox" value=".humanresource" /> Human Resources </label>
                    </div>
                    <div class="checkbox  ml-2">
                      <label>
                        <input type="checkbox" value=".Finance"/> Finance </label>
                    </div>
                    <!--<div class="checkbox  ml-2">
                      <label>
                        <input type="checkbox" value=".laptop"/> Laptops </label>
                    </div>
                    <div class="checkbox  ml-2">
                      <label>
                        <input type="checkbox" value=".accessory"/> Accesories </label>
                    </div>-->
                  </div>
                </fieldset>
                <button class="btn btn-danger btn-block no-mb mt-2" id="Reset">
                  <i class="zmdi zmdi-delete"></i> Clear Filters
                </button>
              </form>
              <form class="form-horizontal">
                <h4>Sort by</h4>
                <select id="SortSelect" class="form-control">
                  <option value="random">Popular</option>
                  <option value="price:asc">Price ASC</option>
                  <option value="price:desc">Price DESC</option>
                  <option value="date:asc">Release ASC</option>
                  <option value="date:desc">Release DESC</option>
                </select>
              </form>
            </div>
          </div>
        </div>
        <div class="col-md-9">
          <div class="row" id="Container">
            <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row"/>
            
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
    <div class="col-lg-4 col-md-6 col-xs-12 mix {fields/field[@caption = 'PaclageClassTag']/.} apple" data-price="1999.99" data-date="20160901">
      <div class="card ms-feature">
        <div class="card-block text-center">
          <a href="ecommerce-item.html">
            <img src="{fields/field[@caption = 'PackagePrimaryImg']/.}" alt="" class="img-responsive center-block" />
          </a>
          <xsl:apply-templates select="fields/field"/>
          
          <!--<div class="mt-2">
            <span class="mr-2">
              <i class="zmdi zmdi-star color-warning"></i>
              <i class="zmdi zmdi-star color-warning"></i>
              <i class="zmdi zmdi-star color-warning"></i>
              <i class="zmdi zmdi-star color-warning"></i>
              <i class="zmdi zmdi-star"></i>
            </span>
            <span class="ms-tag ms-tag-success">$ 1999.99</span>
          </div>-->
          <a href="index.aspx?code={@code}&amp;GUID={@GUID}" class="btn btn-primary btn-sm btn-block btn-raised mt-2 no-mb">
             See Details
          </a>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="fields/field">
    <xsl:choose>
      <xsl:when test="@caption = 'packageName'">
        <h4 class="text-normal text-center">
          <xsl:value-of select ="."/>
        </h4>
      </xsl:when>
      <xsl:when test="@caption = 'packageDescription'">
        <p>
          <xsl:value-of select ="."/>
        </p>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>

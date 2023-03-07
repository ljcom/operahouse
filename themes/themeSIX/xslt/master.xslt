<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" >

  <xsl:template match="/">
    <script>
      var codexx = '<xsl:value-of select="/sqroot/header/info/code/id"/>'
      var usrGUIDs = '<xsl:value-of select="/sqroot/header/info/user/userGUID"/>'

      if (codexx == 'userprof' &amp;&amp; usrGUIDs != getGUID()){
	      window.location = 'index.aspx?code=error';
      }
     
      resetBrowseCookies(1);
      setCookie(getCode().toLowerCase()+'_showdocinfo', '<xsl:value-of select="/sqroot/header/info/code/ShowDocInfo" />',7);
      loadContent(1);
    </script>
    <xsl:apply-templates select="sqroot" />

  </xsl:template>

	
	<xsl:template match="/sqroot/header">

      <section class="page-title parallax" style="background-image: url('{/sqroot/header/tag/image/.}'); ">
        <div class="title-heading">
          <div class="container">
            <div class="row">
              <div class="col-md-12">
                <div class="box-title style1">
                  <h2 style="margin-bottom:10px;">
                    <xsl:value-of select="info/title/." />
                  </h2>
                  <p style="font-size:25px; letter-spacing: 3px; ">
                    <xsl:value-of select="code/titleTag/." />
                  </p>
                  <div class="breadcrumbs">
                    <ul>
                      <li>
                        <a href="index.html" title="">Home</a>
                        <i class="fa fa-angle-right" aria-hidden="true"></i>
                      </li>
                      <li>
                        <a href="element.html" title="">Transactions</a>
                        <i class="fa fa-angle-right" aria-hidden="true"></i>
                      </li>
                      <li>
                        <a href="#" title=""><xsl:value-of select="/sqroot/header/info/title" /></a>
                      </li>
                    </ul>
                  </div>
                  <!-- /.breadcrumbs -->
                </div>
                <!-- /.box-title -->
              </div>
              <!-- /.col-md-12 -->
            </div>
            <!-- /.row -->
          </div>
          <!-- /.container -->
        </div>
        <!-- /.title-heading -->
        <div class="overlay-black"></div>
      </section>
      <!-- /.page-title parallax -->
		

	</xsl:template>
  <xsl:template match="/sqroot/body">
    <section class="flat-row flat-contact-form style5">
      <div class="container" style="text-align:center">
        <i class="fa fa-spinner fa-spin fa fa-fw">&#xA0;</i>
        <br/>
        Loading Please Wait...
      </div>
    </section>  
  </xsl:template>

  <xsl:include href="_base.xslt" />
</xsl:stylesheet>
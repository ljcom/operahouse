<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">

    <!-- Content Header (Page header) -->
    <section class="content-header visible-phone">
      <h1>
        Profile
        <!-- <small>Control panel</small> -->
      </h1>
    </section>
    <section class="content">
      <div class="row">
        <div class="col-md-12">
          <div>
            <h4>Biodata</h4>
          </div>
        </div>
      </div>

      <div class="row">
        <div class="col-md-2">
          <div class="profilebox">
            <img style="width:100%" src="OPHContent/themes/{/sqroot/header/info/themeFolder}/images/doc-talk-icon2.png" />
            
          </div>
        </div>
        <div class="col-md-10">
          <div class="profilebox">
            <p>
              <span>User ID</span> : <xsl:value-of select="sqroot/header/info/user/userId"/>
            </p>
            <p>
              <span>Username</span> : <xsl:value-of select="sqroot/header/info/user/userName"/>
            </p>
            <p>
              <span>E-mail</span> :  <xsl:value-of select="sqroot/header/info/user/email"/>
            </p>
            <p>
              <span>Division</span> :  <xsl:value-of select="sqroot/header/info/user/division"/>
            </p>
          </div>
        </div>
      </div>

      <div style="margin-bottom:20px; color:white">a</div>
      <div class="row">
        <div class="col-md-12">
          <div>
            <h4>Set Delegation</h4>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12">
          <div class="profilebox">
            <p>a</p>
            <p>b</p>
            <p>c</p>
            <p>d</p>
          </div>
        </div>
      </div>

    </section>
  </xsl:template>




</xsl:stylesheet>

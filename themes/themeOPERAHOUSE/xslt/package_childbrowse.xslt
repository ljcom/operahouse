﻿<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:template match="/">

    
    <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row[@code = 'packagesection']"/>
    <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row[@code = 'packagerelated']"/>
   
  </xsl:template>

  <!--package section-->
  <xsl:template match="sqroot/body/bodyContent/browse/content/row[@code = 'packagesection']">
    <xsl:if test="(fields/field[@caption = 'sectionAlign']/.)='1 - Right'">
      <section class="wrap mt-6 wow fadeInRight animation-delay-4" style="padding:0">
        <div class="container">
          <div class="panel-body">
            <div class="tab-content mt-4">
              <div class="row">
                <div class="col-md-6 col-lg-5 col-md-push-6 col-lg-push-7">
                  <ul class="list-unstyled hand-list">
                    <li class="animated fadeInLeft animation-delay-2 ">
                      <xsl:apply-templates select="fields/field[@caption != 'sectionImg']"/>
                    </li>
                  </ul>
                </div>
                <div class="col-md-6 col-lg-7 col-md-pull-6 col-lg-pull-5">
                  <xsl:apply-templates select="fields/field[@caption = 'sectionImg']"/>

                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </xsl:if>
    <xsl:if test="(fields/field[@caption = 'sectionAlign']/.)='2 - Left'">
      <section class="wrap mt-6 wow fadeInLeft animation-delay-4" style="padding:0">
        <div class="container" >
          <div class="panel-body">
            <div class="tab-content mt-4">
              <div class="row">
                <div class="col-md-6 col-lg-7 col-md-push-6 col-lg-push-5">
                  <xsl:apply-templates select="fields/field[@caption = 'sectionImg']"/>
                </div>
                <div class="col-md-6 col-lg-5 col-md-pull-6 col-lg-pull-7">
                  <ul class="list-unstyled hand-list">
                    <li class="animated fadeInLeft animation-delay-2">
                      <xsl:apply-templates select="fields/field[@caption != 'sectionImg']"/>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </xsl:if>
    <xsl:if test="(fields/field[@caption = 'sectionAlign']/.)='3 - Center'">
      <section class="wrap mt-6 wow fadeInUp animation-delay-4" style="padding:0">
        <div class="container mt-6 text-center">
          <xsl:apply-templates select="fields/field[@caption != 'sectionImg']"/>
          <div class="row">
            <div class="col-lg-1 col-md-1 col-sm-1">
              &#xA0;
            </div>
            <div class="col-lg-10 col-md-10 col-sm-10">
              <div style="text-align:center ">
                <xsl:apply-templates select="fields/field[@caption = 'sectionImg']"/>
              </div>

            </div>
            <div class="col-lg-1 col-md-1 col-sm-1">
              &#xA0;
            </div>
          </div>
        </div>
      </section>
    </xsl:if>
    
  </xsl:template>


  <xsl:template match="sqroot/body/bodyContent/browse/content/row[@code = 'packagesection']/fields/field">
    <xsl:choose>
      <xsl:when test="@caption = 'sectionTitle'">
          <h2 class="no-mt color-primary no-mb"><xsl:value-of select ="."/></h2>
      </xsl:when>
      <xsl:when test="@caption = 'sectionDescription'">
        <p>
          <xsl:value-of select ="."/>
        </p>
      </xsl:when>
      <xsl:when test="@caption = 'sectionText'">
        <p style="color:#938f8f; text-align:justify">
          <xsl:value-of select ="."/>
        </p>
      </xsl:when>
    
    </xsl:choose>
  </xsl:template>


  <xsl:template match="sqroot/body/bodyContent/browse/content/row[@code = 'packagesection']/fields/field[@caption = 'sectionImg']">
    <img class="img-responsive animated zoomInDown animation-delay-3" src="{.}" style="display:inline;" />
  </xsl:template>
 <!--tutup pacakage section-->


  <xsl:template match="sqroot/body/bodyContent/browse/content/row[@code = 'packagerelated']">
    <div class="container mt-6">
      <h2 class="text-center color-primary mb-2 wow fadeInDown animation-delay-4">Fully integrated with Operahouse Apps</h2>
      
      <div class="row">
        <div class="col-lg-3 col-md-6 col-sm-6">
          <div class="card wow fadeInLeft animation-delay-4 " style="border-top:3px {fields/field[@caption = 'IconColor']/.} solid; border-bottom:3px {fields/field[@caption = 'IconColor']/.} solid;">
            <div class="text-center card-block">
              <span class="ms-icon ms-icon-circle ms-icon-white ms-icon-inverse ms-icon-xxlg " style="background:{fields/field[@caption = 'IconColor']/.};">
                <xsl:apply-templates select="fields/field[@caption = 'Icon']"/>              
              </span>
              <xsl:apply-templates select="fields/field[@caption != 'Icon' and @caption != 'IconColor']"/>
             
              <a href="{fields/field[@caption = 'Link']/.}" class="btn btn-white btn-raised" style="color:{fields/field[@caption = 'IconColor']/.};">Discover</a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/content/row[@code = 'packagerelated']/fields/field">
    <xsl:choose>
      <xsl:when test="@caption = 'PackageGUID'">
        <h4 class="">
          <xsl:value-of select ="."/>
        </h4>
      </xsl:when>
      <xsl:when test="@caption = 'Description'">
        <p class="">
          <xsl:value-of select ="."/>
        </p>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/content/row[@code = 'packagerelated']/fields/field[@caption = 'Icon']">
    <i class="zmdi {.}"></i>
  </xsl:template>
  
  
</xsl:stylesheet>

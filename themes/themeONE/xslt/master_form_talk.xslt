<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">

  <xsl:output method="xml" indent="yes"/>
  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
    <xsl:apply-templates select="sqroot/body/bodyContent/form/talks/talk"/>
    <script>
      var d = $('.direct-chat-messages');
      d.scrollTop(d.prop("scrollHeight"));
    </script>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/form/talks/talk">
    <xsl:variable name="chatRight">
      <xsl:if test="@itsMe=1">right</xsl:if>
    </xsl:variable>
    <div class="direct-chat-msg {$chatRight}">
      <div class="direct-chat-info clearfix">
        <span class="direct-chat-name pull-right">
          <xsl:value-of select="@talkUser"/>
        </span>
        <span class="direct-chat-timestamp pull-left" title="{@talkDate}">
          <xsl:value-of select="@talkDateCaption"/>
        </span>
      </div>
      <!-- /.direct-chat-info -->
      <img class="direct-chat-img" src="OPHContent/documents/{/sqroot/body/info/account}/{@talkUserProfile}" alt="{talkUser}"/>
      <!-- /.direct-chat-img -->
      <div class="direct-chat-text">
        <xsl:value-of select="@comment"/>
      </div>
      <!-- /.direct-chat-text -->
    </div>
  </xsl:template>
</xsl:stylesheet>
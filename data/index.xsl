<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
    <html>
      <head>
        <title><xsl:value-of select="*/*[1]"/></title>
      </head>
      <body>
        <h1>Outline:</h1>
        <xsl:for-each select="*//subsection">
          <xsl:variable name="subadd">../<xsl:value-of select="count(../preceding-sibling::section)+1"/>.<xsl:value-of select="count(preceding-sibling::subsection)+1"/>.html</xsl:variable>
          <a href="{$subadd}"><h2><xsl:value-of select="*[1]"/></h2></a>
        </xsl:for-each>
        <xsl:for-each select="*//lesson ">
          <xsl:variable name="lessadd">../<xsl:value-of select="count(../../preceding-sibling::section)+1"/>.<xsl:value-of select="count(../preceding-sibling::subsection)+1"/>.<xsl:value-of select="count(preceding-sibling::lesson)+1"/>.html</xsl:variable>
          <a href="{$lessadd}"><h3><xsl:value-of select="*[1]"/></h3></a>
        </xsl:for-each>
        <xsl:for-each select="*//unit">
          <xsl:variable name="unadd">../<xsl:value-of select="count(../../../preceding-sibling::section)+1"/>.<xsl:value-of select="count(../../preceding-sibling::subsection)+1"/>.<xsl:value-of select="count(../preceding-sibling::lesson) +1"/>.<xsl:value-of select="count(preceding-sibling::unit)+1"/>.html</xsl:variable>
          <a href="{$unadd}"><h4><xsl:value-of select="*[1]"/></h4></a>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
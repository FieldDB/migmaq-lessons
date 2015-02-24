<?xml version="1.0" encoding="UTF-8"?>
<!--This transformation creates an index of children subsections, lessons, and units. It applies to the current node and lists any children up to the unit level. It gives links to their webpages.-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/"><!--Match current node-->
    <html><!--Start html file-->
      <head>
        <title><xsl:value-of select="*/*[1]"/></title><!--Title is first text node-->
      </head>
      <body>
        <h1>Outline:</h1><!--Outline is just a list of child node titles and links to their pages-->
        <xsl:for-each select="unit|*//unit"><!--Find all unit children-->
          <xsl:variable name="unadd">../<xsl:value-of select="count(../../../preceding-sibling::section)+1"/>.<xsl:value-of select="count(../../preceding-sibling::unit)+1"/>.html</xsl:variable><!--Create filename for unit child webpage-->
          <a href="{$unadd}"><h2><xsl:value-of select="*[1]"/></h2></a><!--List unit titles as links to their webpages-->
        <xsl:for-each select="lesson|*//lesson"><!--Find all lesson children-->
          <xsl:variable name="lessadd">../<xsl:value-of select="count(../../preceding-sibling::section)+1"/>.<xsl:value-of select="count(../preceding-sibling::unit)+1"/>.<xsl:value-of select="count(preceding-sibling::lesson)+1"/>.html</xsl:variable><!--Create filename for lesson child webpage-->
          <a href="{$lessadd}"><h3><xsl:value-of select="*[1]"/></h3></a><!--List lesson titles as links to their webpages-->
        </xsl:for-each>
        </xsl:for-each>        
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
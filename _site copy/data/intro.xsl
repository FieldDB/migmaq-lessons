<?xml version="1.0" encoding="UTF-8"?>
<!--This transformation creates an intro page for the lessons. It displays the intro text and an index showing all child sections, subsections, lessons, and units. It applies to the lessonset node. The index displays the name of each subsection as a link to the relevant webpage.-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/lessonset"><!--Match on lessonset-->
    <html><!--Start html file-->
      <head>
        <title><xsl:value-of select="*"/></title><!--Title is lessonset title-->
      </head>
      <body>
        <h1><xsl:value-of select="*[2]/*[1]"/></h1><!--Title of intro node-->
        <p>
          <xsl:value-of select="*[2]/*[2]"/><!--Text of intro node-->
        </p>
        <h1>Outline:</h1><!--Outline is just a list of child node titles and links to their pages-->
        <xsl:for-each select="section"><!--Find all section children-->
          <xsl:variable name="secadd">../<xsl:value-of select="count(../preceding-sibling::section)+1"/>.html</xsl:variable><!--Create filename for section child webpage-->
          <a href="{$secadd}"><h1><xsl:value-of select="*[1]"/></h1></a><!--List section titles as links to their webpages-->
        </xsl:for-each>
        <xsl:for-each select="*//subsection"><!--Find all subsection children-->
          <xsl:variable name="subadd">../<xsl:value-of select="count(../preceding-sibling::section)+1"/>.<xsl:value-of select="count(preceding-sibling::subsection)+1"/>.html</xsl:variable><!--Create filename for subsection child webpage-->
          <a href="{$subadd}"><h2><xsl:value-of select="*[1]"/></h2></a><!--List subsection titles as links to their webpages-->
        </xsl:for-each>
        <xsl:for-each select="*//lesson "><!--Find all lesson children-->
          <xsl:variable name="lessadd">../<xsl:value-of select="count(../../preceding-sibling::section)+1"/>.<xsl:value-of select="count(../preceding-sibling::subsection)+1"/>.<xsl:value-of select="count(preceding-sibling::lesson)+1"/>.html</xsl:variable><!--Create filename for lesson child webpage-->
          <a href="{$lessadd}"><h3><xsl:value-of select="*[1]"/></h3></a><!--List lesson titles as links to their webpages-->
        </xsl:for-each>
        <xsl:for-each select="*//unit"><!--Find all unit children-->
          <xsl:variable name="unadd">../<xsl:value-of select="count(../../../preceding-sibling::section)+1"/>.<xsl:value-of select="count(../../preceding-sibling::subsection)+1"/>.<xsl:value-of select="count(../preceding-sibling::lesson) +1"/>.<xsl:value-of select="count(preceding-sibling::unit)+1"/>.html</xsl:variable><!--Create filename for unit child webpage-->
          <a href="{$unadd}"><h4><xsl:value-of select="*[1]"/></h4></a><!--List unit titles as links to their webpages-->
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
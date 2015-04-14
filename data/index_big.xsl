<?xml version="1.0" encoding="UTF-8"?>
<!--This transformation creates an index of children sections, lessons, and units. It applies to the current node and lists any children up to the unit level. It gives links to their webpages.-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/"><!--Match current node-->
    <h1 class="title"><xsl:value-of select="*//title"/></h1>
    <div class="row">
      <div class="col-md-8">   
        <xsl:if test="*//note">
          <p>
            <xsl:value-of select="*//note"/><!--Display any notes about the lesson-->
          </p>
        </xsl:if>
      </div>
      <div class="col-md-4">
        <xsl:if test="/img">
          <xsl:variable name="imgurl"><xsl:value-of select="img"/></xsl:variable>
          <img class="img-responsive thumbnail" src="{$imgurl}" alt="Trees" style="max-width: 75%"></img>
        </xsl:if>
      </div>
    </div>
    <div class="row">
      <div class="col-md-10"> 
        <h2>Outline:</h2><!--Outline is just a list of child node titles and links to their pages-->
        <xsl:for-each select="unit|*//unit"><!--Find all unit children-->
          <xsl:variable name="unadd">../<xsl:value-of select="count(../../../preceding-sibling::section)+1"/>.<xsl:value-of select="count(../../preceding-sibling::unit)+1"/>.html</xsl:variable><!--Create filename for unit child webpage-->
          <a href="{$unadd}"><h3><xsl:value-of select="*[1]"/></h3></a><!--List unit titles as links to their webpages-->
          <xsl:for-each select="lesson|*//lesson"><!--Find all lesson children-->
            <xsl:variable name="lessadd">../<xsl:value-of select="count(../../preceding-sibling::section)+1"/>.<xsl:value-of select="count(../preceding-sibling::unit)+1"/>.<xsl:value-of select="count(preceding-sibling::lesson)+1"/>.html</xsl:variable><!--Create filename for lesson child webpage-->
            <a href="{$lessadd}"><h4><xsl:value-of select="*[1]"/></h4></a><!--List lesson titles as links to their webpages-->
          </xsl:for-each>
        </xsl:for-each>
      </div>
    </div>
  </xsl:template>
</xsl:stylesheet>
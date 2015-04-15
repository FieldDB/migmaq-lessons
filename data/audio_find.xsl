<?xml version="1.0" encoding="UTF-8"?>
<!--This transformation creates a webpage for a unit. It matches on a given unit node and displays the unit title, img, intro, and all dialogs or vocabs included in the unit.-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="section">
    <h1 class="title">
      Section <xsl:value-of select="title"/>
    </h1>
    <xsl:for-each select="unit">
      <h2 class="title">
        Unit <xsl:value-of select="title"/>
      </h2>
      <xsl:for-each select="lesson">
        <h3 class="title">
          Lesson <xsl:value-of select="title"/>
        </h3>
        <xsl:for-each select="dialog">
          <h4 class="title">
            Dialog <xsl:value-of select="count(preceding-sibling::dialog)+1"/>
          </h4>
          <xsl:for-each select="line">
            <xsl:choose>
              <xsl:when test="soundfile">
              </xsl:when>
              <xsl:otherwise>
                <p>Missing: Line <xsl:value-of select="count(preceding-sibling::line)+1"/>: <xsl:value-of select="migmaq"/></p>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </xsl:for-each>
        <xsl:for-each select="vocab">
          <h4 class="title">
            Vocab <xsl:value-of select="count(preceding-sibling::vocab)+1"/>
          </h4>
          <xsl:for-each select="line">
            <xsl:choose>
              <xsl:when test="soundfile">
              </xsl:when>
              <xsl:otherwise>
                <p>Missing: Line <xsl:value-of select="count(preceding-sibling::line)+1"/>: <xsl:value-of select="migmaq"/></p>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </xsl:for-each>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>

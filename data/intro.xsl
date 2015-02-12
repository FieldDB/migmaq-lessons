<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/lessonset">
    <HTML>
      <HEAD>
        <TITLE><xsl:value-of select="*"/></TITLE>
      </HEAD>
      <BODY>
        <h1><xsl:value-of select="*[2]/*[1]"/></h1>
        <p>
          <xsl:value-of select="*[2]/*[2]"/>
        </p>
        <h1>Outline:</h1>
        <xsl:for-each select="*[3]">
          <h2><xsl:value-of select="*[1]"/></h2>
          <xsl:for-each select="*[2]">
            <h3><xsl:value-of select="*[1]"/></h3>
            <xsl:for-each select="*[2]">
              <h4><xsl:value-of select="*[1]"/></h4>
              <xsl:for-each select="*[2]">
                <h5><xsl:value-of select="*[1]"/></h5>
              </xsl:for-each>
            </xsl:for-each>
          </xsl:for-each>
        </xsl:for-each>
      </BODY>
    </HTML>
  </xsl:template>
</xsl:stylesheet>
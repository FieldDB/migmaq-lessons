<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/unit">
    <HTML>
      <HEAD>
        <TITLE><xsl:value-of select="unittitle"/></TITLE>
      </HEAD>
      <BODY>
        <P><xsl:value-of select="unitintro"/></P>
      </BODY>
    </HTML>
  </xsl:template>
</xsl:stylesheet>

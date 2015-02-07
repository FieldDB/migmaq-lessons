<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/unit">
    <HTML>
      <HEAD>
        <TITLE><xsl:value-of select="unittitle"/></TITLE>
      </HEAD>
      <BODY>
      	<h1><xsl:value-of select="unittitle"/></h1>
        <img class="img-responsive thumbnail" src="../img/wikiimage.png" alt="Trees" style="max-width: 75%"></img>
        <P><xsl:value-of select="unitintro"/></P>
        <xsl:for-each select="dialog">
        	<p>
        		<xsl:for-each select="line">
        			<h2><xsl:value-of select="migmaq"/></h2>  
        			<h2><xsl:value-of select="english"/></h2>
        		</xsl:for-each>    		
        	</p>  	
        </xsl:for-each>
        <p>
        	<xsl:value-of select="info"/>
        </p>
      </BODY>
    </HTML>
  </xsl:template>
</xsl:stylesheet>

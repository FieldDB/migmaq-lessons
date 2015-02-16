<?xml version="1.0" encoding="UTF-8"?>
<!--This transformation creates a webpage for a unit. It matches on a given unit node and displays the unit title, img, intro, and all dialogs included in the unit.-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/unit"><!--Match on current unit node-->
    <html><!--Start html file-->
      <head>
        <title><xsl:value-of select="unittitle"/></title><!--Title is unit title-->
      </head>
      <body>
      	<h1><xsl:value-of select="unittitle"/></h1><!--Display unit title at top of page-->
        <img class="img-responsive thumbnail" src="../img/wikiimage.png" alt="Trees" style="max-width: 75%"></img><!--Display unit img-->
        <p><xsl:value-of select="unitintro"/></p><!--Display unit intro as a paragraph-->
        <xsl:for-each select="dialog"><!--Iterate through all child dialogs-->
        	<p>
            <xsl:for-each select="line"><!--Iterate through all the lines in each dialog-->
        			<h2><xsl:value-of select="migmaq"/></h2><!--Display Mi'gmaq-->
        			<h2><xsl:value-of select="english"/></h2><!--Display English-->
        		</xsl:for-each>    		
        	</p>  	
        </xsl:for-each>
        <p>
          <xsl:value-of select="info"/><!--Display any info associated with the unit-->
        </p>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<!--This transformation creates a webpage for a unit. It matches on a given unit node and displays the unit title, img, intro, and all dialogs included in the unit.-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/lesson"><!--Match on current unit node-->
    <html><!--Start html file-->
      <head>
        <title><xsl:value-of select="title"/></title><!--Title is unit title-->
      </head>
      <body>
        <div class="container">
      	<h1><xsl:value-of select="title"/></h1><!--Display unit title at top of page-->
        <img class="img-responsive thumbnail" src="../img/wikiimage.png" alt="Trees" style="max-width: 75%"></img><!--Display unit img-->
        <p><xsl:value-of select="designnote"/></p><!--Display design note as a paragraph-->
        <xsl:for-each select="dialog"><!--Iterate through all child dialogs-->
          <xsl:for-each select="line"><!--Iterate through all the lines in each dialog-->
            <div class="media">
              <div class="media-left">
                <embed class="media-object" src="soundfile/{.}.wav" autostart="no" height="12"></embed>
                <!--Make a media object with the audio file-->
              </div>
              <div class="media-body">
                <h2 class="media-heading"><xsl:value-of select="migmaq"/></h2><!--Display Mi'gmaq-->
                <h4 class="media-heading"><xsl:value-of select="english"/></h4><!--Display English-->
              </div>
            </div>
          </xsl:for-each>
        </xsl:for-each>
        <p>
          <xsl:value-of select="info"/><!--Display any info associated with the unit-->
        </p>
      </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<!--This transformation creates a webpage for a dialog. It matches on a given dialog node and displays the title, img, and lines of the dialog.-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:param name="index" />
  <xsl:template match="/vocab"><!--Match on current unit node-->
    <h1>
      Vocab <xsl:value-of select="$index"/>
    </h1><!--Display unit title at top of page-->
    <div class="well well-lg">
      <xsl:for-each select="line">
        <div class="media"><!--Make a media object with the audio file-->
          <div class="media-left">
            <!--<embed class="media-object" src="soundfile/{.}.wav" autostart="no" height="12"></embed>-->sound1
          </div>
          <div class="media-body">
            <h2 class="media-heading">
              <xsl:value-of select="migmaq"/>
            </h2><!--Display Mi'gmaq-->
            <h4 class="media-heading">
              <xsl:value-of select="english"/>
            </h4><!--Display English-->            
          </div>
        </div>
      </xsl:for-each>
    </div>
  </xsl:template>
</xsl:stylesheet>

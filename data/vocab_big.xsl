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
        <xsl:variable name="soundurl">{{ site.baseurl }}/audio/<xsl:value-of select="soundfile"/>.mp3</xsl:variable>
        <div class="media"><!--Make a media object with the audio file-->
          <div class="media-left">
            <button class="btn btn-default" type="button">
              <span class="glyphicon glyphicon-play" aria-hidden="true">
                <audio>
                  <source src="{$soundurl}" type="audio/mpeg"/>
                </audio>
              </span>
            </button>
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

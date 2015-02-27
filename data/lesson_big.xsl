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
         <div id="carousel" class="carousel slide" data-ride="carousel">
          <ol class="carousel-indicators">
         <xsl:for-each select="dialog">
          
            <!-- Indicators -->
            <xsl:variable name="d">
                <xsl:value-of select="count(preceding-sibling::dialog)"/>
              </xsl:variable>
            <xsl:for-each select="line">
              <!--<li data-target="#carousel" data-slide-to="0" class="active"></li>-->
              <xsl:variable name="l">
                <xsl:value-of select="count(preceding-sibling::line)"/>
              </xsl:variable>
              <!--<xsl:choose>-->
              <!--<xsl:if test="{$num}='1'">-->
              <li data-target="#carousel" data-slide-to="{$l}" class="active"></li>
              <!--</xsl:if>
              <xsl:otherwise>
                  <li data-target="#carousel" data-slide-to="{$num}"></li>
                </xsl:otherwise>-->
              <!--</xsl:choose>-->
            </xsl:for-each>
          </xsl:for-each>
            </ol>
            <div class="carousel-inner" role="listbox"><!--Iterate through all the lines in each dialog-->
              <xsl:for-each select="dialog">
              <xsl:for-each select="line"><!--Iterate through all child dialogs-->
                <div class="item active carousel-caption caption-read">
                  <div class="media"><!--Make a media object with the audio file-->
                    <div class="media-left">
                      <embed class="media-object" src="soundfile/{.}.wav" autostart="no" height="12"></embed>
                    </div>
                    <div class="media-body">
                      <h2 class="media-heading"><xsl:value-of select="migmaq"/></h2><!--Display Mi'gmaq-->
                      <h4 class="media-heading"><xsl:value-of select="english"/></h4><!--Display English-->
                    </div>
                  </div>
                </div>
              </xsl:for-each>
            </xsl:for-each>
            </div>
            <!-- Controls -->
  <a class="left carousel-control" href="#carousel" role="button" data-slide="prev">
    <span class="glyphicon glyphicon-leaf"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="right carousel-control" href="#carousel" role="button" data-slide="next">
    <span class="glyphicon glyphicon-leaf"></span>
    <span class="sr-only">Next</span>
  </a>
          </div>
        <p>
          <xsl:value-of select="info"/><!--Display any info associated with the unit-->
        </p>
      </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>

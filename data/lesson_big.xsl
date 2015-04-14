<?xml version="1.0" encoding="UTF-8"?>
<!--This transformation creates a webpage for a unit. It matches on a given unit node and displays the unit title, img, intro, and all dialogs or vocabs included in the unit.-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:param name="fileprefix" />
  <xsl:template match="/lesson"><!--Match on current unit node-->
    <h1 class="title">
      <xsl:value-of select="title"/>
    </h1><!--Display unit title at top of page-->
    <div class="row">
      <div class="col-md-8">     
        <p>
          <xsl:value-of select="explnote"/><!--Display any notes about the lesson-->
        </p>
      </div>
      <div class="col-md-4">
        <xsl:variable name="imgurl">{{ site.baseurl }}/img/wikiimage.png</xsl:variable>
        <img class="img-responsive thumbnail" src="{$imgurl}" alt="Trees" style="max-width: 75%"></img><!--Display unit img-->
      </div>
    </div>
    <xsl:if test="dialog">
      <div class="well well-lg">
        <div id="dialogHeading">Dialog 1</div>
        <div id="allDialogs">      
          <xsl:for-each select="dialog">
            <xsl:for-each select="line">
              <div class="media"><!--Make a media object with the audio file-->
                <xsl:if test="soundfile">
                  <div class="media-left">
                    <button class="btn btn-default" type="button">
                      <span class="glyphicon glyphicon-play" aria-hidden="true">
                        <audio>
                          <xsl:variable name="soundurl">{{ site.baseurl }}/audio/<xsl:value-of select="soundfile"/>.mp3</xsl:variable>
                          <source src="{$soundurl}" type="audio/mpeg"/>
                        </audio>
                      </span>
                    </button>
                  </div>
                </xsl:if>
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
        </xsl:for-each>
          <ul class="pager">
            <li class = "previous">
              <a href="#" id="prevDialog"><span aria-hidden="true"><xsl:text disable-output-escaping="yes">&#8592;</xsl:text></span>Previous Dialog</a>
            </li>
            <li class = "next">
              <a href="#" id="nextDialog">Next Dialog<span aria-hidden="true"><xsl:text disable-output-escaping="yes">&#8594;</xsl:text></span></a>
            </li>
          </ul>
        </div>
      </div>
    </xsl:if>
    <xsl:if test="vocab">
      <div class="well well-lg">
        <div id="vocabHeading">Vocabulary Section 1</div>
        <div id="allVocabs">      
          <xsl:for-each select="vocab">
            <xsl:for-each select="line">
              <div class="media"><!--Make a media object with the audio file-->
                <xsl:if test="soundfile">
                  <div class="media-left">
                    <xsl:variable name="soundurl">{{ site.baseurl }}/audio/<xsl:value-of select="soundfile"/>.mp3</xsl:variable>
                    <button class="btn btn-default" type="button">
                      <span class="glyphicon glyphicon-play" aria-hidden="true">
                        <audio>
                          <source src="{$soundurl}" type="audio/mpeg"/>
                        </audio>
                      </span>
                    </button>
                  </div>
                </xsl:if>
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
        </xsl:for-each>
          <ul class="pager">
            <li class = "previous">
              <a href="#" id="prevVocab"><span aria-hidden="true"><xsl:text disable-output-escaping="yes">&#8592;</xsl:text></span>Previous Vocabulary</a>
            </li>
            <li class = "next">
              <a href="#" id="nextVocab">Next Vocabulary<span aria-hidden="true"><xsl:text disable-output-escaping="yes">&#8594;</xsl:text></span></a>
            </li>
          </ul>
        </div>
      </div>
    </xsl:if>
    <p>
      <xsl:value-of select="info"/><!--Display any info associated with the lesson-->
    </p>
    <p>
      <xsl:value-of select="designnote"/>
    </p><!--Display design note as a paragraph-->
  </xsl:template>
</xsl:stylesheet>

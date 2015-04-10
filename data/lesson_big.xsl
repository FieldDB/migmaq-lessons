<?xml version="1.0" encoding="UTF-8"?>
<!--This transformation creates a webpage for a unit. It matches on a given unit node and displays the unit title, img, intro, and all dialogs included in the unit.-->
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
    <!--<xsl:if test="dialog">
    <xsl:variable name="dianame">{{ site.baseurl }}/dialogs/<xsl:value-of select="$fileprefix"/>1.html</xsl:variable>
    <div class="embed-responsive embed-responsive-16by9">
      <iframe class="embed-responsive-item" src="{$dianame}" seamless="">
        <a></a>--><!-- Hack to prevent xsl from using shorthand /> end bracket-->
      <!--</iframe>
    </div>
    </xsl:if>-->
    <div id="dialogHeading">Dialog 1</div>
    <div id="allDialogs">      
      <xsl:for-each select="dialog">
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
    </xsl:for-each>
    <a href="#" id="prevDialog">Previous Dialog</a>
    <a href="#" id="nextDialog">Next Dialog</a>

  </div>

    <!--<xsl:if test="vocab">
    <xsl:variable name="vocabname">{{ site.baseurl }}/vocabs/<xsl:value-of select="$fileprefix"/>1.html</xsl:variable>
    <div class="embed-responsive embed-responsive-16by9">
      <iframe class="embed-responsive-item" src="{$vocabname}" seamless="">-->
        <!--<a></a>--><!-- Hack to prevent xsl from using shorthand /> end bracket-->
      <!--</iframe>
    </div>
    </xsl:if>-->
    <div id="vocabHeading">Vocab 1</div>
    <div id="allVocabs">      
      <xsl:for-each select="vocab">
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
    </xsl:for-each>
    <a href="#" id="prevVocab">Previous Vocab</a>
    <a href="#" id="nextVocab">Next Vocab</a>

  </div>
    <p>
      <xsl:value-of select="info"/><!--Display any info associated with the lesson-->
    </p>
    <p>
      <xsl:value-of select="designnote"/>
    </p><!--Display design note as a paragraph-->
  </xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<!--This transformation creates a webpage for a lesson. It matches on a given lesson node and displays the lesson title, img, intro, and all dialogs or vocabs included in the lesson. If the lesson is an activity, the javascript for a matching game is added and special styling is applied.-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/lesson"><!--Match on current unit node-->
    <h1 class="title" id="intro_text">
      <xsl:value-of select="title"/>
    </h1><!--Display lesson title at top of page-->
    <xsl:choose>
      <xsl:when test="activity"> <!--The lesson is a game-->
        <script src="{{{{ site.baseurl }}}}/js/test.js">hi</script><!--include js for matching game-->
        <xsl:for-each select="activity">
          <div class="container-fluid" id="activity">
            <p id="intro"><!--Display the intro text-->
              <xsl:value-of select="intro"/>
            </p>
            <xsl:for-each select="list">
              <xsl:for-each select="item">
                <xsl:variable name="index"><!--Save the number of each item so that you can check whether the two selected items match-->
                  <xsl:value-of select="count(preceding-sibling::item)+1"/>
                </xsl:variable>
                <xsl:variable name="factorfirst"><!--We're doing some math to figure out what proportion of the page each column should get-->
                  <xsl:value-of select="count(first/child::soundfile) + (3 * count(first/child::img)) + (4 * count(first/child::migmaq)) + (4 * count(first/child::english))"/>
                </xsl:variable>
                <xsl:variable name="factorsecond"><!--Each kind of item is weighted by how much space it should take up-->
                  <xsl:value-of select="count(second/child::soundfile) + (3 * count(second/child::img)) + (4 * count(second/child::migmaq)) + (4 * count(second/child::english))"/>
                </xsl:variable>
                <xsl:variable name="sizefactor"><!--Now we want to figure out what fraction of the page each item gets-->
                  <xsl:value-of select="12 div ($factorfirst + $factorsecond)"/>
                </xsl:variable>
                <xsl:variable name="sizefirst"><!--Now multiply the per item fraction by the number of items in the first column-->
                  <xsl:value-of select="($factorfirst * $sizefactor) - (($factorfirst * $sizefactor) mod 1)"/>
                </xsl:variable>
                <xsl:variable name="sizesecond"><!--Now multiply the per item fraction by the number of items in the second column-->
                  <xsl:value-of select="($factorsecond * $sizefactor) - (($factorsecond * $sizefactor) mod 1)"/>
                </xsl:variable>
                <xsl:variable name="whitespace"><!--Any remaining space that can't be evenly divided is whitespace used to separate the columns-->
                  <xsl:value-of select="12 - ($sizefirst + $sizesecond)"/>
                </xsl:variable>
                <div class="row item">
                  <xsl:for-each select="first">
                    <div class="col-xs-{$sizefirst} first" id="{$index}"><!--Now we'll create a div for the first column using the size we calculated above-->
                      <xsl:apply-templates mode="activity"/><!--Transform the inside of the first item-->
                    </div>
                  </xsl:for-each>
                  <xsl:if test="$whitespace > 0"><!--Now create whitespace-->
                    <div class="col-xs-{$whitespace}">&#160;</div>
                  </xsl:if>
                  <xsl:for-each select="second">
                    <div class="col-xs-{$sizesecond} second" id="{$index}"><!--Create a div for the second column using the size we calculated above-->
                      <xsl:apply-templates mode="activity"/><!--Transform the inside of the second item-->
                    </div>
                  </xsl:for-each>
                </div>
              </xsl:for-each>
            </xsl:for-each>
          </div>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <div class="row"><!--If there's no activity, we'll transform the contents of the lesson and display it-->
          <xsl:variable name="divClass">
            <xsl:choose>
              <xsl:when test="img">col-md-8</xsl:when><!-- If there's an image at the top of the page, make the div for the note smaller-->
              <xsl:otherwise>col-md-10</xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <div class="{$divClass}">&#160;<!--Create a div for the note using the size you calculated above-->
            <xsl:for-each select="note">
              <p>
                <xsl:apply-templates/><!--Display any notes about the lesson-->
              </p>
            </xsl:for-each>
          </div>
          <xsl:choose>
            <xsl:when test="img"><!--Display image if there is one, else display default-->
              <div class="col-md-4">
                <xsl:variable name="main_img"><xsl:value-of select="img"/></xsl:variable>
                <img class="img-responsive thumbnail" src="{$main_img}" style="max-width: 75%"/>
              </div>
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
          </xsl:choose>
        </div>
        <xsl:if test="dialog"><!--if there are dialogs, display them-->
          <div class="well well-lg">
            <div id="dialogHeading">Dialog 1</div>
            <div id="allDialogs">      <!--when combined with nav.js, this iterates through the dialogs one at a time-->
              <xsl:for-each select="dialog">
                <div class="container"><!-- if you want to display 1 line at a time, remove this div-->
                  <xsl:for-each select="line">
                    <div class="row">
                      <div class="col-md-1">&#160;
                        <xsl:if test="soundfile"><!-- Link to audio file if there is one-->
                          <button class="btn btn-default" type="button">
                            <span class="glyphicon glyphicon-play" aria-hidden="true">
                              <audio>
                                <xsl:variable name="soundurl">{{ site.baseurl }}/audio/<xsl:value-of select="soundfile"/>.mp3</xsl:variable>
                                <source src="{$soundurl}" type="audio/mpeg"/>
                              </audio>
                            </span>
                          </button>
                        </xsl:if>
                      </div>
                      <div class="col-md-7">
                        <h2 class="media-heading">
                          <xsl:value-of select="migmaq"/>
                        </h2><!--Display Mi'gmaq-->
                        <h4 class="media-heading">
                          <xsl:value-of select="english"/>
                        </h4><!--Display English-->
                      </div> 
                      <div class="col-md-2">&#160;
                        <xsl:if test="img"><!--Display img for the line if there is one-->
                          <xsl:variable name="d_img">{{ site.baseurl }}/emoji/<xsl:value-of select="img"/></xsl:variable>
                          <img class="img-responsive thumbnail" src="{$d_img}" style="width: 64px"/>
                        </xsl:if>
                      </div>
                    </div>
                  </xsl:for-each>
                </div>
              </xsl:for-each>
              <ul class="pager"><!--navigation arrows to page through dialogs-->
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
        <xsl:if test="vocab"><!-- If there are vocab sections, display them-->
          <div class="well well-lg"> 
            <div id="vocabHeading">Vocabulary Section 1</div>
            <div id="allVocabs">     <!--when combined with nav.js, this iterates through the vocabs one at a time-->
              <xsl:for-each select="vocab">
                <div class="container"><!-- if you want to display 1 line at a time, remove this div-->
                  <xsl:for-each select="line">
                    <div class="row">
                      <div class="col-md-1">&#160;
                        <xsl:if test="soundfile"><!-- Link to audio file if there is one-->
                          <xsl:variable name="soundurl">{{ site.baseurl }}/audio/<xsl:value-of select="soundfile"/>.mp3</xsl:variable>
                          <button class="btn btn-default" type="button">
                            <span class="glyphicon glyphicon-play" aria-hidden="true">
                              <audio>
                                <source src="{$soundurl}" type="audio/mpeg"/>
                              </audio>
                            </span>
                          </button>
                        </xsl:if>
                      </div>
                      <div class="col-md-7">
                        <h2 class="media-heading">
                          <xsl:value-of select="migmaq"/>
                        </h2><!--Display Mi'gmaq-->
                        <h4 class="media-heading">
                          <xsl:value-of select="english"/>
                        </h4><!--Display English-->  
                      </div>
                      <div class="col-md-2">&#160;
                        <xsl:if test="img"><!--Display img for the line if there is one-->
                          <xsl:variable name="vimg">{{ site.baseurl }}/emoji/<xsl:value-of select="img"/></xsl:variable>
                          <img class="img-responsive thumbnail" src="{$vimg}" style="width: 64px"/>
                        </xsl:if>
                      </div>
                    </div>
                  </xsl:for-each>
                </div>
              </xsl:for-each>
              <ul class="pager"><!-- navigation arrows to page through vocabs-->
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
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="m"><!--Display Mi'gmaq words in bold-->
    <strong><xsl:value-of select="."/></strong>
  </xsl:template>
  <xsl:template match="soundfile" mode="activity"><!--Soundfile in an activity-->
    <div class="col-xs-2">&#160;
      <xsl:variable name="soundurl">{{ site.baseurl }}/audio/<xsl:value-of select="."/>.mp3</xsl:variable>
      <button class="btn btn-default" type="button">
        <span class="glyphicon glyphicon-play" aria-hidden="true">
          <audio>
            <source src="{$soundurl}" type="audio/mpeg"/>
          </audio>
        </span>
      </button>
    </div>
  </xsl:template>
  <xsl:template match="migmaq" mode="activity"><!--Mi'gmaq line in an activity-->
    <div class="col-xs-8">
      <h2 class="media-heading">
        <xsl:value-of select="."/>
      </h2>
    </div>
  </xsl:template>
  <xsl:template match="english" mode="activity"><!--English line in an activity-->
    <div class="col-xs-8">
      <h2 class="media-heading">
        <xsl:value-of select="."/>
      </h2>
    </div>
  </xsl:template>
  <xsl:template match="img" mode="activity"><!--Img in an activity-->
    <div class="col-xs-4">&#160;
      <xsl:variable name="vimg">{{ site.baseurl }}/emoji/<xsl:value-of select="."/></xsl:variable>
      <img class="img-responsive thumbnail" src="{$vimg}" style="width: 64px"/>
    </div>
  </xsl:template>
</xsl:stylesheet>

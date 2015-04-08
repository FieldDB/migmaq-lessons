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
    <xsl:if test="dialog">
    <xsl:variable name="dianame">{{ site.baseurl }}/dialogs/<xsl:value-of select="$fileprefix"/>1.html</xsl:variable>
    <div class="embed-responsive embed-responsive-16by9">
      <iframe class="embed-responsive-item" src="{$dianame}" seamless="">
        <a></a><!-- Hack to prevent xsl from using shorthand /> end bracket-->
      </iframe>
    </div>
    </xsl:if>
    <xsl:if test="vocab">
    <xsl:variable name="vocabname">{{ site.baseurl }}/vocabs/<xsl:value-of select="$fileprefix"/>1.html</xsl:variable>
    <div class="embed-responsive embed-responsive-16by9">
      <iframe class="embed-responsive-item" src="{$vocabname}" seamless="">
        <a></a><!-- Hack to prevent xsl from using shorthand /> end bracket-->
      </iframe>
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

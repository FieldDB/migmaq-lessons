<?xml version="1.0" encoding="UTF-8"?>
<!--This transformation creates a webpage for a unit. It matches on a given unit node and displays the unit title, img, intro, and all dialogs included in the unit.-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:param name="fileprefix" />
  <xsl:template match="/lesson"><!--Match on current unit node-->
    <h1>
      <xsl:value-of select="title"/>
    </h1><!--Display unit title at top of page-->
    <xsl:variable name="imgurl">{{ site.baseurl }}/img/wikiimage.png</xsl:variable>
    <img class="img-responsive thumbnail" src="{$imgurl}" alt="Trees" style="max-width: 75%"></img><!--Display unit img-->
    <p>
      <xsl:value-of select="designnote"/>
    </p><!--Display design note as a paragraph-->
    <xsl:variable name="filename">{{ site.baseurl }}/dialogs/<xsl:value-of select="$fileprefix"/>1.html</xsl:variable>
    <div class="embed-responsive embed-responsive-16by9">
      <iframe class="embed-responsive-item" src="{$filename}" seamless="">
        <a></a><!-- Hack to prevent xsl from using shorthand /> end bracket-->
      </iframe>
    </div>
    <p>
      <xsl:value-of select="info"/><!--Display any info associated with the lesson-->
    </p>
  </xsl:template>
</xsl:stylesheet>

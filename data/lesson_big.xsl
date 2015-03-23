<?xml version="1.0" encoding="UTF-8"?>
<!--This transformation creates a webpage for a unit. It matches on a given unit node and displays the unit title, img, intro, and all dialogs included in the unit.-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:param name="fileprefix" />
  <xsl:template match="/lesson"><!--Match on current unit node-->
    <html><!--Start html file-->
      <head>
        <title><xsl:value-of select="title"/></title><!--Title is unit title-->
      </head>
      <body>
        <div class="container-fluid">
         <h1><xsl:value-of select="title"/></h1><!--Display unit title at top of page-->
         <img class="img-responsive thumbnail" src="../img/wikiimage.png" alt="Trees" style="max-width: 75%"></img><!--Display unit img-->
         <p><xsl:value-of select="designnote"/></p><!--Display design note as a paragraph-->
         <xsl:for-each select="dialog"><!--Iterate through dialogs; I'm not sure what to do with vocabs-->
          <xsl:variable name="filename">../dialogs/<xsl:value-of select="$fileprefix"/><xsl:value-of select="count(preceding-sibling::dialog)+1"/>.html</xsl:variable>
          <div class="well well-lg">
            <a href="{$filename}"><xsl:value-of select="$filename"/><h4>Dialog <xsl:value-of select="count(preceding-sibling::dialog)+1"/></h4></a>
            <div class="embed-responsive embed-responsive-16by9">
              <iframe class="embed-responsive-item" src="{$filename}" seamless=""></iframe>
            </div>
          </div>
        </xsl:for-each>
        <p>
          <xsl:value-of select="info"/><!--Display any info associated with the unit-->
        </p>
      </div>
    </body>
  </html>
</xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<!--This transformation creates a table of contents for lessons. It displays the intro text and an index showing all child sections, subsections, lessons, and units. It applies to the lessonset node. The index displays the name of each subsection as a link to the relevant webpage.-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/lessonset"><!--Match on lessonset-->
    <h2>Outline:</h2><!--Outline is a list of child node titles and links to their pages-->
    <div class="row">
      <div class="col-md-3">&#160;
      </div>
      <div class="col-md-6"> <!--Start button-->
        {% include start.html %}
      </div>
      <div class="col-md-3">&#160;
      </div>
    </div>
    <xsl:for-each select="section"><!--Find all section children-->
      <div class="row">
        <xsl:variable name="secadd">sections/<xsl:value-of select="count(preceding-sibling::section)+1"/>.html</xsl:variable><!--Create filename for section child webpage-->
        <a href="{$secadd}"><h4><xsl:value-of select="*[1]"/></h4></a>
        <xsl:for-each select="unit"><!--Find all lesson children-->
          <div class="col-md-3"><!--Put each unit in a div-->
            <xsl:variable name="lessadd">units/<xsl:value-of select="count(../preceding-sibling::section)+1"/><xsl:value-of select="count(preceding-sibling::unit)+1"/>.html</xsl:variable><!--Create filename for lesson child webpage-->
            <a href="{$lessadd}"><h5><xsl:value-of select="*[1]"/></h5></a><!--List lesson titles as links to their webpages-->
            <xsl:for-each select="lesson"><!--Find all unit children-->
              <xsl:variable name="unadd">lessons/<xsl:value-of select="count(../../preceding-sibling::section)+1"/>.<xsl:value-of select="count(../preceding-sibling::unit) +1"/>.<xsl:value-of select="count(preceding-sibling::lesson)+1"/>.html</xsl:variable><!--Create filename for unit child webpage-->
              <a href="{$unadd}"><h6><xsl:value-of select="*[1]"/></h6></a><!--List unit titles as links to their webpages-->
            </xsl:for-each>
          </div>
        </xsl:for-each>
      </div>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
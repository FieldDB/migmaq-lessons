<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/list">
    <div class="container">
      <script>
        var list = 
        [<xsl:for-each select="line">
          [<div class="row">
            [<xsl:value-of select="first"/>],
            [<xsl:value-of select="second"/>]
          </div>]
        </xsl:for-each>]
      </script>
    </div>
  </xsl:template>
  <xsl:template match="soundfile">
    <div class="col-md-1">&#160;
      <xsl:variable name="soundurl">{{ site.baseurl }}/audio/<xsl:value-of select="soundfile"/>.mp3</xsl:variable>
      <button class="btn btn-default" type="button">
        <span class="glyphicon glyphicon-play" aria-hidden="true">
          <audio>
            <source src="{$soundurl}" type="audio/mpeg"/>
          </audio>
        </span>
      </button>
    </div>
  </xsl:template>
  <xsl:template match="migmaq">
    <div class="col-md-5">
      <h2 class="media-heading">
        <xsl:value-of select="migmaq"/>
      </h2>
    </div>
  </xsl:template>
  <xsl:template match="english">
    <div class="col-md-5">
      <h2 class="media-heading">
        <xsl:value-of select="english"/>
      </h2>
    </div>
  </xsl:template>
  <xsl:template match="img">
    <div class="col-md-2">&#160;
      <xsl:if test="img">
        <xsl:variable name="vimg">{{ site.baseurl }}/emoji/<xsl:value-of select="img"/></xsl:variable>
        <img class="img-responsive thumbnail" src="{$vimg}" style="width: 64px"/>
      </xsl:if>
    </div>
  </xsl:template>
  <xsl:template match="m">
    <strong>
      <xsl:value-of select="."/>
    </strong>
  </xsl:template>
</xsl:stylesheet>

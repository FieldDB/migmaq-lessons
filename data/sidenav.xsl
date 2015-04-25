<?xml version="1.0" encoding="UTF-8"?>
<!--This transformation creates a nested sidenav displaying the table of contents. It applies to the lessonset node.-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/lessonset"><!--Match on lessonset-->
    <div id="sidebar-wrapper">
      <ul class="sidebar-nav dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="margin-bottom: 5px; display: block; position: static;">
        <li class="dropdown-submenu">
          <a tabindex="-1" href="#">Menu</a>
          <ul class="dropdown-menu">
            <li><a href="{{{{ site.baseurl }}}}/project.html">How to Use this Site</a></li>
            <li class="dropdown-submenu">
              <a href="{{{{ site.baseurl }}}}/intro.html">Table of Contents</a>
              <ul class="dropdown-menu">
                <xsl:for-each select="section"><!--Find all section children-->
                  <xsl:variable name="securl">{{ site.baseurl }}/sections/<xsl:value-of select="count(preceding-sibling::section)+1"/>.html</xsl:variable><!--Create filename for section child webpage-->
                  <li class="dropdown-submenu">
                    <a href="{$securl}"><xsl:value-of select="*[1]"/></a><!--List section titles as links to their webpages-->
                    <ul class="dropdown-menu">
                      <xsl:for-each select="unit"><!--Find all lesson children-->
                        <xsl:variable name="uniturl">{{ site.baseurl }}/units/<xsl:value-of select="count(../preceding-sibling::section)+1"/>.<xsl:value-of select="count(preceding-sibling::unit)+1"/>.html</xsl:variable><!--Create filename for lesson child webpage-->
                        <li class="dropdown-submenu">
                          <a href="{$uniturl}"><xsl:value-of select="*[1]"/></a><!--List lesson titles as links to their webpages-->
                          <ul class="dropdown-menu">
                            <xsl:for-each select="lesson"><!--Find all unit children-->
                              <xsl:variable name="lessonurl">{{ site.baseurl }}/lessons/<xsl:value-of select="count(../../preceding-sibling::section)+1"/>.<xsl:value-of select="count(../preceding-sibling::unit) +1"/>.<xsl:value-of select="count(preceding-sibling::lesson)+1"/>.html</xsl:variable><!--Create filename for unit child webpage-->
                              <li>
                                <a href="{$lessonurl}"><xsl:value-of select="*[1]"/></a><!--List unit titles as links to their webpages-->
                              </li>
                            </xsl:for-each>
                          </ul>
                        </li>
                      </xsl:for-each>
                    </ul>
                  </li>
                </xsl:for-each>
              </ul>
            </li>
            <li><a href="{{{{ site.baseurl }}}}/resources.html">Resources</a></li>
            <li><a href="{{{{ site.baseurl }}}}/welalieg.html">Wela'lieg</a></li>
            <li><a href="https://docs.google.com/forms/d/1BaVNaewifUYSSrlbkPviUZuyFUALTI7_1gLw-Nop2n0/viewform?usp=send_form">Contact Us</a></li>
          </ul>
        </li>
      </ul>
    </div>
  </xsl:template>
</xsl:stylesheet>
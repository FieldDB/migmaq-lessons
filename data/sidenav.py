from lxml import etree
import sys

"""
A script to generate a sidenav with nested table of contents, given an xml tree with 
levels of lessonset, section, unit, and lesson (required command-line argument).
Uses sidenav.xsl to transform the tree and generate the html, and writes the output to 
sidenav.html in the _includes folder.
Author: Carolyn Anderson 		Last modified: 3/16/2015
"""

#Create xsl transformation functions
side_xsl_raw = etree.parse("sidenav.xsl")
side_xsl = etree.XSLT(side_xsl_raw) 
doc = etree.parse(sys.argv[1]) #parse the xml doc

lessonset = doc.xpath("/lessonset")[0]#get lessonset
f = open("../_includes/sidenav.html", "w") #create new file in _includes folder
f.write(str(side_xsl(lessonset))) #apply xslt transformation and write to file
f.close()

from lxml import etree
import sys

"""

"""

#Create xsl transformation functions
side_xsl_raw = etree.parse("sidenav.xsl")
side_xsl = etree.XSLT(side_xsl_raw) 
doc = etree.parse(sys.argv[1]) #parse the xml doc

lessonset = doc.xpath("/lessonset")[0]#get lessonset
f = open("../_includes/sidenav_t.html", "w") #create new file in _includes folder
f.write(str(side_xsl(lessonset))) #apply xslt transformation and write to file
f.close()

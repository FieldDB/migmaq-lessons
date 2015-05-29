from lxml import etree
import sys
"""
Find missing audio files in each lesson and print outline showing their location.

Author: Carolyn Anderson          Last Modified: 5/12/2015
"""

#Create xsl transformation functions
audio_xsl_raw = etree.parse("audio_find.xsl")
audio_xsl = etree.XSLT(audio_xsl_raw)

def processLessonSet(level, lessonset):
  f = open("../audio.html", "w") #create new file
  f.write(str(audio_xsl(lessonset))) #apply xslt transformation and write to file
  f.close()

doc = etree.parse(sys.argv[1]) #parse the xml doc
lessonset = doc.xpath("/lessonset")[0]#get lessonset
processLessonSet(0, lessonset)#process lessonset


from lxml import etree
import sys
"""
Find missing audio files in each lesson and print outline showing their location.

Author: Carolyn Anderson          Last Modified: 3/15/2015
"""

#Create xsl transformation functions
audio_xsl_raw = etree.parse("audio_find.xsl")
audio_xsl = etree.XSLT(audio_xsl_raw)

def processLessonSet(level, lessonset):
  #Transforms the top-level lessonset; creates an intro page
  f = open("../audio.html", "w") #create new file
  f.write(str(audio_xsl(lessonset))) #apply xslt transformation to unit data and write to file
  f.close()

doc = etree.parse(sys.argv[1]) #parse the xml doc
lessonset = doc.xpath("/lessonset")[0]#get lessonset
# xpath always returns a collection, even when it is singleton, thus the [0]
processLessonSet(0, lessonset)#process lessonset


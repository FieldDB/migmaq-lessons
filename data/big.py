from lxml import etree
import sys
"""
This program reads in an xml tree and applies xsl tranformations to various levels of the tree.

The first 5 functions apply xsl tranformations to a single level of the tree and create an HTML file with the result.

The rest of the functions are helper functions for indexing descendent nodes, creating filenames,
getting the position of a node in the tree, finding the titles of ancestor nodes, and generating Jekyll
markups for the top of files.

The program currently applies tranformations to the lessonset, section, subsection, lesson, and unit
levels of the XML file. However, each function is parameterized by current node and depth, so the 
program could be easily modified to tranform other levels of the tree using the same functions.

Author: Carolyn Anderson          Last Modified: 2/13/2015
"""

#Create xsl transformation functions
unit_xsl_raw = etree.parse("lesson_big.xsl")  #Displays data from Unit down
unit_xsl = etree.XSLT(unit_xsl_raw) 
index_xsl_raw = etree.parse("index.xsl")  #Makes an index of child files
index_xsl = etree.XSLT(index_xsl_raw) 
intro_xsl_raw = etree.parse("intro.xsl")  #Creates intro page
intro_xsl = etree.XSLT(intro_xsl_raw) 

def processUnit(level, unit):
  #Rransforms to all units--- creates webpages for each displaying dialogues
  filename = createFilename(unit, level)#create filename
  f = open(filename, "w") #create new file
  f.write(getMarkup(unit, level)) #write Jekyll markup to top
  f.write(str(unit_xsl(unit))) #apply xslt transformation to unit data and write to file
  f.close()

def processLesson(level, lesson):
  #Transforms all lessons and creates an index file for each showing child files
  createIndexFile(lesson, level)
  units = lesson.xpath("unit")  #get units
  for unit in units: #call unit processing function on all units
      processUnit(level+1, unit)

def processSubsection(level, subsection):
  #Transforms all subsections and creates an index file for each showing child files
  createIndexFile(subsection, level)
  lessons = subsection.xpath("lesson")  #get lessons
  for lesson in lessons: #call lesson processing function on all lessons
    processLesson(level+1, lesson)

def processSection(level, section):
  #Transforms all sections and creates an index file for each showing child files  
  createIndexFile(section, level)
  subsections = section.xpath("subsection") #get subsections
  for subsection in subsections: #call subsection processing function on all sections
    processSubsection(level+1, subsection)

def processLessonSet(level, lessonset):
  #Transforms the top-level lessonset; creates an intro page
  f = open("../intro.html", "w") #create new file
  f.write(getMarkup(lessonset, level))#write Jekyll markup to top
  f.write(str(intro_xsl(lessonset))) #apply xslt transformation to unit data and write to file
  f.close()
  sections = lessonset.xpath("lesson")  #get sections
  for section in sections: #call section processing function on all units
    processUnit(level+1, section)

def createIndexFile(current, level):
  #Creates an index file displaying titles of all child files and linking to them
  filename = createFilename(current,level)#create filename
  f = open(filename, "w") #create new file
  f.write(getMarkup(current, level))#write Jekyll markup to top
  f.write(str(index_xsl(current))) #apply xslt transformation to generate an index and write to file
  f.close()

def getMarkup(current, level):
  #Generates a Jekyll markup specifying layout and saving ancestors as Jekyll variables
  markup = ""
  pt = getParentTitles(current, level)#get list of titles of ancestor sections
  for i in range(len(pt)):
    markup = markup + "%s: %s\n" % (pt[i]) #Jekyll markup for each ancestor
  if level == 4:
    markup = "---\nlayout: unit\n" + markup + "---\n" #layout markup
  else:
    markup = "---\nlayout: blank\n" + markup + "---\n" #layout markup
  return markup

def getParentTitles(current, level):
  #Returns the names and titles of ancestor sections in a list of tuples
  titles = []
  for i in range(level, 0, -1): #search back through levels
    parent = current.xpath("..")[0]#get parent
    title = current.xpath("*/text()")[0]#get title of each parent
    name = current.xpath("name()")#get name of each parent
    current = parent #set new current node
    titles.append((name,title)) #append parent title to list
  titles.reverse() #print in top-to-bottom order
  return titles

def createFilename(current, level):
  #Creates a filename based on the index of the current node
  filename = ""
  for i in range(0,level): #iterate through tree hierarchy to current level
    parent = current.xpath("..")[0] #get parent node
    index = getIndex(current) #get index of parent node
    filename = str(index) + "." + filename #add parent node index to filename
    current = parent #set current node to parent to move up a level
  filename = "../" + filename + "html"
  return filename

def getIndex(current):
  #Gets the position of the specified node in the tree
  name = current.xpath("name()")
  return int(current.xpath("count(preceding-sibling::"+name+")+1")) #get index of current node by counting previous siblings

doc = etree.parse(sys.argv[1]) #parse the xml doc
lessonset = doc.xpath("/lessonset")[0]#get lessonset
# xpath always returns a collection, even when it is singleton, thus the [0]
processLessonSet(0, lessonset)#process lessonset


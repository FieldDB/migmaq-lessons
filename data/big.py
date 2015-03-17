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
lesson_xsl_raw = etree.parse("lesson_big.xsl")  #Displays data from Unit down
lesson_xsl = etree.XSLT(lesson_xsl_raw) 
index_xsl_raw = etree.parse("index_big.xsl")  #Makes an index of child files
index_xsl = etree.XSLT(index_xsl_raw) 
intro_xsl_raw = etree.parse("intro_big.xsl")  #Creates intro page
intro_xsl = etree.XSLT(intro_xsl_raw) 

def processLesson(level, lesson):
  #Rransforms to all units--- creates webpages for each displaying dialogues
  filename = "../lessons/" + createFilename(lesson, level)#create filename
  f = open(filename, "w") #create new file
  f.write(getMarkup(lesson, level)) #write Jekyll markup to top
  f.write(str(lesson_xsl(lesson))) #apply xslt transformation to unit data and write to file
  f.close()

def processUnit(level, unit):
  #Transforms all lessons and creates an index file for each showing child files
  createIndexFile("units", unit, level)
  lessons = unit.xpath("lesson")  #get units
  for lesson in lessons: #call unit processing function on all units
      processLesson(level+1, lesson)

def processSection(level, section):
  #Transforms all sections and creates an index file for each showing child files  
  createIndexFile("sections", section, level)
  units = section.xpath("unit") #get subsections
  for unit in units: #call subsection processing function on all sections
    processUnit(level+1, unit)

def processLessonSet(level, lessonset):
  #Transforms the top-level lessonset; creates an intro page
  f = open("../intro.html", "w") #create new file
  f.write(getMarkup(lessonset, level))#write Jekyll markup to top
  f.write(str(intro_xsl(lessonset))) #apply xslt transformation to unit data and write to file
  f.close()
  sections = lessonset.xpath("section")  #get sections
  for section in sections: #call section processing function on all units
    processSection(level+1, section)

def createIndexFile(location, current, level):
  #Creates an index file displaying titles of all child files and linking to them
  filename = "../" + location + "/" + createFilename(current,level)#create filename
  f = open(filename, "w") #create new file
  f.write(getMarkup(current, level))#write Jekyll markup to top
  f.write(str(index_xsl(current))) #apply xslt transformation to generate an index and write to file
  f.close()

def getMarkup(current, level):
  #Generates a Jekyll markup specifying layout and saving ancestors as Jekyll variables
  markup = ""
  pt = getParentTitles(current, level)#get list of titles of ancestor sections
  for i in range(len(pt)):
    markup = markup + "%s: (%s) %s\n" % (pt[i]) #Jekyll markup for each ancestor
  if level == 0:
    markup = "---\nlayout: frame\n---\n" #layout markup
  else:
    prev = getPrev(current, level)
    curr = createFilename(current, level)
    foll = getNext(current, level)
    if level == 3:
      markup = "---\nlayout: frame_inner\n" + markup + "prev: %s\ncurrent: %s\nfoll: %s\n---\n" % (prev, curr, foll) #layout markup
    else:
      markup = "---\nlayout: frame\n" + markup + "prev: %s\ncurrent: %s\nfoll: %s\n---\n" % (prev, curr, foll) #layout markup
  print markup
  return markup

def getPrev(current, level):
  #Finds the previous pages for a given node
  if level==3: #Case lesson
    prev_siblings = current.xpath("preceding-sibling::lesson")
    if not len(prev_siblings)==0: #Case lesson_sib
      prev = createFilename(prev_siblings[len(prev_siblings)-1], level)
    else: #Case parent
      prev = createFilename(current.xpath("..")[0], level-1)
  if level==2:#Case unit
    prev_siblings = current.xpath("preceding-sibling::unit")
    if not len(prev_siblings)==0:
      prev_path = prev_siblings[len(prev_siblings)-1]
      prev_lessons = prev_path.xpath("lesson")
      if not len(prev_lessons)==0: #Case lesson_niece
        prev = createFilename(prev_lessons[len(prev_lessons)-1], level+1)
      else:#Case sibling
        prev = createFilename(prev_path, level)
    else: #Case parent
      prev = createFilename(current.xpath("..")[0], level-1)
  if level==1:#Case section
    prev_siblings = current.xpath("preceding-sibling::section")
    if not len(prev_siblings)==0:
      prev_section = prev_siblings[len(prev_siblings)-1]
      prev_units = prev_section.xpath("unit")
      if not len(prev_units)==0:
        prev_unit = prev_units[len(prev_units)-1]
        prev_lessons = prev_unit.xpath("lesson")
        if not len(prev_lessons)==0: #Case grandniece
          prev_lesson = prev_lessons[len(prev_lessons)-1]
          prev = createFilename(prev_lesson, level+2)
        else: #Case niece
          prev = createFilename(prev_unit, level+1)
      else: #Case sibling
        prev = createFilename(prev_section, level)
    else: #Case parent
      prev = "intro.html"
  return prev

def getNext(current, level):
  #Finds the next pages for a given node
  if level==3:
    siblings = current.xpath("following-sibling::lesson")
    if not len(siblings)==0: #Case sibling
      foll = createFilename(siblings[0], level)
    else:
      aunts = current.xpath("../following-sibling::unit")
      if not len(aunts)==0: #Case aunt
        foll = createFilename(aunts[0], level-1)
      else:
        grandaunts = current.xpath("../../following-sibling::section")
        if not len(grandaunts)==0: #Case grand-aunt
          foll = createFilename(grandaunts[0], level-2)
        else: #Case no-grand-aunt
          foll = "end.html"
  if level==2:
    children = current.xpath("lesson")
    if not len(children)==0: #Case child
      foll = createFilename(children[0], level+1)
    else:
      siblings = current.xpath("following-sibling::unit")
      if not len(siblings)==0: #Case sibling
        foll = createFilename(siblings[0], level)
      else:
        aunts = current.xpath("../following-sibling::section")
        if not len(aunts)==0: #Case aunt
          foll = createFilename(aunts[0], level-1)
        else:
          foll = "end.html"
  if level==1:
    children = current.xpath("unit")
    if not len(children)==0: #Case child
      foll = createFilename(children[0], level+1)
    else:
      siblings = current.xpath("following-sibling::section")
      if not len(siblings)==0: #Case sibling
        foll = createFilename(siblings[0], level)
      else: #Case no_sibling
        foll = "end.html"
  return foll

def getParentTitles(current, level):
  #Returns the names and titles of ancestor sections in a list of tuples
  titles = []
  for i in range(level, 0, -1): #search back through levels
    parent = current.xpath("..")[0]#get parent
    title = current.xpath("*/text()")[0]#get title of each parent
    name = current.xpath("name()")#get name of each parent
    index = getIndex(current)
    current = parent #set new current node
    titles.append((name,index,title)) #append parent title to list
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
  filename = filename + "html"
  return filename

def getIndex(current):
  #Gets the position of the specified node in the tree
  name = current.xpath("name()")
  return int(current.xpath("count(preceding-sibling::"+name+")+1")) #get index of current node by counting previous siblings

doc = etree.parse(sys.argv[1]) #parse the xml doc
lessonset = doc.xpath("/lessonset")[0]#get lessonset
# xpath always returns a collection, even when it is singleton, thus the [0]
processLessonSet(0, lessonset)#process lessonset


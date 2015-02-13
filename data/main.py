from lxml import etree

unit_xsl_raw = etree.parse("unit.xsl")  #parse xsl document
unit_xsl = etree.XSLT(unit_xsl_raw) #create an xslt transformation function
index_xsl_raw = etree.parse("index.xsl")  #parse xsl document
index_xsl = etree.XSLT(index_xsl_raw) #create an xslt transformation function
intro_xsl_raw = etree.parse("intro.xsl")  #parse xsl document
intro_xsl = etree.XSLT(intro_xsl_raw) #create an xslt transformation function

def processUnit(level, unit):
  filename = createFilename(unit, level)#create filename
  f = open(filename, "w") #create new file
  f.write(getMarkup(unit, level)) #write Jekyll markup to top
  f.write(str(unit_xsl(unit))) #apply xslt transformation to unit data and write to file
  f.close()

def processLesson(level, lesson):
  createIndexFile(lesson, level)
  units = lesson.xpath("unit")  #get units
  for unit in units: #call unit processing function on all units
      processUnit(level+1, unit)

def processSubsection(level, subsection):
  createIndexFile(subsection, level)
  lessons = subsection.xpath("lesson")  #get lessons
  for lesson in lessons: #call lesson processing function on all lessons
    processLesson(level+1, lesson)

def processSection(level, section):  
  createIndexFile(section, level)
  subsections = section.xpath("subsection") #get subsections
  for subsection in subsections: #call subsection processing function on all sections
    processSubsection(level+1, subsection)

def processLessonSet(level, lessonset):
  f = open("../intro.html", "w") #create new file
  f.write(getMarkup(lessonset, level))#write Jekyll markup to top
  f.write(str(intro_xsl(lessonset))) #apply xslt transformation to unit data and write to file
  f.close()
  sections = lessonset.xpath("section")  #get sections
  for section in sections: #call section processing function on all units
    processSection(level+1, section)

def createIndexFile(current, level):
  filename = createFilename(current,level)#create filename
  f = open(filename, "w") #create new file
  f.write(getMarkup(current, level))#write Jekyll markup to top
  f.write(str(index_xsl(current))) #apply xslt transformation to generate an index and write to file
  f.close()

def getMarkup(current, level):
  markup = ""
  pt = getParentTitles(current, level)#get list of titles of parent sections
  for i in range(len(pt)):
    markup = markup + "%s: %s\n" % (pt[i]) #Jekyll markup for each parent
  markup = "---\nlayout: blank\n" + markup + "---\n" #layout markup
  return markup

def getParentTitles(current, level):
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
  filename = ""
  for i in range(0,level): #iterate through tree hierarchy to current level
    parent = current.xpath("..")[0] #get parent node
    index = getIndex(current) #get index of parent node
    filename = str(index) + "." + filename #add parent node index to filename
    current = parent #set current node to parent to move up a level
  filename = "../" + filename + "html"
  return filename

def getIndex(child):
  name = child.xpath("name()")
  return int(child.xpath("count(preceding-sibling::"+name+")+1")) #get index of current node by counting previous siblings

doc = etree.parse("short_test.xml") #parse the xml doc
lessonset = doc.xpath("/lessonset")[0]
# xpath always returns a collection, even when it is singleton, thus the [0]
processLessonSet(0, lessonset)


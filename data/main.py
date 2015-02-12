from lxml import etree
import pprint

levelList = ["lessonset", "section", "subsection", "lesson", "unit"]
unit_xsl_raw = etree.parse("unit.xsl")  #parse xsl document
unit_xsl = etree.XSLT(unit_xsl_raw) #create an xslt transformation function
index_xsl_raw = etree.parse("index.xsl")  #parse xsl document
index_xsl = etree.XSLT(index_xsl_raw) #create an xslt transformation function
intro_xsl_raw = etree.parse("intro.xsl")  #parse xsl document
intro_xsl = etree.XSLT(intro_xsl_raw) #create an xslt transformation function
levels = {1:{}, 2:{}, 3:{}, 4:{}} #list of lists that associate each section with its title and page

def processUnit(level, unit):
  filename = createFilename(unit, level)
  plist = getParentTitlesFiles(unit, level)
  titles, files = zip(*plist)
  f = open(filename, "w") #create new file
  f.write("---\nlayout: blank\nsection: %s\nsubsection: %s\nlesson: %s\nunit: %s\n---\n" % titles) #write jekyll layout markup
  f.write(str(unit_xsl(unit))) #apply xslt transformation to unit data and write to file
  f.close()

def processLesson(level, lesson):
  filename = "text_lesson"
  f = open(filename, "w") #create new file
  towrite = str(index_xsl(lesson))
  print towrite
  f.write(towrite) #apply xslt transformation to unit data and write to file
  f.close()
  filename = createFilename(lesson, level)
  createIndexFile(filename, getChildrenTitlesFiles(lesson, level), getParentTitlesFiles(lesson, level), level)
  units = lesson.xpath("unit")  #get units
  for unit in units: #call unit processing function on all units
      processUnit(level+1, unit)

def processSubsection(level, subsection):
  filename = "text_subsection"
  f = open(filename, "w") #create new file
  towrite = str(index_xsl(subsection))
  print towrite
  f.write(towrite) #apply xslt transformation to unit data and write to file
  f.close()
  filename = createFilename(subsection, level)
  createIndexFile(filename, getChildrenTitlesFiles(subsection, level), getParentTitlesFiles(subsection, level), level)
  lessons = subsection.xpath("lesson")  #get lessons
  for lesson in lessons: #call lesson processing function on all lessons
    processLesson(level+1, lesson)

def processSection(level, section):
  filename = "text_section"
  f = open(filename, "w") #create new file
  towrite = str(index_xsl(section))
  print towrite
  f.write(towrite) #apply xslt transformation to unit data and write to file
  f.close()
  filename = createFilename(section, level)
  createIndexFile(filename, getChildrenTitlesFiles(section, level), getParentTitlesFiles(section, level), level)
  subsections = section.xpath("subsection") #get subsections
  for subsection in subsections: #call subsection processing function on all sections
    processSubsection(level+1, subsection)

def processLessonSet(level, lessonset):
  filename = "../intro.html"
  f = open(filename, "w") #create new file
  towrite = str(intro_xsl(lessonset))
  #print towrite
  f.write(towrite) #apply xslt transformation to unit data and write to file
  f.close()
  #createIndexFile(filename, getChildrenTitlesFiles(lessonset, level), getParentTitlesFiles(lessonset, level), level)
  sections = lessonset.xpath("section")  #get sections
  for section in sections: #call section processing function on all units
    processSection(level+1, section)

def createIndexFile(filename, childrenInfo, parentInfo, level):
  text = ""
  for i in range(len(childrenInfo)):
    text = text + "<a href=%s><h2>%s</h2></a>" % (childrenInfo[i][1], childrenInfo[i][0])#fix
  text = "<p>" + text + "</p>"
  markup = ""
  for i in range(0, len(levelList[0:level])):
    markup = markup + "%s: %s\n" % (levelList[i+1], parentInfo[i][0])
  markup = "---\nlayout: blank\n" + markup + "---\n"
  f = open(filename, "w") #create new file
  f.write(markup) #write jekyll layout markup
  f.write(text) #write index of level to file
  f.close()

def createFilename(current, level):
  filename = ""
  for i in range(0,level):
    parent = current.xpath("..")[0]
    index = getIndex(parent, levelList[level-i], current)
    filename = str(index) + "." + filename
    current = parent
  filename = "../" + filename + "html"
  return filename

def getParentTitlesFiles(current, level):
  parentInfo = []
  for i in range(level, 0, -1):
    parent = current.xpath("..")[0]
    title = current.xpath("*/text()")[0]
    filename = createFilename(current, i)
    current = parent
    parentInfo.append((title,filename))
  parentInfo.reverse()
  return parentInfo

def getChildrenTitlesFiles(current, level):
  childInfo = []
  for l in range(len(levelList)-1, (level-1), -1):
    tag = levelList[l]
    children = current.xpath("//"+tag)
    children.reverse()
    for c in children:
      title = c.xpath("*/text()")[0]
      filename = createFilename(c, l)
      childInfo.append((title,filename))
  childInfo.reverse()
  return childInfo

def getIndex(parent, childTag, child):
  count = 0
  for c in parent.xpath(childTag):
    count +=1
    if c == child:
      return count
  return -1

doc = etree.parse("short_test.xml") #parse the xml doc
lessonset = doc.xpath("/lessonset")[0]
# xpath always returns a collection, even when it is singleton, thus the [0]
processLessonSet(0, lessonset)


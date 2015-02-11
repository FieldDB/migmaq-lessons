from lxml import etree
import pprint

#levels = 4  #depth of tree from root to level of page creation
levelList = ["section", "subsection", "lesson", "unit"]
unit_xsl_raw = etree.parse("unit.xsl")  #parse xsl document
unit_xsl = etree.XSLT(unit_xsl_raw) #create an xslt transformation function
levels = {1:{}, 2:{}, 3:{}, 4:{}} #list of lists that associate each section with its title and page

def trackLevel(title, filename, which):
  print which 
  if len(which) == 0:
    which.append("")
    which.append("")
    which.append([])
  if len(which) == 2:

    which.append([])
  children = which[2]
  newL = [title, filename, None]
  which[2].append(newL)
  return children[len(children)-1]

def processUnit(levels, level, unit):
  filename = createFilename(unit, level)
  plist = getParentTitlesFiles(unit, level)
  titles, files = zip(*plist)
  f = open(filename, "w") #create new file
  f.write("---\nlayout: blank\nsection: %s\nsubsection: %s\nlesson: %s\nunit: %s\n---\n" % titles) #(sectionTitle, subsectionTitle, lessonTitle, title)) #write jekyll layout markup
  f.write(str(unit_xsl(unit))) #apply xslt transformation to unit data and write to file
  f.close()

def processLesson(levels, level, lesson):
  title = lesson.xpath("lessontitle/text()")[0] #get lesson title
  filename = createFilename(lesson, level)
  units = lesson.xpath("unit")  #get units
  for unit in units: #call unit processing function on all units
      processUnit(levels, level+1, unit)

def processSubsection(levels, level, subsection):
  title = subsection.xpath("subsectitle/text()")[0] #get subsection title
  filename = createFilename(subsection, level)
  lessons = subsection.xpath("lesson")  #get lessons
  for lesson in lessons: #call lesson processing function on all lessons
    processLesson(levels, level+1, lesson)

def processSection(levels, level, section):
  # xpath always returns a collection, even when it is singleton, thus the [0]
  title = section.xpath("sectiontitle/text()")[0] #get section title
  filename = createFilename(section, level)
  subsections = section.xpath("subsection") #get subsections
  for subsection in subsections: #call subsection processing function on all sections
    processSubsection(levels, level+1, subsection)

def createIndexFile(filename, childrenInfo, parentInfo, level, levelList):
  markup = "---\nlayout: blank\n"
  for i in range(level+1):
    filename = filename + "%s." % (len(which[i])-1)
    markup = markup + "%s: %s\n" % (levelList[i], which[i][0])
  children = which[level+1]
  text = "<p><a href=%s><h3>%s</h3></a>" % (which[level][len(which[level+1])-1][1], which[level][len(which[level])-1][0])
  for c in children:
    text = text + "<a href=%s><h2>%s</h2></a>" % (c, c)#fix
  text = text + "</p>"
  markup = markup + "---\n"
  filename = filename + "html"
  i = len(which[level])-1
  which[level][i][1] = filename
  f = open(filename, "w") #create new file
  f.write(markup) #write jekyll layout markup
  f.write(text) #write index of level to file
  f.close()

def createFilename(current, level):
  levelList = ["section", "subsection", "lesson", "unit"]
  filename = ""
  for i in range(level, 0, -1):
    parent = current.xpath("..")[0]
    index = getIndex(parent, levelList[i-1], current)
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
  levelList = ["section", "subsection", "lesson", "unit"]
  childInfo = []
  for l in range(len(levelList[level:])+1, 0, -1):
    tag = levelList[l-1]
    children = current.xpath("//"+tag)
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
sections = doc.xpath("/lessonset/section")  #get sections
for section in sections: #call section processing function on all units
  w = processSection(levels, 1, section)
  print getChildrenTitlesFiles(section, 1)


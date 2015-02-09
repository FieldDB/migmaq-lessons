from lxml import etree
import pprint

levels = 4  #depth of tree from root to level of page creation
levelList = ["section", "subsection", "lesson", "unit"]
unit_xsl_raw = etree.parse("unit.xsl")  #parse xsl document
unit_xsl = etree.XSLT(unit_xsl_raw) #create an xslt transformation function
which = [] #list of lists that associate each section with its title and page
for l in levelList:
  which.append([])

def trackLevel(level, title, filename, which):
  if which[level] == None:
    which[level] = []
  newL = [title, filename]
  which[level].append(newL)
  return which

def processUnit(level, parent, unit, which):
  title = unit.xpath("unittitle/text()")[0]
  filename = "../%s.%s.%s.%s.html" % (len(which[0]), len(which[1]), len(which[2]), len(which[3]))
  f = open(filename, "w") #create new file
  f.write("---\nlayout: blank\nsection: %s\nsubsection: %s\nlesson: %s\nunit: %s\n---\n" % ("1", "2", "3", "4")) #(sectionTitle, subsectionTitle, lessonTitle, title)) #write jekyll layout markup
  f.write(str(unit_xsl(unit))) #apply xslt transformation to unit data and write to file
  f.close()
  which = trackLevel(level, title, filename, which)
  return which

def processLesson(level, lesson, which, levelList):
  title = lesson.xpath("lessontitle/text()")[0] #get lesson title
  units = lesson.xpath("unit")  #get units
  which = trackLevel(level, title, "", which)
  which = createIndexFile(which, level, levelList)
  for unit in units: #call unit processing function on all units
    which = processUnit(level-1, unit, which)
  return which

def processSubsection(level, subsection, which, levelList):
  title = subsection.xpath("subsectitle/text()")[0] #get subsection title
  lessons = subsection.xpath("lesson")  #get lessons
  which = trackLevel(level, title, "", which)
  which = createIndexFile(which, level, levelList)
  for lesson in lessons: #call lesson processing function on all lessons
    which = processLesson(level-1, lesson, which, levelList)
  return which

def processSection(level, section, which, levelList):
  # xpath always returns a collection, even when it is singleton, thus the [0]
  title = section.xpath("sectiontitle/text()")[0] #get section title
  subsections = section.xpath("subsection") #get subsections 
  which = trackLevel(level, title, "", which)
  which = createIndexFile(which, level, levelList)
  for subsection in subsections: #call subsection processing function on all sections
    which = processSubsection(level-1, subsection, which, levelList)
  return which

def createIndexFile(which, level, levelList):
  filename = "../"
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
  print filename
  f = open(filename, "w") #create new file
  f.write(markup) #write jekyll layout markup
  f.write(text) #write index of level to file
  f.close()
  return which

doc = etree.parse("short_test.xml") #parse the xml doc
sections = doc.xpath("/lessonset/section")  #get sections
for section in sections: #call section processing function on all units
  which = processSection(0, section, which, levelList)
pprint.pprint(which)
for o in which:
  print "First level"
  print o 
  print "-------"
  for t in o:
    print "Second level"
    print t
    print "-------"


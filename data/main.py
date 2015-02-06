from lxml import etree
levels = 4  #depth of tree from root to level of page creation
levelList = ["section", "subsection", "lesson", "unit"]
unit_xsl_raw = etree.parse("unit.xsl")  #parse xsl document
unit_xsl = etree.XSLT(unit_xsl_raw) #create an xslt transformation function
which = [] #list of lists that associate each section with its title and page
for i in range(levels):
  which.append([0,None,None])

def processUnit(sectionTitle, subsectionTitle, lessonTitle, unit, which):
  which[3][0] +=1
  title = unit.xpath("unittitle/text()")[0]
  which[3][1] = title
  filename = "../%s.%s.%s.%s.html" % (which[0][0], which[1][0], which[2][0], which[3][0])
  which[3][2] = filename
  f = open(filename, "w") #create new file
  f.write("---\nlayout: blank\nsection: %s\nsubsection: %s\nlesson: %s\nunit: %s\n---\n" % (sectionTitle, subsectionTitle, lessonTitle, title)) #write jekyll layout markup
  f.write(str(unit_xsl(unit))) #apply xslt transformation to unit data and write to file
  f.close()
  return which

def processLesson(sectionTitle, subsectionTitle, lesson, which, levelList):
  which[2][0] +=1  #increment which lesson is being processed
  title = lesson.xpath("lessontitle/text()")[0] #get lesson title
  which[2][1] = title
  units = lesson.xpath("unit")  #get units
  for unit in units: #call unit processing function on all units
    which = processUnit(sectionTitle, subsectionTitle, title, unit, which)
  createIndexFile(which, 0, levelList)
  return which

def processSubsection(sectionTitle, subsection, which, levelList):
  which[1][0] +=1  #increment which subsection is being processed
  title = subsection.xpath("subsectitle/text()")[0] #get subsection title
  which[1][1] = title
  lessons = subsection.xpath("lesson")  #get lessons
  for lesson in lessons: #call lesson processing function on all lessons
    which = processLesson(sectionTitle, title, lesson, which, levelList)
  createIndexFile(which, 1, levelList)
  return which

def processSection(section, which, levelList):
  which[0][0] +=1 #increment which section is being processed
  # xpath always returns a collection, even when it is singleton, thus the [0]
  title = section.xpath("sectiontitle/text()")[0] #get section title
  which[0][1] = title
  subsections = section.xpath("subsection") #get subsections
  for subsection in subsections: #call subsection processing function on all sections
    which = processSubsection(title, subsection, which, levelList)
  createIndexFile(which, 0, levelList)
  return which

def createIndexFile(which, level, levelList):
  filename = "../"
  markup = "---\nlayout: blank\n"
  for i in range(level):
    filename = filename + "%s." % (which[i][0])
    markup = markup + "%s: %s\n" % (levelList[i], which[i][1])
  markup = markup + "---\n"
  filename = filename + "html"
  which[level-1][2] = filename
  text = "<p><h3><a href=%s><h3>%s</h3></a></h3></p>" % (which[level-1][2], which[level-1][1])
  f = open(filename, "w") #create new file
  f.write(markup) #write jekyll layout markup
  f.write(text) #write index of level to file
  f.close()

doc = etree.parse("short_test.xml") #parse the xml doc
sections = doc.xpath("/lessonset/section")  #get sections
for section in sections: #call section processing function on all units
  which = processSection(section, which, levelList)
print which

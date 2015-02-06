from lxml import etree
levels = 4  #depth of tree from root to level of page creation
unit_xsl_raw = etree.parse("unit.xsl")  #parse xsl document
unit_xsl = etree.XSLT(unit_xsl_raw) #create an xslt transformation function
which = [] #list of lists that associate each section with its title and page
for i in range(levels):
  which.append([0,None,None])

def processUnit(sectionTitle, subsectionTitle, lessonTitle, unit, which):
  which[3][0] +=1
  title = unit.xpath("unittitle/text()")[0]
  which[3][1] = title
  filename = "%s.%s.%s.%s.html" % (which[0][0], which[1][0], which[2][0], which[3][0])
  which[3][2] = filename
  f = open(filename, "w") #create new file
  f.write("---\nlayout: blank\nsection: %s\nsubsection: %s\nlesson: %s\nunit: %s\n---\n" % (sectionTitle, subsectionTitle, lessonTitle, title)) #write jekyll layout markup
  f.write(str(unit_xsl(unit))) #apply xslt transformation to unit data and write to file
  f.close()
  return which

def processLesson(sectionTitle, subsectionTitle, lesson, which):
  which[2][0] +=1  #increment which lesson is being processed
  title = lesson.xpath("lessontitle/text()")[0] #get lesson title
  which[2][1] = title
  units = lesson.xpath("unit")  #get units
  for unit in units: #call unit processing function on all units
    which = processUnit(sectionTitle, subsectionTitle, title, unit, which)
  return which

def processSubsection(sectionTitle, subsection, which):
  which[1][0] +=1  #increment which subsection is being processed
  title = subsection.xpath("subsectitle/text()")[0] #get subsection title
  which[1][1] = title
  lessons = subsection.xpath("lesson")  #get lessons
  for lesson in lessons: #call lesson processing function on all lessons
    which = processLesson(sectionTitle, title, lesson, which)
  return which

def processSection(section, which):
  which[0][0] +=1 #increment which section is being processed
  # xpath always returns a collection, even when it is singleton, thus the [0]
  title = section.xpath("sectiontitle/text()")[0] #get section title
  which[0][1] = title
  subsections = section.xpath("subsection") #get subsections
  for subsection in subsections: #call subsection processing function on all sections
    which = processSubsection(title, subsection, which)
  return which

doc = etree.parse("short_test.xml") #parse the xml doc
sections = doc.xpath("/lessonset/section")  #get sections
for section in sections: #call section processing function on all units
  which = processSection(section, which)
print which

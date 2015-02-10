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
  title = unit.xpath("unittitle/text()")[0]
  l = levels[level]
  parent = l[unit][0][0]
  number = l[unit][0][1]
  lesson = unit.xpath("..")[0]
  lesson_title = lesson.xpath("lessontitle/text()")[0]
  subsection = lesson.xpath("..")[0]
  subsection_title = subsection.xpath("subsectitle/text()")[0]
  section = subsection.xpath("..")[0]
  section_title = section.xpath("sectiontitle/text()")[0]
  filename = "../%s.%s.%s.%s.html" % (1, 2, 3, number)
  l[unit] = [(parent, filename, title)]
  f = open(filename, "w") #create new file
  f.write("---\nlayout: blank\nsection: %s\nsubsection: %s\nlesson: %s\nunit: %s\n---\n" % (section_title, subsection_title, lesson_title, title)) #(sectionTitle, subsectionTitle, lessonTitle, title)) #write jekyll layout markup
  f.write(str(unit_xsl(unit))) #apply xslt transformation to unit data and write to file
  f.close()

def processLesson(levels, level, lesson):
  title = lesson.xpath("lessontitle/text()")[0] #get lesson title
  l = levels[level]
  parent = l[lesson][0]
  l[lesson] = [(parent, "", title)]
  units = lesson.xpath("unit")  #get units
  for unit in units: #call unit processing function on all units
    l[lesson].append(unit)
    levels[level+1][unit] = [(lesson, len(l[lesson])-1, "", "")]
    processUnit(levels, level+1, unit)

def processSubsection(levels, level, subsection):
  title = subsection.xpath("subsectitle/text()")[0] #get subsection title
  l = levels[level]
  parent = l[subsection][0]
  l[subsection] = [(parent, "", title)]
  lessons = subsection.xpath("lesson")  #get lessons
  for lesson in lessons: #call lesson processing function on all lessons
    l[subsection].append(lesson)
    levels[level+1][lesson] = [(subsection, len(l[subsection])-1, "", "")]
    processLesson(levels, level+1, lesson)

def processSection(levels, level, section):
  # xpath always returns a collection, even when it is singleton, thus the [0]
  title = section.xpath("sectiontitle/text()")[0] #get section title
  l = levels[level]
  l[section] = [("", title)]
  subsections = section.xpath("subsection") #get subsections
  for subsection in subsections: #call subsection processing function on all sections
    l[section].append(subsection)
    levels[level+1][subsection] = [(section, len(l[section])-1, "", "")]
    processSubsection(levels, level+1, subsection)

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
  w = processSection(levels, 1, section)
pprint.pprint(levels)


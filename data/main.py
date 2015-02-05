from lxml import etree

unit_xsl_raw = etree.parse("unit.xsl")
unit_xsl = etree.XSLT(unit_xsl_raw)

def processUnit(sectionTitle, subsectionTitle, lessonTitle, unit):
  unitTitle = unit.xpath("unittitle/text()")[0]
  filename = "%s-%s-%s-%s.html" % (sectionTitle, subsectionTitle, lessonTitle, unitTitle)
  f = open(filename, "w")
  f.write(str(unit_xsl(unit)))
  f.close()

def processLesson(sectionTitle, subsectionTitle, lesson):
  lessonTitle = lesson.xpath("lessontitle/text()")[0]
  print "Lesson %s" % lessonTitle
  units = lesson.xpath("unit")
  for unit in units:
    processUnit(sectionTitle, subsectionTitle, lessonTitle, unit)

def processSubsection(sectionTitle, subsection):
  subsectionTitle = subsection.xpath("subsectitle/text()")[0]
  print "Subsection %s" % subsectionTitle
  lessons = subsection.xpath("lesson")
  for lesson in lessons:
    processLesson(sectionTitle, subsectionTitle, lesson)

def processSection(section):
  # xpath always returns a collection, even when it is singleton, thus the [0]
  title = section.xpath("sectiontitle/text()")[0]
  print "Section %s" % title
  subsections = section.xpath("subsection")
  for subsection in subsections:
    processSubsection(title, subsection)


doc = etree.parse("NewTestScript.xml")
sections = doc.xpath("/lessonset/section")
for section in sections:
  processSection(section)

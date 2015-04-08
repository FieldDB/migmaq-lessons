from lxml import etree
top = etree.parse('html_test.html')
rtop = top.getroot()
body = etree.parse('short_test.xml')
rbody = body.getroot()

#####################################################################

def printLeaves(r):
    if len(r) == 0:
        print(r)
    else:
        for child in r:
            printLeaves(child)

#####################################################################

def getElements(r, keyword):
    return list(r.iter(keyword))

#####################################################################
    
def addAttr(r, keyword, k, v):
    l = getElements(r, keyword)
    for i in l:
        i.set(k, v)
        #print(i.attrib) Prints all attributes of i

#####################################################################

def getAttrV(r, keyword, k):
    l = getElements(r, keyword)
    r = []
    for i in l:
        r.append(i.get(k))
    return r
#####################################################################

def makeText(r, k):
    l = getElements(r, k)
    for node in l:
        t = etree.SubElement(node.getparent(), "h1")
        t.text = node.text

#####################################################################
addAttr(rbody, 'unit', 'href', "http://example.com/")
hrefs = getAttrV(rbody, 'unit', 'href')
#printLeaves(rtop) 
blist = getElements(rtop, 'body')
blist[0].append(rbody)
makeText(rtop, "genintrotitle")
top.write('root.html', method="html")
r = etree.HTML('root.html')
print(r)
for x in r.iter():
    print x
printLeaves(r)

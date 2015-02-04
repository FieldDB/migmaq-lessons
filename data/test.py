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
        t.text = node.text
        SubElement(node, "h1")

#####################################################################
addAttr(rbody, 'unit', 'href', "http://example.com/")
hrefs = getAttrV(rbody, 'unit', 'href')
#printLeaves(rtop) 
blist = getElements(rtop, 'body')
blist[0].append(rbody)

top.write('root.html', method="html")
r = etree.parse('root.html')
printLeaves(r)

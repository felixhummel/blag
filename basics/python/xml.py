"""
XML string (or file) --> pretty printed xml

The cool thing about BeautifulSoup: It "won't choke if you give it bad markup"
"""
try:
    from BeautifulSoup import BeautifulStoneSoup
except ImportError:
    print "You need BeatifulSoup, so either type"
    print "sudo easy_install beautifulsoup"
    print "or go to http://www.crummy.com/software/BeautifulSoup/ ."

def prettyprint(xml_string):
    soup = BeautifulStoneSoup(xml_string)
    print soup.prettify()

import re
g1 = re.compile("([a-z][a-z]).*\\1") # Has 2 sets of paired letters
g2 = re.compile("([a-z])[a-z]\\1") # Has split double xyx
with open('input.txt') as f:
    print len([l for l in f if g1.search(l) and g2.search(l)])

import re
# Check if it has 2 sets of the same 2 paired letters
g1 = re.compile("([a-z][a-z]).*\\1") 
# Check for a double letter split by another letter, e.g. 'xyx'
g2 = re.compile("([a-z])[a-z]\\1") 
with open('input.txt') as f:
    # Count up the number of lines that match all of our criteria.
    print len([l for l in f if g1.search(l) and g2.search(l)])

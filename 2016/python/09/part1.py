import re
from itertools import *
from sys import stdin

nums = re.compile(r'(\d+)')
text = stdin.read()
gen = iter(text)

notLeft = lambda c : c != '('
notRight = lambda c : c != ')'

count = 0
try:
    while True:
        count += len(list(takewhile(notLeft, gen)))
        marker = ''.join(takewhile(notRight, gen))
        [numChars, numRepeat] = map(int, nums.findall(marker))
        count += len(list(islice(gen, numChars))) * numRepeat
except:
    print count

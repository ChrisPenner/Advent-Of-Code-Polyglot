import re
from itertools import *
from sys import stdin

nums = re.compile(r'(\d+)')
text = stdin.read()

notLeft = lambda c : c != '('
notRight = lambda c : c != ')'

def decompress(gen):
    count = 0
    try:
        while True:
            count += len(list(takewhile(notLeft, gen)))
            marker = ''.join(takewhile(notRight, gen))
            [numChars, numRepeat] = map(int, nums.findall(marker))
            count += decompress(islice(gen, numChars)) * numRepeat
    except:
        return count
print decompress(iter(text))

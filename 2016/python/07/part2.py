import re
from itertools import chain
from sys import stdin

aba = re.compile(r'(?=(\w)(\w)(\1))')
lines = stdin.readlines()

valid = lambda (a, b, _): a != b
flip = lambda (a, b, _): (b, a, b)

count = 0
for l in lines:
    goods = re.split(r'\[.+?]', l)
    bads = re.findall(r'\[(.+?)]', l)
    good_matches = list(chain.from_iterable(aba.findall(g) for g in goods))
    bad_matches = list(chain.from_iterable(aba.findall(b) for b in bads))
    count += any(g for g in good_matches for b in bad_matches if valid(g) and flip(g) == b)
print count

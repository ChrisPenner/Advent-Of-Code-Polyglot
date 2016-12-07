import re
from itertools import chain
from sys import stdin

abba = re.compile(r'(?=(\w)(\w)\2\1)')
lines = stdin.readlines()

valid = lambda (a, b): a != b

count = 0
for l in lines:
    bads = re.findall(r'\[(.+?)]', l)
    bad_matches = chain.from_iterable(abba.findall(b) for b in bads)
    bad_match = any(valid(b) for b in bad_matches)
    if bad_match:
        continue
    goods = re.split(r'\[.+?]', l)
    good_matches = chain.from_iterable(abba.findall(g) for g in goods)
    count += any(valid(g) for g in good_matches)
print count

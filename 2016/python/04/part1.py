import re
from sys import stdin
from collections import Counter

splitparts = re.compile(r'([a-z-]+)(\d+)\[(.+)\]')
rooms = stdin.readlines()
total = 0
for room in rooms:
    code, serial, check = splitparts.match(room).groups()
    code = code.replace('-', '')
    c = Counter(code)
    most = ''.join(k for (k, v) in sorted(c.most_common(), key=lambda (x,y): (-y,x)))
    if most.startswith(check):
        total += int(serial)
print total

import re
from collections import defaultdict
r = re.compile("([0-9]+)")

lights = defaultdict(int)
with open('input.txt') as f:
    for line in f:
        x1, y1, x2, y2 = [int(x) for x in r.findall(line)]
        if line.startswith('toggle'):
            for x in range(x1, x2 + 1):
                for y in range(y1, y2 + 1):
                    lights[(x,y)] = lights[(x,y)] + 2
        elif line.startswith('turn off'):
            for x in range(x1, x2 + 1):
                for y in range(y1, y2 + 1):
                    lights[(x,y)] = max(lights[(x,y)] - 1, 0)

        elif line.startswith('turn on'):
            for x in range(x1, x2 + 1):
                for y in range(y1, y2 + 1):
                    lights[(x,y)] = lights[(x,y)] + 1

print sum(lights.itervalues())

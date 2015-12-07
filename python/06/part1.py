import re
r = re.compile("([0-9]+)")

lights = set()
with open('input.txt') as f:
    for line in f:
        x1, y1, x2, y2 = [int(x) for x in r.findall(line)]
        if line.startswith('toggle'):
            for x in range(x1, x2 + 1):
                for y in range(y1, y2 + 1):
                    if (x,y) in lights:
                        lights.remove((x,y))
                    else:
                        lights.add((x,y))

        elif line.startswith('turn off'):
            for x in range(x1, x2 + 1):
                for y in range(y1, y2 + 1):
                    if (x,y) in lights:
                        lights.remove((x,y))
        elif line.startswith('turn on'):
            for x in range(x1, x2 + 1):
                for y in range(y1, y2 + 1):
                    lights.add((x,y))

print len(lights)

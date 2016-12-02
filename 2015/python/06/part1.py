import re
# This regex pulls out all contiguous numbers from a line.
r = re.compile("([0-9]+)")

# Keep track of lights as a set, a light is 'on' if it's in the set.
lights = set()
with open('input.txt') as f:
    for line in f:
        # Get the ranges from the instruction via regex
        x1, y1, x2, y2 = [int(x) for x in r.findall(line)]
        # For each instruction, iterate over the range and do the right thing.
        if line.startswith('toggle'):
            for x in range(x1, x2 + 1):
                for y in range(y1, y2 + 1):
                    # Toggle: remove it if it's there, add it otherwise.
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

# Count up all lights that are 'on'
print len(lights)

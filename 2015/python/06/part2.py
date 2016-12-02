import re
from collections import defaultdict
# This regex pulls out all contiguous numbers from a line.
r = re.compile("([0-9]+)")

# Keep track of lights as a dict with 0 as a default value.
lights = defaultdict(int)
with open('input.txt') as f:
    for line in f:
        # Get the ranges from the instruction via regex
        x1, y1, x2, y2 = [int(x) for x in r.findall(line)]
        # For each instruction, iterate over the range and do the right thing.
        if line.startswith('toggle'):
            for x in range(x1, x2 + 1):
                for y in range(y1, y2 + 1):
                    # Toggle: Add two to existing brightness
                    lights[(x,y)] = lights[(x,y)] + 2
        elif line.startswith('turn off'):
            for x in range(x1, x2 + 1):
                for y in range(y1, y2 + 1):
                    # Turn off: Remove one from existing brightness, but not below 0
                    lights[(x,y)] = max(lights[(x,y)] - 1, 0)

        elif line.startswith('turn on'):
            for x in range(x1, x2 + 1):
                for y in range(y1, y2 + 1):
                    # Turn on: Add one to existing brightness
                    lights[(x,y)] = lights[(x,y)] + 1

# Count up total brightness
print sum(lights.itervalues())

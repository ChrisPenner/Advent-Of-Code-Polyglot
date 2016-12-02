from sys import stdin, exit
import re

num = re.compile('\d+')

# Turn our direction according to 'turn'
def switchDir(cur, d):
    if d == 'R':
        return (cur + 1) % 4
    elif d == 'L':
        return (cur - 1) % 4

# Move 'n' steps from 'loc' in direction 'dir'
def move(loc, dir, n):
    x, y = loc
    if dir == 0:
        return (x, y-n)
    if dir == 1:
        return (x + n, y)
    if dir == 2:
        return (x, y + n)
    if dir == 3:
        return (x-n, y)

orientation = 0
loc = (0, 0)

# Keep track of places we've been
locs = set([(0, 0)])

# Read problem from stdin
s = stdin.read()

# Split into rules
for rule in s.split(', '):
    # Direction is first char
    turn_dir = rule[0]

    # Get number from rule
    n = int(num.findall(rule)[0])

    # Change direction
    orientation = switchDir(orientation, turn_dir)

    # Move the amount specified but in single steps to collect interstitial positions
    for i in range(n):
        loc = move(loc, orientation, 1)
        # If we've been here, it's our answer
        if loc in locs:
            print sum(map(abs, loc))
            exit(0)

        # Add the current location to the set
        locs.add(loc)

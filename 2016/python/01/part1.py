from sys import stdin
import re

num = re.compile('\d+')

# Turn our direction according to 'turn'
def switchDir(direction, turn):
    if turn == 'R':
        return (direction + 1) % 4
    elif turn == 'L':
        return (direction - 1) % 4

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

    # Move the amount specified
    loc = move(loc, orientation, n)

# Print result
print sum(map(abs, loc))

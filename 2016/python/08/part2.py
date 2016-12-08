import re
from functools import partial
from sys import stdin

nums = re.compile(r'(\d+)')
lines = stdin.readlines()
grid = set()

X = 50
Y = 6

def rotCol(dx, dy, (x, y)):
    if x == dx:
        return (x, (y + dy) % Y)
    return (x, y)

def rotRow(dy, dx, (x, y)):
    if y == dy:
        return ((x + dx) % X, y)
    return (x, y)

def printGrid(grid):
    for y in range(Y):
        for x in range(X):
            if (x, y) in grid:
                print '#',
            else:
                print '.',
        print ''

for l in lines:
    if l.startswith('rect'):
        [dx, dy] = map(int, nums.findall(l))
        grid = grid | set((x, y) for x in range(dx) for y in range(dy))

    elif 'x=' in l:
        [dx, dy] = map(int, nums.findall(l))
        rc = partial(rotCol, dx, dy)
        grid = set(map(rc, grid))

    elif 'y=' in l:
        [dy, dx] = map(int, nums.findall(l))
        rr = partial(rotRow, dy, dx)
        grid = set(map(rr, grid))
    printGrid(grid)
    print '----------------------------'
print len(grid)

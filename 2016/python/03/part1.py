import re
from sys import stdin

num = re.compile(r'\d+')

# Read problem from stdin
triangles = stdin.readlines()

count = 0

# For each line
for line in triangles:
    [a, b, c] = map(int, num.findall(line))
    # If it's a triangle...
    if (a + b) > c and (b + c) > a and (c + a) > b:
        count += 1
print count

import re
from sys import stdin

num = re.compile(r'\d+')

# Read problem from stdin
triangles = stdin.readlines()
count = 0

# Convert to a list of lists of numbers
numbers = map(lambda l: map(int, num.findall(l)), triangles)

# Get first of each row, second of each, third of each
ta = [l[0] for l in numbers]
tb = [l[1] for l in numbers]
tc = [l[2] for l in numbers]

# Now they're in the right order
triangles = ta + tb + tc

while triangles:
    # Get the first three
    a = triangles[0]
    b = triangles[1]
    c = triangles[2]
    if (a + b) > c and (b + c) > a and (c + a) > b:
        count += 1

    # Move the list along
    triangles = triangles[3:]
print count

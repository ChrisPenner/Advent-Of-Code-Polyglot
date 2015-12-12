import re

with open('day12-input.txt') as file:
    input = file.read()

print(sum(map(int, re.compile(r'(-?\d+)').findall(input))))

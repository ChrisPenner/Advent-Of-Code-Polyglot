import re

with open('input.txt') as file:
    inp = file.read()

print(sum(int(x) for x in re.findall(r'(-?\d+)', inp)))

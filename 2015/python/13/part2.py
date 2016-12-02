import re
from collections import defaultdict
from itertools import permutations
person = re.compile(r'[A-Z][a-z]*')
value = re.compile(r'-?\d+')
lose = re.compile(r'lose')
people = set(['me'])
# Have a default value of 0
mapping = defaultdict(int)

# Returns the tuple in sorted order
sorted_tuple = lambda x, y: tuple(sorted((x, y)))
with open('input.txt') as file:
    for line in file:
        sitter, neighbour = person.findall(line)
        diff = int(value.search(line).group())
        if lose.search(line):
            diff = -diff
        people.add(sitter)
        # Just get the total difference for the pair of people.
        mapping[sorted_tuple(sitter, neighbour)] += diff

totals = []

for p in permutations(people):
    total = 0
    for i, person in enumerate(p):
        # Just need each person and their previous person
        total += mapping[sorted_tuple(p[i-1], p[i]) ]
    totals.append(total)

print max(totals)

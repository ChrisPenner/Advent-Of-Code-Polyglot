import re
from collections import defaultdict

transitions = defaultdict(list)
endpoints = set()

with open('input.txt') as f:
    rules, string = f.read().split('\n\n')
    lines = rules.split('\n')
    for line in lines:
        a, _, b = line.split()
        # Add to the list of all possible transitions
        transitions[a].append(b)

units = re.compile(r'[A-Z][a-z]*')
# Split list into atoms
tokens = units.findall(string)

for i, token in enumerate(tokens):
    for terminal in transitions[token]:
        # Leave original tokens list alone
        l = tokens[:]
        l[i] = terminal
        # Return it to a string, Set ensures no duplicates
        endpoints.add(''.join(l))

print len(endpoints)

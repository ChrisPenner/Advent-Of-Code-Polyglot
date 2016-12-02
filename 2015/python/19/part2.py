rules = {}
with open('input.txt') as f:
    rule_block, string = map(str.strip, f.read().split('\n\n'))
    lines = rule_block.split('\n')
    for line in lines:
        a, _, b = line.split()
        rules[b] = a

# Greedily sort by largest replacement
sorted_rules = sorted(rules.keys(), reverse=True, key=len)

# Recursively replace as much as possible, add up depth on the way back
def search_and_replace(s):
    if s == 'e':
        return 0
    return 1 + next(search_and_replace(s.replace(t, rules[t], 1))
                    for t in sorted_rules if t in s)

print search_and_replace(string)

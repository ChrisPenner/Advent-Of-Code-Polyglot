import re
from collections import defaultdict
nums = re.compile(r'\d+')
name = re.compile(r'(?<=\s)[a-z]+')
funcs = defaultdict(lambda: lambda x, y: x == y) # Nested lambdas
funcs['tree'] = funcs['cats'] = lambda x, y: x > y
funcs['pomeranians'] = funcs['goldfish'] = lambda x, y: x < y
signature = {
    'children': X, 'cats': X, 'samoyeds': X, 'pomeranians': X, 'akitas': X,
    'vizslas': X, 'goldfish': X, 'trees': X, 'cars': X, 'perfumes': X,
}

with open('input.txt') as f:
    for line in f:
        vals, names = map(int, nums.findall(line)), name.findall(line)
        sue_number = vals.pop(0)
        if(all(funcs[name](val, signature[name]) for name, val in zip(names, vals))):
            print sue_number

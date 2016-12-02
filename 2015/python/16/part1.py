import re
nums = re.compile(r'\d+')
name = re.compile(r'(?<=\s)[a-z]+')
signature = {
    'children': X, 'cats': X, 'samoyeds': X, 'pomeranians': X, 'akitas': X,
    'vizslas': X, 'goldfish': X, 'trees': X, 'cars': X, 'perfumes': X,
}

with open('input.txt') as f:
    for line in f:
        vals, names = map(int, nums.findall(line)), name.findall(line)
        sue_number = vals.pop(0)
        if(all(x == y for x, y in zip(map(signature.get, names), vals))):
            print sue_number

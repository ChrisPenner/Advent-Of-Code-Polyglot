import re
parser = re.compile(r'\d+|(?<=\s)[a-z]+')
signature = {
    'children': X, 'cats': X, 'samoyeds': X, 'pomeranians': X, 'akitas': X,
    'vizslas': X, 'goldfish': X, 'trees': X, 'cars': X, 'perfumes': X,
}

with open('input.txt') as f:
    for line in f:
        intify = lambda x: int(x) if x.isdigit() else x
        data = map(intify, parser.findall(line))
        sue_number = data.pop(0)
        names, vals = data[::2], data[1::2]
        if(all(x == y for x, y in zip(map(signature.get, names), vals))):
            print sue_number

import re
parser = re.compile(r'\d+|(?<=\s)[a-z]+')
signature = {
    'children': X, 'cats': X, 'samoyeds': X, 'pomeranians': X, 'akitas': X,
    'vizslas': X, 'goldfish': X, 'trees': X, 'cars': X, 'perfumes': X,
}

def is_valid(name, value):
    if (name == 'tree' or name == 'cats'):
        return value > signature[name]
    if (name == 'pomeranians' or name == 'goldfish'):
        return value < signature[name]
    if signature[name] == value:
        return True
    else:
        return False

with open('input.txt') as f:
    for line in f:
        intify = lambda x: int(x) if x.isdigit() else x
        data = map(intify, parser.findall(line))
        sue_number = data.pop(0)
        names, vals = data[::2], data[1::2]
        if(all(is_valid(name, val) for name, val in zip(names, vals))):
            print sue_number

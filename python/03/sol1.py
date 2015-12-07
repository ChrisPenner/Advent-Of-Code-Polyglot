x, y = 0, 0
houses = set([(x,y)])
with open('input.txt') as f:
    for char in f.read().strip():
        if char == '^':
            y -= 1
        elif char == '>':
            x += 1
        elif char == 'v':
            y += 1
        elif char == '<':
            x -= 1
        houses.add((x,y))

print len(houses)

n = 2
coords = [(0,0)] * n
houses = set([(0,0)])

with open('input.txt') as f:
    chars = f.read()
    # Chunk commands into pieces
    chunks = [chars[i:i+n] for i in xrange(0, len(chars), n)]
    for chunk in chunks:
        for i, instruction in enumerate(chunk):
            x, y = coords[i]
            if instruction == '^':
                y -= 1
            elif instruction == '>':
                x += 1
            elif instruction == 'v':
                y += 1
            elif instruction == '<':
                x -= 1
            houses.add((x,y))
            coords[i] = (x, y)

print len(houses)

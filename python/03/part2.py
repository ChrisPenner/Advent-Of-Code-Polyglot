# The number of people (or robots) delivering
n = 2
# Add a set of coordinates for each person.
coords = [(0,0)] * n
# Keep track of the houses we've visited
houses = set([(0,0)])

with open('input.txt') as f:
    chars = f.read()
    # 'Partition' the list into sets of instructions of length n
    chunks = [chars[i:i+n] for i in xrange(0, len(chars), n)]
    # For each set of instructions
    for chunk in chunks:
        for i, instruction in enumerate(chunk):
            # Get the current coordinates for each person for each instruction
            x, y = coords[i]
            # Adjust position
            if instruction == '^':
                y -= 1
            elif instruction == '>':
                x += 1
            elif instruction == 'v':
                y += 1
            elif instruction == '<':
                x -= 1
            # Add new house
            houses.add((x,y))
            # Store position for next round
            coords[i] = (x, y)

# Count up all the houses.
print len(houses)

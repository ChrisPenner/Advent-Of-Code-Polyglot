# Starting coordinates
x, y = 0, 0
# Keep track of which houses we've visited as a set of tuples
houses = set([(x,y)])
with open('input.txt') as f:
    for char in f.read().strip():
        # Adjust our position
        if char == '^':
            y -= 1
        elif char == '>':
            x += 1
        elif char == 'v':
            y += 1
        elif char == '<':
            x -= 1
        # Add the new house position
        houses.add((x,y))

# Count up all the houses.
print len(houses)

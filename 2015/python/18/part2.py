# These need to stay on.
corners = {(0,0), (0,99), (99,0), (99,99)}
with open('input.txt') as f:
    # Set up the board (use set union to make sure corners are on)
    lights = corners | { (x,y) for y, line in enumerate(f)
                        for x, char in enumerate(line.strip())
                        if char == '#' }

# This returns the number of neighbours that are turned on.
neighbours = lambda x,y: sum((_x,_y) in lights for _x in (x-1, x, x+1)
                            for _y in (y-1, y, y+1) if (_x, _y) != (x, y))

# Do 100 iterations
for c in xrange(100):
    # Calculate new 'lights' from previous one, use a set union to make sure coners are turned 'on'
    lights = corners | { (x,y) for x in xrange(100) for y in xrange(100)
                        if (x,y) in lights and 2 <= neighbours(x,y) <= 3
                        or (x,y) not in lights and neighbours(x,y) == 3 }
print len(lights)

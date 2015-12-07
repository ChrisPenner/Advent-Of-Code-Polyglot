total = 0
with open('input.txt') as f:
    for line in f:
        # Get length, width, and height by splitting the string on 'x's
        l, w, h = (int(n) for n in line.split('x'))
        # Calculate area of each side.
        al, aw, ah = l*w, w*h, h*l
        # Add the smallest area as specified
        total += min(al, aw, ah)
        # And add total area.
        total += 2 * (al + aw + ah)

print total

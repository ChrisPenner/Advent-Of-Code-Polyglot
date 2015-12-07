total = 0
with open('input.txt') as f:
    for line in f:
        # Get length, width, and height by splitting the string on 'x's
        l, w, h = (int(n) for n in line.split('x'))
        # Add volume
        total += l*w*h
        # Add double the length of the two shorter sides.
        total += 2*(l + w + h - max(l, w, h))

print total

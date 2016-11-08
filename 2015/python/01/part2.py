floor = 0
with open('input.txt') as f:
    # Loop over input adding or subtracting until we end up below zero.
    for i, char in enumerate(f.read(), 1):
        if char == '(':
            floor += 1
        elif char == ")":
            floor -= 1
        if floor < 0:
            break;
print i

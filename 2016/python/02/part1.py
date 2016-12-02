from sys import stdin

# Read problem from stdin
instructions = stdin.readlines()

# Multi dimensional lists as a keypad
keypad = [[1, 2, 3],
          [4, 5, 6],
          [7, 8, 9]]

x, y = (1, 1)
max_index = 2
def clamp(n):
    n = max(0, n)
    n = min(max_index, n)
    return n


# Stored as a change of index in the keypad
movements = {
    'U': (-1, 0),
    'R': (0, 1),
    'D': (1, 0),
    'L': (0, -1),
}

# For each line
for line in instructions:
    for c in line.strip():
        # Get deltas
        dx, dy = movements[c]

        # Restrict to keypad
        x, y = (clamp(x + dx), clamp(y + dy))

    # Get key value
    print keypad[x][y]

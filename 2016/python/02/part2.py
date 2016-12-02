from sys import stdin

# Read problem from stdin
instructions = stdin.readlines()

# Multi dimensional lists as a keypad
keypad = [[None, None, '1', None, None],
          [None, '2',  '3', '4'  , None],
          ['5', '6', '7', '8', '9'],
          [None, 'A', 'B', 'C', None],
          [None, None, 'D', None, None]]

x, y = (2, 0)
max_index = 4
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
        px, py = (x, y)
        x, y = (clamp(x + dx), clamp(y + dy))
        if keypad[x][y] is None:
            x, y = px, py

    # Get key value
    print keypad[x][y]

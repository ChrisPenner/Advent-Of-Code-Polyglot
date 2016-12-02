from itertools import permutations

# Store distances
distances = {}

# Get all possible places
places = set()

with open('input.txt') as f:
    for line in f:
        parts = line.split(' ')
        # Unpack values
        frm, _, to, _, amount = parts
        amount = int(amount.strip())
        # Store distance between each set of places
        distances[frm, to] = distances[to, frm] = amount
        # Add to our set of valid places
        places.add(frm)
        places.add(to)

# Get every possible route
possibilities = permutations(places)
# Store route distances as we compute them
totals = []

# Calculate total distance for every route
for route in possibilities:
    total = 0
    for i, frm in enumerate(route):
        if i == len(route) - 1:
            break
        # Get the next element
        to = route[i+1]
        total += distances[(frm, to)]
    totals.append(total)

# Get maximum distance
print max(totals)

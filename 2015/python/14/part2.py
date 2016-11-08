import re
from itertools import islice, cycle, izip
from operator import add

nums = re.compile(r'\d+')

# Make a cycling iterator for each reindeer's pattern
def get_reindeer_cycle(line):
    speed, fly_time, rest_time = map(int, nums.findall(line))
    return cycle([speed] * fly_time + [0] * rest_time)

with open('input.txt') as f:
    reindeer = [ get_reindeer_cycle(line) for line in f ]

# Get the reindeer's movement per second in slices.
race_sequence = islice(izip(*reindeer), time)

# Get empty score and distance records
distances = scores = (0,) * len(reindeer)
time = 2503

for slice in race_sequence:
    # Get new total distances to date
    distances = map(add, distances, slice)
    # Get the winners of the current round, (True, False) is (1, 0) in addition.
    winners = [x == max(distances) for x in distances]
    # Add the scores to the scoreboard
    scores = map(add, scores, winners)

print max(scores)

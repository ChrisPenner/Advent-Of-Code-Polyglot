import re
from itertools import islice, cycle

nums = re.compile(r'\d+')

# Make a cycling iterator for each reindeer's pattern
def get_reindeer_cycle(line):
    speed, fly_time, rest_time = map(int, nums.findall(line))
    return cycle([speed] * fly_time + [0] * rest_time)

with open('input.txt') as f:
    reindeer = [ get_reindeer_cycle(line) for line in f ]

time = 2503

# Sum up the distance travelled per reindeer up to the given time
sums = [sum(islice(r, time)) for r in reindeer]
print max(sums)

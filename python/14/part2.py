import re
from operator import itemgetter
from collections import namedtuple, defaultdict

Reindeer = namedtuple('Reindeer', ['name', 'speed', 'fly_time', 'rest_time', 'cycle_time', 'travel_per_cycle'])
nums = re.compile(r'\d+')
reindeer = []
scores = defaultdict(int)

with open('input.txt') as f:
    for line in f:
        speed, fly_time, rest_time = map(int, nums.findall(line))
        name = line.split(' ')[0]
        cycle_time = fly_time + rest_time
        travel_per_cycle = fly_time * speed
        reindeer.append(Reindeer(name, speed, fly_time, rest_time, cycle_time, travel_per_cycle))


def get_scores(time):
    totals = []
    for r in reindeer:
        # Get floor of number of iterations completed, then multiply to get
        # amount travelled per cycle
        distance_travelled = (time // r.cycle_time) * r.travel_per_cycle
        # Get the amount of time unaccounted for
        leftover = time % r.cycle_time
        # Get the portion times the travel speed, but max out at fly_time amount
        distance_travelled += min(leftover * r.speed, r.fly_time * r.speed)
        totals.append((distance_travelled, r.name))
    return totals

# Calculate scores at each second
for i in xrange(1, 2504):
    totals = get_scores(i)
    biggest = max(totals, key=itemgetter(0))[0]
    for score, name in totals:
        if score == biggest:
            scores[name] += 1

print max(scores.values())

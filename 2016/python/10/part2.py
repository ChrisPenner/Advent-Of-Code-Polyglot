import re
from itertools import *
from sys import stdin
from collections import defaultdict

sinks = re.compile('to (\w+)')
nums = re.compile(r'(\d+)')
getnums = lambda s: map(int, nums.findall(s))
lines = stdin.readlines()

bots = defaultdict(list)
outs = defaultdict(list)

done = set()

# Keep looping over lines until each rule has been resolved
# Why be elegant when you can be quick? :P
while len(done) < len(lines):
    for line in lines:
        # Skip lines we've already processed
        if line in done:
            continue

        # If it's a 'value' line we can always process it
        if line.startswith('value'):
            [v, bot] = getnums(line)
            bots[bot].append(v)
            # print 'added', v
            done.add(line)
            continue

        # Figure out where the sinks are
        [lowsink, highsink] = sinks.findall(line)
        [frm, ldest, hdest] = getnums(line)

        # Get the numbers the bot carries
        ns = bots[frm]

        # If we don't have 2 numbers, then we haven't processed enough info yet,
        # come back later
        if len(ns) < 2:
            continue

        # Get low and high
        low = min(ns)
        high = max(ns)

        # Delegate our microchips
        if lowsink.startswith('out'):
            outs[ldest].append(low)
        else:
            bots[ldest].append(low)
        if highsink.startswith('out'):
            outs[hdest].append(high)
        else:
            bots[hdest].append(high)

        done.add(line)

print outs[0][0] * outs[1][0] * outs[2][0]

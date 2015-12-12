import json
from itertools import chain

with open('input.txt') as f:
    inp = json.load(f)

# Takes a list of values and returns a list of lists
# Uses only the keys from dicts.
def listify(v):
    if isinstance(v, dict):
        values = v.values()
        # Skip the values of any dict containing 'red'
        return values if 'red' not in values else []
    if isinstance(v, list):
        return v
    return [v]

# Takes a list of possibly nested lists/dicts/values and returns them as a flat
# list.
def flatten(v):
    # Once we don't have any more nested lists/dicts, return
    if not any((isinstance(x, list) or isinstance(x, dict)) for x in v):
        return v
    # Make everything a list
    v = map(listify, v)
    # Join all those lists together
    v = list(chain(*v))
    # Recursively flatten
    return flatten(v)

values = flatten(inp)
values = filter(lambda x: isinstance(x, int), values)
print sum(values)

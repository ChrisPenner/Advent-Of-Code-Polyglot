from collections import namedtuple
from operator import mul
import re
nums = re.compile(r'-?\d+')
Ingredient = namedtuple('Ingredient', ['capacity', 'durability', 'flavor', 'texture', 'calories'])
ingredients = []
with open('input.txt') as f:
    for line in f:
        ingredients.append(Ingredient(*map(int, nums.findall(line))))

def get_score(amounts, ings):
    totals = []
    by_ing = zip(*ings)
    for vals in by_ing:
        totals.append(map(lambda x: x[0] * x[1], zip(vals, amounts)))
    next = map(sum, totals)
    calories = next[-1]
    next = next[:-1]
    next = map(lambda x: max(x, 0), next)
    return reduce(mul, next)

all = []

# Go through all combinations
for v in xrange(101):
    print v
    for w in xrange(101-v):
        for x in xrange(101-v-w):
            y = 100-v-w-x
            all.append(get_score([v, w, x, y], ingredients))

print max(all)

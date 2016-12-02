from collections import namedtuple
from operator import mul
import re
nums = re.compile(r'-?\d+')
Ingredient = namedtuple('Ingredient', ['capacity', 'durability', 'flavor', 'texture', 'calories'])
ingredients = set()
with open('input.txt') as f:
    for line in f:
        ingredients.add(Ingredient(*map(int, nums.findall(line))))

def get_score(amounts, ings):
    totals = []
    by_ing = zip(*ings)
    for vals in by_ing:
        totals.append(map(lambda x: x[0] * x[1], zip(vals, amounts)))
    next = map(sum, totals)
    calories = next[-1]
    if calories != 500:
        return 0
    next = next[:-1]
    next = map(lambda x: max(x, 0), next)
    return reduce(mul, next)

all = []

for v in xrange(101):
    for w in xrange(101-v):
        for x in xrange(101-v-w):
            for y in xrange(101-v-w-x):
                all.append(get_score([v, w, x, y], sorted(ingredients)))

print max(all)

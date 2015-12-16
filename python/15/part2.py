from collections import namedtuple
from operator import mul
import re
nums = re.compile(r'-?\d+')
# Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
# Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3
Ingredient = namedtuple('Ingredient', ['capacity', 'durability', 'flavor', 'texture', 'calories'])
ingredients = set()
with open('input.txt') as f:
    for line in f:
        ingredients.add(Ingredient(*map(int, nums.findall(line))))

def get_score(amounts, ings):
    totals = []
    by_ing = zip(*ings)
    # print by_ing
    for vals in by_ing:
        totals.append(map(lambda x: x[0] * x[1], zip(vals, amounts)))
    # print totals
    next = map(sum, totals)
    calories = next[-1]
    if calories != 500:
        return 0
    next = next[:-1]
    next = map(lambda x: max(x, 0), next)
    return reduce(mul, next)

all = []

for v in xrange(101):
    print v
    for w in xrange(101-v):
        for x in xrange(101-v-w):
            for y in xrange(101-v-w-x):
                all.append(get_score([v, w, x, y], sorted(ingredients)))

# 222870
print max(all)
# 117936

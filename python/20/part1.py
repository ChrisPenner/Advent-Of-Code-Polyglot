#!/usr/bin/python3
# -*- coding: utf-8 -*-

# author: coolharsh55
# Harshvardhan J. Pandit

# get the target presents to check for
# divide it by ten to make calculation simpler
# since each elf drops ten presents at each house
# so, house 4 has (10 + 20 + 40) = 70
# which is (1 + 2 + 4) * 10 = 70
# which can be calculated by using (1 + 2 + 4) = 7
#
# the set of presents received by each house
# is the set of factors (unique) including 1 and house no
#
# therefore, by calculating the factors gives us what elves
# will be dropping presents at that house

target_presents = int('XXXXXXXX') // 10

import math
from itertools import chain

# iterate from 1 to target number of presents
for house_no in range(1, target_presents):
    # get the number of presents at this house
    # number of presents is the sum of all factors of this house no
    presents = sum(set(
        # chaining is used to get a single list
        # from the tuple produced in list comprehension
        chain.from_iterable(
            # get the two factors, (x, y) where x * y = house_no
            (i, house_no // i)
            # iterate only upto the square root of house_no
            # as the max factor will be its square root
            for i in range(1, math.ceil(math.sqrt(house_no) + 1))
            # check that i being iterate divides house_no completely
            if house_no % i == 0)))
    # check if presents for this house are the required no of presents
    if presents >= target_presents:
        break

print(house_no)

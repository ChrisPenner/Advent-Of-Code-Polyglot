#!/usr/bin/python
# -*- coding: utf-8 -*-

# author coolharsh55
# Harshvardhan J. Pandit

# store all packages
packages = []

# parse input to get list of packages
with open('./input.txt', 'r') as f:
    for line in f.readlines():
        packages.append(int(line.strip()))

# number of package groups on the sleigh
NO_GROUPS = 3

# calculate the weight of each package group
# since all 3 weigh the same,
# 3 * weight(package_group) = weight(packages)
weight_package_group = sum(packages) // NO_GROUPS

# arbitrary high value for initial minimum quantum entanglement
# will get replaced with whatever first QE is calculated
ARBITRARY_HIGH_VALUE = 999999999999999
min_quantum_entanglement = ARBITRARY_HIGH_VALUE

from functools import reduce
from itertools import combinations
from operator import mul
for no_packages in range(2, len(packages)):
    for arrangement in combinations(packages, no_packages):
        # if the weight is equal,
        # check if the QE is lesser than stored min value
        if sum(arrangement) == weight_package_group:
            min_quantum_entanglement = min(
                min_quantum_entanglement,
                reduce(mul, arrangement))
    # if the min QE value has changed from ARBITRARY HIGH VALUE,
    # we've got the minimum QE value
    if min_quantum_entanglement < ARBITRARY_HIGH_VALUE:
        break

# print package with minimum quantum entanglement
print(min_quantum_entanglement)

#!/usr/bin/python
# -*- coding: utf-8 -*-

# author coolharsh55
# Harshvardhan J. Pandit

# LOGIC
# Given a point (x,y), we need to find the number that occurs
# at that point. To do that, we need to find the diagonal that it belongs to.
# Each diagonal has (i in 1 to x +y-1)∑i numbers.
# Given (x,y), it occurs somewhere between that range.
# In the diagonal, there are always z numbers above it, where
# z is the row of the number - 1.
# Therefore, the position of (x,y) can be translated into number as:
# (i: 1->x+y-1)∑i - x + 1
# which is, sum of all numbers in diagonals, subtracted by the numbers
# still above it, specified by x (row) and adding 1 for itself.

# Code Generation
# First code is 20151125
# Each code after that is:
# (previous * 252533) % 33554393

# point in the manual for the code
point_x, point_y = 2981, 3075

# code seeds
code = 20151125
multiplier = 252533
divisor = 33554393

# number of code (as in index)
number = 0

# I: find out the index number of code

# diagonal is x + y - 1
diagonal = point_x + point_y - 1

for i in range(1, diagonal):
    number += i

# positions to calculate in the final diagonal
# is the length of the diagonal - rows skipped
# + 1 for the number itself
pos_left = diagonal - point_x + 1
for i in range(0, pos_left):
    number += 1

# II: calculate code for given number iteratively

for i in range(2, number + 1):
    code = (code * multiplier) % divisor

print(code)

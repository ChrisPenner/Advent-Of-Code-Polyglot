# Advent of Code 2015 - Day 8 - Matchsticks
# http://adventofcode.com/day/8

with open('input.txt') as f:
    print(sum([len(line.strip()) - len(eval(line)) for line in f]))

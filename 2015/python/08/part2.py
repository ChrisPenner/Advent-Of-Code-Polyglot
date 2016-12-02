# Advent of Code 2015 - Day 8 - Matchsticks - Part 2
# http://adventofcode.com/day/8

with open('input.txt') as f:
    print(sum([line.strip().count('\\') + line.strip().count('"') + 2 for line in f]))

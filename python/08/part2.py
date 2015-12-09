# Advent of Code 2015 - Day 8 - Matchsticks - Part 2
# http://adventofcode.com/day/8

import sys

# Main
print(sum([line.strip().count('\\') + line.strip().count('"') + 2 for line in sys.stdin]))

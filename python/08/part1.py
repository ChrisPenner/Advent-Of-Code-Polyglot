# Advent of Code 2015 - Day 8 - Matchsticks
# http://adventofcode.com/day/8

import sys

# Main
print(sum([len(line.strip()) - len(eval(line)) for line in sys.stdin]))

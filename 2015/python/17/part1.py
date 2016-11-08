from itertools import combinations
containers = [50, 44, 11, 49, 42, 46, 18, 32, 26, 40, 21, 7, 18, 43, 10, 47, 36, 24, 22, 40]

print sum(1 for i in xrange(len(containers))
            for c in combinations(containers, i) if sum(c) == 150)

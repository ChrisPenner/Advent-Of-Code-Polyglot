from sys import stdin
from collections import Counter

lines = stdin.readlines()
getChars = lambda i: [l[i] for l in lines]
print ''.join([
    Counter(getChars(i)).most_common()[-1][0]
    for i in range(8)
])

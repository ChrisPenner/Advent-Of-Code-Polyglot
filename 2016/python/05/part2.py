from hashlib import md5
from itertools import count, islice

key = 'uqwqemis'
result = [None] * 8
hex = lambda i: md5(key + str(i)).hexdigest()
for i in count():
    hash = hex(i)
    if hash.startswith('00000'):
        try:
            ind, char = int(hash[5]), hash[6]
        except:
            continue
        if ind not in range(0, 8) or result[ind]:
            continue
        result[ind] = char
        if all(result):
            print ''.join(result)
            break

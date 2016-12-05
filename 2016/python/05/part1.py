from hashlib import md5
from itertools import count, islice

key = 'uqwqemis'
result = ''
hex = lambda i: md5(key + str(i)).hexdigest()
results = (hex(i)[5] for i in count() 
     if hex(i).startswith('00000'))
print ''.join(islice(results, 8))

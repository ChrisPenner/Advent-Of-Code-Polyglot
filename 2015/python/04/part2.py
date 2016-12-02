from hashlib import md5
from itertools import count
# Count over all numbers from 1 up, grab the first number that when added to our
# input gives us a hash starting with '000000'
print next(i for i in count()
           if md5('XXXXXXXX{}'.format(i)).hexdigest().startswith('000000'))

import re
from itertools import imap

# Magic ASCII number
A = 97

# Can't have these
bad = re.compile(r'i|o|l')

# Must have two pairs
pairs = re.compile(r'([a-z])\1.*([a-z])\2')

# Check if we have a sequence of type 'abc'
def has_sequence(password):
    # Switch chars to numbers
    nums = map(ord, password)
    # This checks if the current three are a run
    has_run = lambda a,b,c: a == b - 1 and b == c - 1
    # This maps our has_run on offset sequences and let's us know if anythin
    # makes a run.
    return any(imap(has_run, nums, nums[1:], nums[2:]))

def get_next_char(c):
    # Reduce number to 0-26 range, then add 1
    base_num = ord(c) - A + 1
    # Convert back to char, keeping within 0-26, then add back up to [a-z] range
    return chr((base_num % 26) + A)

def increment_string(s):
    if not s:
        return ''
    next_char = get_next_char(s[-1:])
    # If we overflow, recursively overflow on earlier substrings
    if next_char == 'a':
        return increment_string(s[:-1]) + 'a'
    next_string = s[:-1] + next_char
    return next_string

# Checks against all required predicates
def is_valid(password):
    return (has_sequence(current_password)
            and pairs.search(current_password)
            and not bad.search(current_password))

current_password = 'vzbxkghb'

while not is_valid(current_password):
    current_password = increment_string(current_password)
print current_password

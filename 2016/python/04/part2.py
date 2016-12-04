import re
from sys import stdin
from collections import Counter
regex = re.compile(r'([a-z-]+)(\d+)\[(.+)\]')
rooms = stdin.readlines()

base = ord('a')


def decrypt(s, n):
    def decrypt_char(c):
        return chr((((ord(c) - base) + n) % 26) + base)
    return ''.join(map(decrypt_char, s))

for room in rooms:
    code, serial, check = regex.match(room).groups()
    new = decrypt(code, int(serial))
    if 'north' in new:
        print serial
        break

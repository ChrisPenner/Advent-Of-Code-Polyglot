from sys import stdin
from collections import defaultdict

lines = stdin.readlines()
reg = defaultdict(int)
reg['c'] = 1
counter = 0
while counter < len(lines):
    line = lines[counter]
    if line.startswith('cpy'):
        _, frm, to = line.split()
        try:
            reg[to] = int(frm)
        except:
            reg[to] = reg[frm]

    if line.startswith('inc'):
        _, frm = line.split()
        reg[frm] += 1

    if line.startswith('dec'):
        _, frm = line.split()
        reg[frm] -= 1

    if line.startswith('jnz'):
        _, guard, new = line.split()
        try:
            flag = int(guard)
        except:
            flag = reg[guard]
        if flag != 0:
            counter += int(new)
            continue
    counter += 1
print reg

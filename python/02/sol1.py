total = 0
with open('input.txt') as f:
    for line in f:
        l, w, h = (int(n) for n in line.split('x'))
        al, aw, ah = l*w, w*h, h*l
        total += min(al, aw, ah)
        total += 2 * (al + aw + ah)

print total

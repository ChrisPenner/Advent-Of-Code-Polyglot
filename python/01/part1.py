with open('input.txt') as f:
    print sum(1 if x == '(' else -1 
              for x in f.read().strip())

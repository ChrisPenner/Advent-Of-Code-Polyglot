with open('input.txt') as f:
    # Sum up the values, +1 if it's '(', -1 otherwise, we assume it's ')'
    print sum(1 if x == '(' else -1 
              for x in f.read().strip())

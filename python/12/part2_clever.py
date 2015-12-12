import json
import re

with open('input.txt') as file:
    filter_red = lambda x: {} if 'red'  in x.values() else x
    inp = json.load(file, object_hook=filter_red)
    print(sum(int(x) for x in re.findall(r'(-?\d+)', str(inp))))

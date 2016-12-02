import json

with open('input.txt') as file:
    filter_red = lambda x: {} if 'red'  in x.values() else x
    inp = json.load(file, object_hook=filter_red)

def sum_numbers_in_json(json):
    if isinstance(json, int):
        return json

    elif isinstance(json, list):
        return sum(sum_numbers_in_json(x) for x in json)

    elif isinstance(json, dict):
        return sum(sum_numbers_in_json(x) for x in json.values())
    return 0

print(sum_numbers_in_json(inp))

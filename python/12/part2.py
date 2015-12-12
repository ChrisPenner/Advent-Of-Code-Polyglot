import json

with open('input.txt') as file:
    inp = json.load(file)

def sum_numbers_in_json(json):
    if isinstance(json, int):
        return json

    elif isinstance(json, list):
        return sum(sum_numbers_in_json(x) for x in json)

    elif isinstance(json, dict):
        values = json.values()
        if 'red' in values:
            return 0
        return sum(sum_numbers_in_json(x) for x in values)
    return 0

print(sum_numbers_in_json(inp))

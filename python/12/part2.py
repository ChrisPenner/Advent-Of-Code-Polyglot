import json

with open('day12-input.txt') as file:
    input = file.read()

def sum_numbers_in_json (json):
    if isinstance(json, int):
        return json

    elif isinstance(json, list):
        return sum(sum_numbers_in_json(x) for x in json)

    elif isinstance(json, dict):
        if 'red' in json.values():
            return 0

        return sum(sum_numbers_in_json(json[x]) for x in json)

    return 0

print(sum_numbers_in_json(json.loads(input)))

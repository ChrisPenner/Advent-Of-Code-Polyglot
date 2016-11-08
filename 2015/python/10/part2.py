import re

inp = 'XXXXXXXX'
# This is a little complicated, we find a digit and capture all of its
# repetitions, in the second capture group we have the single digit itself
repeating_digits = re.compile(r'((\d)\2*)')

for i in range(0,50):
    new_input = ''
    # Unpack into the total match and the single digit.
    for match, character in repeating_digits.findall(inp):
        new_input += str(len(match))
        new_input += character
    inp = new_input

print(len(inp))

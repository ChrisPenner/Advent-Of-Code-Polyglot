import re

input = '1113222113'
returningDigits = re.compile('((\\d)(?:\\2|)+)')

for i in range(0,50):
    newInput = ''
    for match, character in returningDigits.findall(input):
        newInput += str(len(match))
        newInput += character

    input = newInput

print(len(input))

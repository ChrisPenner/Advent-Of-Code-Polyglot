def json = new File('input.txt').text
def numbers = ~/-?\d+/
println json.findAll(numbers).collect({it.toInteger()}).sum()

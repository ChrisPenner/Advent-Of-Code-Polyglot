import re
get_cmd = re.compile("[A-Z]+")
get_args = re.compile("[a-z0-9]+")

# Store functions by their name
funcs = {
    'AND': lambda a,b: a & b,
    'OR': lambda a,b: a | b,
    'LSHIFT': lambda a,b: a << b,
    'RSHIFT': lambda a,b: a >> b,
    'NOT': lambda a: ~a,
}

# Look up symbol, and its definition recursively, saving the results in 
# the wires dict.
def resolve(symbol):
    if isinstance(symbol, int):
        return symbol
    value = wires[symbol]
    if not isinstance(value, tuple):
        return value
    # Value must be a tuple (command, args)
    command, args = value
    if not command:
        # If no command, it must be a simple assignment
        result = resolve(args[0])
        # store result
        wires[symbol] = result
        return result
    else:
        resolved_args = [resolve(x) for x in args]
        result = funcs[command](*resolved_args)
        # store result
        wires[symbol] = result
        return result

wires = {}
with open('input.txt') as f:
    for line in f:
        # Parse the command
        command = get_cmd.search(line)
        # Get all the arguments via regex
        args = get_args.findall(line)
        # Convert numeric arguments to integers
        args = [int(x) if x.isdigit() else x for x in args]
        # Get result of search if we found anything
        if command:
            command = command.group()
        # Get the storage location of the command
        to_wire = args.pop()
        # Store it
        wires[to_wire] = (command, tuple(args))

print resolve('a')

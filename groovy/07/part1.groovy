#!/usr/bin/env groovy

funcs = [
    'OR':     { a, b -> a | b },
    'AND':    { a, b -> a & b },
    'LSHIFT': { a, b -> (a << b) & 0xffff },
    'RSHIFT': { a, b -> (a >> b) & 0xffff },
    'NOT':    { a -> ~a & 0xffff }
]

// k=wire, v=[command, [args]]
// eg: 'y AND ae -> ag' ==> ag: [AND, ['y', 'ae']]
signals = [:]

int resolve(wire) {
    if (wire instanceof Integer) return wire                    // a value -> return it
    def (cmd, args) = signals[wire]
    def value

    if (!cmd) {
        // Another wire
        value = resolve(*args)
    } else {
        // Command is present. Resolve each argument recursively
        def opValues = args.collect { resolve it }
        // Apply operator on resolved values
        value = funcs[cmd](*opValues)
    }

    // Update signals table with value, no more command
    signals[wire] = [null, [value]]
    return value
}

def reCmd = /[A-Z]+/
def reArgs = /[a-z0-9]+/

new File('input.txt').eachLine { line ->                        // eg: 'y AND ae -> ag'
    if (!line) return
    def args = line.findAll(reArgs)                             // eg: ['y', 'ae', 'ag']
    def wire = args.pop()                                       // wire is the last arg, isolate it
    args = args.collect { it.isInteger() ? it as int : it }     // store arg as an int if numeric
    def cmd = line.find(reCmd)                                  // eg: 'AND'
    signals[wire] = [cmd, args]
}

resolve('a')
println "a: ${signals['a'][1][0]}"


/*
Remark: In Java or Groovy, there are no unsigned types, except char, but its semantic
is for text, not for numerical values. Hence we use int (or Integer) and & 0xffff
after the operation to keep 16 bits.
*/

#!/usr/bin/env groovy

// Your MFCSAM result
def sue = [
    'children': 3, 'cats': 7, 'samoyeds': 2, 'pomeranians': 3, 'akitas': 0,
    'vizslas': 0, 'goldfish': 5, 'trees': 3, 'cars': 2, 'perfumes': 1,
]

def rSue = /Sue (\d+):/             // detect aunt number
def rCompound = /(\w+): (\d+)/      // detect compound and its amount

new File('input.txt').eachLine { line ->
    def sueNumber = (line =~ rSue)[0][1] as int
    def compoundsGroup = (line =~ rCompound)
    def compounds =  compoundsGroup.collect({ it }).collectEntries({ [(it[1]): it[2] as int] })
    def foundAunt = compounds.every { k, v -> sue[k] == v }
    if (foundAunt) {
        println sueNumber
        System.exit(0)              // ugly
    }
}


/*
Remarks:

1. You can't 'break' from an 'each' or 'eachLine' closure.
Issuing a 'return' when aunt sue is found would simply bail out
of the current iteration, but the whole file would still be parsed.

Alternatives:
- Accept to read the whole file and waste resources
- Use a legacy Java BufferedReader and a traditional Java loop
- Fiddle with .metaclass to obtain a similar behavior
- Take advantage of the fact that this is a scoped exercise
  where early exit does the trick and hope Santa won't frown.

2. The 'collect({it})' part squashes a Matcher into a plain List
on which 'collectEntries' can be applied.
*/

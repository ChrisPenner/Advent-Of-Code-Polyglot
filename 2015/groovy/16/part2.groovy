#!/usr/bin/env groovy

// Your MFCSAM result
def sue = [
    'children': 3, 'cats': 7, 'samoyeds': 2, 'pomeranians': 3, 'akitas': 0,
    'vizslas': 0, 'goldfish': 5, 'trees': 3, 'cars': 2, 'perfumes': 1,
]

def rSue = /Sue (\d+):/             // detect aunt number
def rCompound = /(\w+): (\d+)/      // detect compound and its amount

def fnEq = { x, y -> x == y }
def fnGt = { x, y -> x > y }
def fnLt = { x, y -> x < y }
def funcs = [:].withDefault { k -> fnEq }
funcs['tree'] = fnGt
funcs['cats'] = fnGt
funcs['pomeranians'] = fnLt
funcs['goldfish'] = fnLt

new File('input.txt').eachLine { line ->
    def sueNumber = (line =~ rSue)[0][1] as int
    def compoundsGroup = (line =~ rCompound)
    def compounds =  compoundsGroup.collect({ it }).collectEntries({ [(it[1]): it[2] as int] })
    def foundAunt = compounds.every { k, v -> funcs[k].call(v, sue[k]) }
    if (foundAunt) {
        println sueNumber
        System.exit(0)              // ugly
    }
}


/* Remarks: see part 1 */

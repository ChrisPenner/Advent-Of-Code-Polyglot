#!/usr/bin/env groovy

def r = /(.*) would (lose|gain) (\d*) happiness units by sitting next to (.*)\./

def people = [] as Set
def preferences = [:]

new File('input.txt').eachLine { line ->
    def groups = (line =~ r)[0]
    def person = groups[1]
    def lose = groups[2] == 'lose'
    def score = groups[3] as int
    if (lose) score = -score
    def nextTo = groups[4]
    people << person
    preferences[[person, nextTo]] = score
}

def seat = { index -> (index >= 0 ? index : index+8) % 8 }

def computeScore = { perm ->
    def count = 0
    perm.eachWithIndex { person, i ->
        count += preferences[[person, perm.get(seat(i-1))]] + preferences[[person, perm.get(seat(i+1))]]
    }
    count
}

println people.permutations().collect(computeScore).max()

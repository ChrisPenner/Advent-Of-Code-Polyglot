#!/usr/bin/env groovy

def r = /(.*) would (lose|gain) (\d*) happiness units by sitting next to (.*)\./

def people = [] as Set
def preferences = [:]       // k=[person, neighbor]; v=score

new File('input.txt').eachLine { line ->
    def groups = (line =~ r)[0]
    def person = groups[1]
    def lose = groups[2] == 'lose'
    def score = groups[3] as int
    if (lose) score = -score
    def neighbor = groups[4]
    people << person
    preferences[[person, neighbor]] = score
}

def computeScore = { table ->
    def count = 0
    table.eachWithIndex { person, i ->
        def left = table[i-1]
        def right = table[(i+1)%8]
        count += (preferences[[person, left]]) + (preferences[[person, right]])
    }
    count
}

println people.permutations().collect(computeScore).max()

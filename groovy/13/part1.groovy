#!/usr/bin/env groovy

def rPerson = ~/[A-Z][a-z]*/
def rScore = ~/\d+/
def sLose = 'lose'

def people = [] as Set
def preferences = [:]       // k=[person, neighbor]; v=score

new File('input.txt').eachLine { line ->
    def (person, neighbor) = line.findAll(rPerson)
    def lose = line.contains(sLose)
    def score = line.find(rScore) as int
    if (lose) score = -score
    people << person
    preferences[[person, neighbor]] = score
}

def computeScore = { table ->
    int count = 0
    table.eachWithIndex { guest, i ->
        def left = table[i-1]
        def right = table[(i+1)%8]
        count += preferences[[guest, left]] + preferences[[guest, right]]
    }
    count
}

println people.permutations().collect(computeScore).max()

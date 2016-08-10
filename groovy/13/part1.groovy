#!/usr/bin/env groovy

import java.util.regex.*

//def r = ~/(.*) would (lose|gain) (\d\d) happiness units by sitting next to (.*)/
def p = Pattern.compile('(.*) would (lose|gain) (\\d*) happiness units by sitting next to (.*)\\.')

def people = [] as Set
def preferences = [:]

new File('input.txt').eachLine { line ->
    def m = p.matcher(line)
    m.find()
    def person = m.group(1)
    def lose = m.group(2) == 'lose'
    def score = m.group(3) as int
    def nextTo = m.group(4)
    if (lose) score = -score
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

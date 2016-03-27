#!/usr/bin/env groovy

// Two letters appear at least twice
def twice = /.*(\w\w).*\1.*/
// At least one letter which repeats with exactly one letter between them
def repeated = /.*(\w)\w\1.*/

def lines = new File('input.txt') as String[]
println lines.count({ it ==~ twice && it ==~ repeated })

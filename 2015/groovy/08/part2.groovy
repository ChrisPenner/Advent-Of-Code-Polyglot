#!/usr/bin/env groovy

def strings = new File('input.txt') as String[]
println strings.collect { 2 + it.count('\\') + it.count('"') }.sum()

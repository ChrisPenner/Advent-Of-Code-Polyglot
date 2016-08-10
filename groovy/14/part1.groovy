#!/usr/bin/env groovy

def duration = 2503             // your puzzle input

def rValue = ~/\d+/             // digits

// Compute distance travelled by a deer
def computeDistance = { line ->
    def (speed, flyTime, restTime) = line.findAll(rValue).collect { it as int }

    def t = duration            // remaining time
    def distance = 0            // distance so far
    def flying = true           // starts flying

    while (t > 0) {
        def d = [flying ? flyTime : restTime, t].min()
        if (flying) {
            distance = distance + speed * d
        }
        t = t - d               // decrease remaining time
        flying = !flying        // switch state
    }

    distance
}

// Read file and compute distances. Find max
def lines = new File('input.txt') as String []
println lines.collect { computeDistance it }.max()

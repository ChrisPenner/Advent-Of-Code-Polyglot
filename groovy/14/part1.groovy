#!/usr/bin/env groovy

// Your puzzle input
def duration = 2503

class Deer {
    int speed, flyTime, restTime

    Deer(values) {
        (speed, flyTime, restTime) = values.collect {it as int}
    }
}

def rValue = ~/\d+/

// Read file and create deers
def lines = new File('input.txt') as String []
def deers = lines.collect { new Deer(it.findAll(rValue)) }

// Compute distance travelled by a deer
def computeDistance = { deer ->
    def t = duration            // remaining time
    def distance = 0            // distance so far
    def flying = true           // starts flying
    def d                       // available duration
    while (t > 0) {
        if (flying) {
            d = [deer.flyTime, t].min()
            distance = distance + deer.speed * d
        } else {
            d = [deer.restTime, t].min()
        }
        t = t - d               // decrease remaining time
        flying = !flying        // switch state
    }

    distance
}

println deers.collect { computeDistance it }.max()

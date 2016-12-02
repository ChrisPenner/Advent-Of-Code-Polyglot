#!/usr/bin/env groovy

def duration = 2503             // your puzzle input

class Deer {
    int speed, flyTime, restTime, remaining, distance, score
    boolean flying = true

    Deer(values) {
        (speed, flyTime, restTime) = values
        remaining = flyTime         // remaining time in current state
    }
}

// Read file and create deers
def lines = new File('input.txt') as String []
def rValue = ~/\d+/
def deers = lines.collect { new Deer(it.findAll(rValue)*.toInteger()) }

// See what happens after each second
(1..duration).each {
    deers.each { deer ->
        if (deer.flying) deer.distance += deer.speed
        // Decrease time in current state
        deer.remaining--
        if (deer.remaining == 0) {
            // Switch state
            deer.flying = !deer.flying
            // Reset remaining time in current state
            deer.remaining = deer.flying ? deer.flyTime : deer.restTime
        }
    }

    // Find leaders (max distance), and award one point
    def leaders = deers.findAll { it.distance == deers*.distance.max() }
    leaders.each { it.score++ }
}

// High score
println deers*.score.max()

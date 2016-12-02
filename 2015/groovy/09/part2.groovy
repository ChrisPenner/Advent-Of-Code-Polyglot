#!/usr/bin/env groovy

// All routes
def routes = [:]

// All places
def places = [] as Set

// Read the routes
new File('input.txt').eachLine { line ->
    def parts = line.split(' ')
    def (from, _1, to, _2, distance) = parts
    distance = distance.toInteger()

    // Store both ways
    routes[[from, to]] = distance
    routes[[to, from]] = distance

    // Add to places
    places << from
    places << to
}

// All trips distances
def totals = []

// Get every possible route
places.eachPermutation { route ->
    def total = 0
    // Compute distance
    for (int i = 0; i < places.size() - 1; i++) {
        def from = route[i]
        def to = route[i+1]
        total += routes[[from, to]]
    }
    totals << total
}

// Shortest distance to cover all places
println totals.max()

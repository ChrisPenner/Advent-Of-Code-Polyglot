#!/usr/bin/env groovy

def deltas = {
    def n = [(-1..1), (-1..1)].combinations() as Set
    n.remove([0, 0])
    n
}.call()

def grid = [] as Set

new File('input.txt').eachLine { line, x ->
    line.eachWithIndex { c, y ->
        if (c == '#') grid << [x-1, y]        // notice the x-y inconsistency!
    }
}

def check = { cell ->
    def (x, y) = cell
    def count = deltas
        .collect({ dx, dy -> [dx + x, dy + y] })
        .count({ i, j -> [i, j] in grid })
    count == 3 && !(cell in grid) || count in [2, 3] && cell in grid
}

def all = [(0..99), (0..99)].combinations()
100.times {
    grid = all.findAll({ cell -> check(cell) }) as Set
}

println grid.size()

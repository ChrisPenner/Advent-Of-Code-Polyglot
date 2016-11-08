#!/usr/bin/env groovy

// Empty grid (K=light, V=intensity)
def grid = [:]

new File('input.txt').eachLine { String instruction ->
	// Boundaries
	def (x1, y1, x2, y2) = instruction.findAll(/(\d+)/).collect { s -> s.toInteger() }

	// Process each light withing boundaries
	(x1..x2).each { x ->
		(y1..y2).each { y ->
			// Current light
			def light = [x, y]
			// Current brightness
			int brightness = light in grid ? grid[light] : 0

			if (instruction.startsWith('turn off')) {
				brightness--
				if (brightness <= 0) grid.remove(light)
				else grid[light] = brightness
			} else if (instruction.startsWith('turn on')) {
				grid[light] = brightness + 1
			} else {
				grid[light] = brightness + 2
			}
		}
	}
}

// Total brightness
println grid.values().sum()

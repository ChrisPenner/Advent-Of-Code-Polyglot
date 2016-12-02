#!/usr/bin/env groovy

Set grid = [] as Set						// empty grid
File f = new File('input.txt')
f.eachLine { String line ->
	// Boundaries
	def (x1, y1, x2, y2) = line.findAll(/(\d+)/).collect { it.toInteger() }

	// Process each light within boundaries
	(x1..x2).each { x ->
		(y1..y2).each { y ->
			def light = [x, y]               // current light
			if (line.startsWith('turn off') || (line.startsWith('toggle') && light in grid)) {
				// action is 'turn off', or 'toggle' and the light is already on -> OFF
				grid.remove light
			} else {
				// action is 'turn off', or 'toggle' and the light is already off -> ON
				grid << light
			}
		}
	}
}

println grid.size()

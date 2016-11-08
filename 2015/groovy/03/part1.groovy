#!/usr/bin/env groovy

String directions = new File('input.txt').text
int x = 0, y = 0
def houses = [] as Set
houses << [x, y]	// starting point included

directions.each { d ->
	switch(d) {
		case '>': y++; break
		case '<': y--; break
		case '^': x--; break
		case 'v': x++; break
	}
	houses << [x, y]
}

println houses.size()

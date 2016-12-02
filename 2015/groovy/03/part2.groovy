#!/usr/bin/env groovy

int n = 2								// Santa and Robo
def coords = []
n.times { coords << [0, 0] }			// a set of coordinates for each worker
def houses = [] as Set					// visited houses
houses << [0, 0]						// starting point included
String directions = new File('input.txt').text

directions.eachWithIndex { d, i ->
	int p = i % n						// 0=Santa, 1=Robo
	def (x, y) = coords[p]				// coordinates of current worker
	switch(d) {
		case '>': y++; break
		case '<': y--; break
		case '^': x--; break
		case 'v': x++; break
	}
	houses << [x, y]
	coords[p] = [x, y]					// save new coordinates
}

println houses.size()

#!/usr/bin/env groovy

def dimensions = new File('input.txt') as String []
int total = dimensions.sum { dims ->
	// Length, width and height by splitting on 'x'
	def (l, w, h) = dims.split('x')*.toInteger()
	// Add volume
	int total = l * w * h
	// Add double the length of the two shorter sides.
	total + 2 * (l + w + h - [l, w, h].max())
}

println total

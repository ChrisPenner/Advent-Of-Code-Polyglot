#!/usr/bin/env groovy

def dimensions = new File('input.txt') as String []
def total = dimensions.sum { dims ->
	// Length, width and height by splitting on 'x'
	def (l, w, h) = dims.split('x')*.toInteger()
	// Calculate area of each side
	def (alw, awh, ahl) = [l*w, w*h, h*l]
	// Wrapping: box area
	def wrapping = 2 * (alw + awh + ahl)
	// Slack: area of the smallest side
	def slack = [alw, awh, ahl].min()
	// surface = wrapping + slack
	wrapping + slack
}

println total

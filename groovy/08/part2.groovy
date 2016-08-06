#!/usr/bin/env groovy

int total = 0
new File('input.txt').each { line ->
	def extra = 2 + line.count('\\') + line.count('"')
	total = total + extra
}

println total

#!/usr/bin/env groovy

int total = 0
new File('input.txt').each { line ->
	def count = 2	// opening+closing double quotes
	line.eachWithIndex { c, i ->
		if (c == '\\' || c == '"') {
			count++
		}
		count++
	}
	total = total + count - line.size()
}

println total

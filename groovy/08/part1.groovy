#!/usr/bin/env groovy

int count(String s) {
	boolean esc = false		// escape char
	int unicode = 0			// counter within unicode sequence
	int i = 0				// count

	// Note: in Groovy, return in a closure means 'next',
	// not 'return from function or method'

	s.each { c ->
		if (unicode) {
			// In unicode sequence. Eat up characters
			unicode--
			return
		}

		// Escape / not escape
		if (!esc) {
			if (c == '\\') {
				esc = true
				return
			} else if (c == '"') {
				return
			}
		} else {
			esc = false
			if (c == 'x') {
				// Unicode placeholder detected
				unicode = 2
			}
		}

		i++
	}

	return i
}


int total = 0
new File('input.txt').each { line ->
	total = total + line.size() - count(line)
}

println total

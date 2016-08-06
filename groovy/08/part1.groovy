#!/usr/bin/env groovy

def counter = { s ->
	// Save original string
	def ss = s

	// Remove first and last chars (double quotes)
	s = s.substring(1, s.length() - 1)

	// Replace \\ and \" by dummy character.
	// Do not replace \\ by \, otherwise the next expression will be wrong.
	// This is ok as we are only counting
	s = s.replaceAll(~/\\["\\]/, '£')

	// Replace \xhh by dummy character
	s = s.replaceAll(~/\\x../, '£')

	// Calculate length differences
	ss.length() - s.length()
}

def strings = new File('input.txt') as String[]
println strings.collect(counter).sum()

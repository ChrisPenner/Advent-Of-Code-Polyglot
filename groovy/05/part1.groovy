#!/usr/bin/env groovy

// At least 3 vowels
def vowels = /(.*[aeiou].*){3,}/
// Double letter somewhere
def doubled = /.*(\w)\1+.*/
// Forbidden letters
def forbiddenStrings = /.*(ab|cd|pq|xy).*/

int niceStrings = 0
new File('input.txt').eachLine { String s ->
	if (s ==~ vowels && s ==~ doubled && (!(s ==~ forbiddenStrings))) niceStrings++
}
println niceStrings

#!/usr/bin/env groovy

String s = new File('input.txt').text
int floor = 0
int i = 1
for (c in s) {
	// Assume only '(' and ')'
	if (c == '(') floor++ else floor--
	if (floor == -1) break
	i++
}

println i


/*
Note:
'each' and 'eachWithIndex' with a closure don't allow to 'break',
hence the traditional for loop.

http://stackoverflow.com/questions/205660/best-pattern-for-simulating-continue-in-groovy-closure
*/

#!/usr/bin/env groovy

String s = new File('input.txt').text
int floor = s.count('(') - s.count(')')

println floor

#!/usr/bin/env ruby

puts File.read('input').chars.reduce(0) { |cf, c| cf + (c == '(' ? 1 : -1) }

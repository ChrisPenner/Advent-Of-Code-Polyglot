#!/usr/bin/env ruby

puts File.read('input').chars.reduce(0) { |curr_floor, char|
  curr_floor + (char == '(' ? 1 : -1)
}

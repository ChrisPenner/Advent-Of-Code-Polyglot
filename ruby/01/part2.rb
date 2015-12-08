#!/usr/bin/env ruby

count = 0
File.read('input').chars.reduce(0) do |curr_floor, char|
  break if curr_floor == -1
  count = count + 1
  curr_floor + (char == '(' ? 1 : -1)
end
puts count

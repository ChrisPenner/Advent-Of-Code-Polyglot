#!/usr/bin/env ruby

n = 0
File.read('input').chars.reduce(0) do |s, c|
  break if s == -1
  n = n + 1
  s + (c == '(' ? 1 : -1)
end
puts n

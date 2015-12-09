#!/usr/bin/env ruby

require 'set'

# monkey-path the Array class
class Array
  def move!(c)
    if c == '^'
      self[1] = self[1] + 1
    elsif c == 'v'
      self[1] = self[1] - 1
    elsif c == '>'
      self[0] = self[0] + 1
    elsif c == '<'
      self[0] = self[0] - 1
    end
  end
end

set = Set.new

input = File.read('input').chars

santa = [0, 0]

set << santa.dup

input.each do |char|
  santa.move! char
  set << santa.dup
end

puts set.length

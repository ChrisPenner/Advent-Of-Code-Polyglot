#!/usr/bin/env ruby

require 'set'

class Claus
  attr_accessor :coords

  def initialize(x, y)
    @coords = [x, y]
  end

  def move!(c)
    if c == '^'
      @coords[1] = @coords[1] + 1
    elsif c == 'v'
      @coords[1] = @coords[1] - 1
    elsif c == '>'
      @coords[0] = @coords[0] + 1
    elsif c == '<'
      @coords[0] = @coords[0] - 1
    end
  end
end

set = Set.new

input = File.read('input').chars

santa = Claus.new(0, 0)

set << santa.coords.dup

input.each do |char|
  santa.move! char
  set << santa.coords.dup
end

puts set.length

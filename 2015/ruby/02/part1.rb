#!/usr/bin/env ruby

puts File.readlines('input').reduce(0) { |sum, line|
  height, width, depth = line.chomp.split(/x/).map{|dim| dim.to_i}.sort
  sum + 3 * height * width + 2 * height * depth + 2 * width * depth
}

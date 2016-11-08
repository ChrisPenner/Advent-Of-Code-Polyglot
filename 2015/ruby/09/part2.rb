#!/usr/bin/env ruby

require 'set'

locations = Set.new
distances = {}

File.readlines('input').each do |line|
  from, dummy1, to, dummy2, distance = line.split(/ /)
  locations.add(from)
  locations.add(to)
  distances[[from, to].sort] = distance.to_i
end

max_dist = 0
locations.to_a.permutation do |ar|
  total_dist = 0
  0.upto(ar.length - 2) do |i|
    total_dist = total_dist + distances[[ar[i], ar[i + 1]].sort]
  end
  max_dist = total_dist if total_dist > max_dist
end

puts max_dist

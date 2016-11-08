#!/usr/bin/env ruby

require 'digest'

md5 = Digest::MD5.new
num_zeros = 6
input = File.read('input').chomp

0.step do |n|
  if md5.hexdigest("#{input}#{n.to_s}")[0, num_zeros] == '0' * num_zeros
    puts n
    break
  end
end

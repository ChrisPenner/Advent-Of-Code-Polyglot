#!/usr/bin/env ruby

def switch(from, to, on)
  from[0].upto(to[0]) do |i|
    from[1].upto(to[1]) do |j|
      $li[i][j] = $li[i][j] + (on ? 1 : -1)
      $li[i][j] = 0 if $li[i][j] < 0        
    end
  end
end

def toggle(from, to)
  from[0].upto(to[0]) do |i|
    from[1].upto(to[1]) do |j|
      $li[i][j] = $li[i][j] + 2
    end
  end
end

$li = []
(0..999).each do |i|
  $li[i] = Array.new(1000, 0)
end

File.readlines('input').each do |line|
  words = line.split(/ /)
  if words[0] == 'turn'
    from = words[2].split(/,/).map{|n|n.to_i}
    to = words[4].split(/,/).map{|n|n.to_i}
    on = (words[1] == 'on')
    switch(from, to, on)
  elsif words[0] == 'toggle'
    from = words[1].split(/,/).map{|n|n.to_i}
    to = words[3].split(/,/).map{|n|n.to_i}
    toggle(from, to)
  end
end

puts $li.flatten.reduce(:+)


#!/usr/local/bin/perl
use strict;
use warnings;
# -
# Advent of Code 2016 - Day 1 - Part 1
#   North => 0
#   East  => 1
#   South => 2
#   West  => 3
# - - - - - - - - - - - - - - - - - - - - - - - - - - #
#   USAGE: perl part1.pl < input_part1.txt
# -

my($input) = <>;              # STDIN
my(@data);                  
my($look,$x,$y,$z) = 0;       # Inits
$z = 0;
$look = 0;                    # Start facing North => 0; 
@data = split(", ",$input);   # Split input into comma delimited array
foreach(@data){               # Each movement order in list
  move($_);
}
print "\n\n";
print "X: ${x}\n";
print "Y: ${y}\n\n";
print "\nZ: ${z}\n";

# - Move direction and length - #
#
#
sub move {
  my($movement) = shift;
  my($dir,$dist) = ($movement =~ /^(.{1})(.*)/);    # First char in $dir, rest in $dist
  print "DIR: ${dir}\n";
  print "DIST: ${dist}\n";
  # - Change direction
  if($dir eq "L"){
    $look--;                    # Increment looking direction
  } elsif($dir eq "R"){
    $look++;                    # Increment looking direction
  } else {
    $z++;
  }
}
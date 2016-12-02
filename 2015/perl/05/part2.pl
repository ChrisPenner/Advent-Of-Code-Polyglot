#!perl -w
use strict;
use warnings;
# - 
# Advent of Code 
# Solution Day-Part 5-2 
# - 
my($ns) = 0;                            # Nice string counter
my($inf) = "input.txt";                 # Input path/filename
open(my $IN,"<",$inf)                   # Open input file
  or die "Unable to open input file!\n";
my(@strs) = <$IN>;                      # Slurp file into array
close($IN);                             # Close input file
foreach(@strs){                         # Each naughty or nice string 
  # 1 liner witchcraft (Regular expressions like these could've been used on part 1 as well)
  if(/(..).*\1/ &&                      # Checking for matching 2 character combos appearing more than once
     /(.).\1/){                         # Checking for (XVX) skip a character match
    $ns++;                              # Increment nice string
  }
}
print "Nice strings: ".$ns."\n";        # Write out result
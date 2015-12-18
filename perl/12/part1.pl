#!perl
use strict;
use warnings;
# - 
# Advent of Code 
# Solution Day-Part 12-1
# - 
my($inf) = "input.txt";               # Input path/filename
my($res) = 0;                         # Result
open(my $IN,"<",$inf)                 # Open input file
  or die "Unable to open input file!\n";
my($dat) = <$IN>;                     # Input data
close($IN);                           # Close input file
my(@nums) = $dat =~ /-?\d+/g;         # Create array of each number found and optional hypen for negative values
foreach(@nums){                       # Each value found in array
  $res += $_;                         # Sum digits together
}
print "Sum of all numbers: ".$res."\n";  # Write out response
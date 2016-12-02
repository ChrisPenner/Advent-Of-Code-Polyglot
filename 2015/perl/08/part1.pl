#!perl -w
use strict;
use warnings;
# - 
# Advent of Code 
# Solution Day-Part 8-1 
# NOTES:
#   $cl = Character length counter (total)
#   $sl = String length counter (total)
#   INFO on eval() http://perldoc.perl.org/functions/eval.html
# - 
my($inf) = "input.txt";               # Input path/filename
my($cl) = 0;                          # Init character length counter
my($sl) = 0;                          # Init string legnth counter 
open(my $IN,"<",$inf)                 # Open input file
  or die "Unable to open input file!\n";
my(@strs) = <$IN>;                    # Slurp file into array
close($IN);                           # Close input file
foreach(@strs){                       # Each string in array
  chomp;                              # Strip CRLF ($_)
  $cl += length($_);                  # Sum character length
  $sl += length(eval($_));            # String length
}
print "CL: ".$cl."\n";
print "SL: ".$sl."\n";
print "Difference: ".($cl-$sl)."\n";
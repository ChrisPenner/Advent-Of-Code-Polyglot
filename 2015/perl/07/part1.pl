#!perl -w
use strict;
use warnings;
# - 
# Advent of Code 
# Solution Day-Part 7-1 
# VALUES: 0 -> 65535 (16 bit signal)
# GATES:
#   -> AND
#   -> OR
#   -> LSHIFT
#   -> RSHIFT
#   -> NOT
# - 
my($inf) = "input.txt";               # Input path/filename
open(my $IN,"<",$inf)                 # Open input file
  or die "Unable to open input file!\n";
open(my $LOG,">","log")               # Open log file
  or die "Unable to open log file!\n";
my(@strs) = <$IN>;                    # Slurp file into array
close($IN);                           # Close input file
foreach(@strs){                       # Each string in array
  chomp($_);                          # Strip CRLF
}
close($LOG);                          # Close log file
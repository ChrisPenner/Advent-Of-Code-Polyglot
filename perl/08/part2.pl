#!perl -w
use strict;
use warnings;
use Data::Dumper;
# - 
# Advent of Code 
# Solution Day-Part 8-2 
# NOTES:
#   "" -> "\"\""
#   "abc" -> "\"abc\""
#   "\x27" -> "\"\\x27\""
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
  my($ln) = Dumper $_;                # Essentially duplicating " , \ characters
  $ln =~ s/^\$VAR1 = //;              # Strip out Data::Dumper line
  $ln =~ s/\;$//;                     # Strip out dumper ;
  $ln =~ s/\"/\\\"/g;                 # " -> \" &  "aaa\"aaa" -> "\"aaa\\\"aaa\""
  $sl += (length($ln)-1);             # Sum total and remove 1
}
print "\nDifference: ".($sl-$cl)."\n\n";
#!perl
use strict;
use warnings;
# - 
# Advent of Code 
# Solution Day-Part 10-1
# Helpful -> http://rosettacode.org/wiki/Look-and-say_sequence
# - 
my($inp) = "3113322113";              # Puzzle input
my($itr) = 40;                        # Iterator
foreach(1..$itr){                     # Loop to required iterator
  $inp = lookandsay($inp);            # Get new input from sub routine call
}
print "Result: ".length($inp)."\n";   # Write out result answer

sub lookandsay{
  my $str = shift;           # Parameter
  $str =~ s/((.)\2*)/length($1) . $2/ge;
  return $str;               # Return result
}


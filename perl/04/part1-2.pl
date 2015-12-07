#!perl -w
use strict;
use warnings;
use Digest::MD5 qw/md5_hex/;
# - 
# Advent of Code 
# Solution Day-Part 4-1 & 4-2
# - 
my($input,$val,$x);
$x = 0;                     # Incrementer
$val = '99';                # Starting point
$input = 'iwrupvqb';        # Chalenege provided input
while ($val !~ m/^00000/){  # Not contain saught for hash
  $x++;                     # Increment
  $val = md5_hex($input.$x); # New hash
}
print "Part 1 - Answer: ".$x."\n";  # Write out to screen

# Part two of challenge
$x = 0;                     # Reinit
$val = '99';                # Reinit
while ($val !~ m/^000000/){ # Not contain saught for hash
  $x++;                     # Increment
  $val = md5_hex($input.$x); # New hash
}
print "Part 2 - Answer: ".$x."\n"; # Write out to screen
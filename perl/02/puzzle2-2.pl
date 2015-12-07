#!perl -w
use strict;
use warnings;
# - 
# Advent of Code 
# Solution Day-Part 2-2
# - 
my($inf) = "input.txt";               # Input path/filename
my($i,$ribbon,$bow,$total) = 0;
open(my $IN,"<",$inf)                 # Open input file
  or die "Unable to open input file!\n";
my(@presents) = <$IN>;                # Slurp file of presents into array
close($IN);                           # Close input file
foreach(@presents){                   # Each dimension set
  $i++;                               # Present counter
  chomp($_);                          # Strip crlf from end of line
  my($l,$w,$h) = split("x",$_);       # Split dimensions
  if($l < $w){                        # length less than width
    if($w < $h){                  
      $ribbon = ($l*2) + ($w*2);      # L,W smallest sides
    } else {                          
      $ribbon = ($l*2) + ($h*2);      # L,H smallest sides
    }
  } else {                            # Width less than length 
    if($l < $h){
      $ribbon = ($l*2) + ($w*2);      # W,H smallest sides
    } else {
      $ribbon = ($w*2) + ($h*2);      # W,H smallest sides
    }
  }
  $bow = $l*$w*$h;
  $total += $ribbon+$bow;
}
print "Total Ribbon length need for ${i} presents: ".$total."\n"; # Write out result
#!perl -w
use strict;
use warnings;
# - 
# Advent of Code 
# Solution Day-Part 2-1
# - 
my($inf) = "input.txt";               # Input path/filename
my($i,$slack,$sqft,$total) = 0;

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
      $slack = $l * $w;               # L,W smallest sides
    } else {                          
      $slack = $l * $h;               # L,H smallest sides
    }
  } else {                            # Width less than length 
    if($l < $h){
      $slack = $l * $w;               # W,H smallest sides
    } else {
      $slack = $w * $h;               # W,H smallest sides
    }
  }
  $sqft = (2*$l*$w) +                 # Present square footage    
          (2*$w*$h) + 
          (2*$h*$l) + 
          $slack;
  $total += $sqft;                    # Add to grand total sqft
}
print "Total Square Foot of ${i} presents: ".$total."\n"; # Write out result
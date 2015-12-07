#!perl -w
use strict;
use warnings;
# - 
# Advent of Code 
# Solution Day-Part 3-1
# - 
my($inf) = "input.txt";               # Input path/filename
my(%house) = ();                      # House hash
my($x,$y);
my($i) = 0;
open(my $IN,"<",$inf)                 # Open input file
  or die "Unable to open input file!\n";
my($mvStr) = <$IN>;                   # String of moves from file
close($IN);                           # Close input file
chomp($mvStr);                        # Strip CRLF
my(@moves) = split("",$mvStr);        # Split into character array
$x = 0; $y = 0;                       # Init set
$house{$x."-".$y} = 1;                # Initial house given present
foreach(@moves){                      # Each move from elf
  if($_ eq ">"){                      # Right on x axis
    $x++;                             # Increment x
  } elsif($_ eq "<"){                 # Left on x axis
    $x--;                             # Decrement x
  } elsif($_ eq "^"){                 # Up on y axis
    $y++;                             # Increment y
  } elsif($_ eq "v"){                 # Down on y axis
    $y--;                             # Decrement y
  }
  $house{$x."-".$y} = 1;             # Present delivered to house(Dont care about indiv gift to duplicate house)
}
foreach my $unh (keys %house){        # Unique house in house hash
  $i++;                               # Increment counter
}
print "\nUnique houses delivered to: ".$i."\n";
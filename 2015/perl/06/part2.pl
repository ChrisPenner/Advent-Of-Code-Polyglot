#!perl -w
use strict;
use warnings;
# - 
# Advent of Code 
# Solution Day-Part 6-2 
# - Commands (Altered for Part 2) - 
# -> Turn on  --> Increase brightness by 1
# -> Turn off --> Decrease brightness by 1 (base of 0) 
# -> Toggle   --> Increase brightness by 2 
# - 
my(%light);                           # Light hash
%light = ();                          # Lights hash (track each lights status)
my($lit) = 0;                         # Lit counter
my($inf) = "input.txt";               # Input path/filename
open(my $IN,"<",$inf)                 # Open input file
  or die "Unable to open input file!\n";
my(@strs) = <$IN>;                    # Slurp file into array
close($IN);                           # Close input file
foreach(@strs){                       # Each light instruction
  chomp($_);                          # Strip CRLF
  my($ln) = $_;                       # Instruction line
  my($x1,$y1,$x2,$y2) = /(\d+),(\d+) through (\d+),(\d+)/g; # Extract ordered pair of coordinates
  my($cmd) = $ln =~ /^(turn on|turn off|toggle)/; # Which command
  for(my $x=$x1; $x <= $x2; $x++){  
    for(my $y=$y1; $y <= $y2; $y++){
      if($cmd eq "turn off"){         # Decrease light brightness
        if(defined($light{$x.",".$y})){ # Light brightness is already set
          if($light{$x.",".$y} > 0){  # Light is atleast on
            $light{$x.",".$y}--;      # Decrease brightness by 1
          } else {                    # Light not yet defined
            $light{$x.",".$y} = 0;    # Set initial brightness of off
          }
        }
      } elsif($cmd eq "turn on"){     # Increse light brightness
        $light{$x.",".$y} += 1;       # Increment brightness by 1;
      } elsif($cmd eq "toggle"){      # Increase light brightness by 2
        if(!(defined($light{$x.",".$y}))){ # Light not yet set
          $light{$x.",".$y} = 2;      # Set initial brightness 
        } else {
          $light{$x.",".$y} += 2;     # Increment brightness by 2
        }
      }
    }
  }
}
# Determine what lights are still on
foreach my $key(keys %light){         # Each unique light{x,y} value
  if($light{$key} >= 1){              # Is light atleast on
    $lit += $light{$key};             # Add light brightness to total
  }
}
print "\nTotal light brightness: ".$lit."\n\n";
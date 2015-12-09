#!perl -w
use strict;
use warnings;
# - 
# Advent of Code 
# Solution Day-Part 6-1 
#
# -> Left log writing in script to aid those less experienced on what exactly is happening
#    behind the scenes with this one. May seem like a lot but it is fairly straight
#    forward. Be warned( The log file is fairly large when complete, 380mb). 
# -> Every action taken on each light is output to the log. 
#    It helped me greatly when ensuring the actions taken were correct. 
# -> For a much faster result, remove lines 21,22 and all { print $LOG } lines
#    as well as the closing $LOG at line 57.
# - 
my(%light);
%light = ();                          # Lights hash (track each lights status)
my($lit) = 0;                         # Lit counter
my($inf) = "input.txt";               # Input path/filename
open(my $IN,"<",$inf)                 # Open input file
  or die "Unable to open input file!\n";
open(my $LOG,">","log")               # Open log file
  or die "Unable to open log file!\n";
my(@strs) = <$IN>;                    # Slurp file into array
close($IN);                           # Close input file
foreach(@strs){                       # Each light instruction
  chomp($_);                          # Strip CRLF
  my($ln) = $_;                       # Instruction line
  print $LOG "Line: ".$ln."\n"; 
  my($x1,$y1,$x2,$y2) = /(\d+),(\d+) through (\d+),(\d+)/g;   # Extract ordered pair of coordinates
  print $LOG "1: ".$x1.",".$y1."\n2: ".$x2.",".$y2."\n\n";
  # Commands
  my($cmd) = $ln =~ /^(turn on|turn off|toggle)/;  # Which command
  print $LOG "Command: ".$cmd."\n";   # Writ out to log
  for(my $x=$x1; $x <= $x2; $x++){  
    for(my $y=$y1; $y <= $y2; $y++){
      if($cmd eq "turn off"){         # Turn off lights
        $light{$x.",".$y} = 0;
        print $LOG "Light off: ".$x.",".$y."\n";
      } elsif($cmd eq "turn on"){     # Turn on lights
        $light{$x.",".$y} = 1;        # Set light on
        print $LOG "Light on: ".$x.",".$y."\n";
      } elsif($cmd eq "toggle"){      # Toggle lights
        if(!(defined($light{$x.",".$y}))){ # Light not yet set
          $light{$x.",".$y} = 1;      # Turn light on
          print $LOG "Light on: ".$x.",".$y."\n";
        } elsif($light{$x.",".$y} == 1){ # Light already on
          $light{$x.",".$y} = 0;      # Turn light off
          print $LOG "Light off: ".$x.",".$y."\n";
        } else {                      # Light off
          $light{$x.",".$y} = 1;      # Turn light on
          print $LOG "Light on: ".$x.",".$y."\n";
        }
      }
    }
  }
}
close($LOG);                          # Close log file
# Determine what lights are still on
foreach my $key(keys %light){   # Each unique light{x,y} value
  if($light{$key} == 1){        # Is light set on
    $lit++;                     # Increment light on counter
  }
}
print "\nNumber of lights on: ".$lit."\n\n";
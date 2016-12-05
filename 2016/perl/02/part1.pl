#!/usr/local/bin/perl
use strict;
use warnings;
# -
# Advent of Code 2016 - Day 2 - Part 1
# - Tyler Normile - #
#   NOTES: 
#     U (up)    = -3
#     D (down)  = +3
#     L (left)  = -1
#     R (right) = +1
# - - - - - - - - - - - - - - - - - - - - - - - - - - #
#   USAGE: perl part1.pl < inputFilename
# -

my(@data,$input,$key,$pwd);             # Inits
while(<>){                              # Get STDIN as input
  $input .= $_;                         # Append to input
}
$pwd = "";                              # Password result
@data = split(/^/m,$input);             # Split input(on CRLF) into array
$key = 5;                               # Starting key
foreach(@data){                         # Each line of instruction (each key)
  $key = getCode($_,$key);              # Perform keys instructions (instruction string, current key)
  $pwd .= $key;                         # Append key to password
}
print "\n Password is: ${pwd}\n";       # Write out result

# - Get keycode via instruction steps - #
#   @PARAM: 
#    * Code instruction string (ULDR etc...)
#    * Current starting key    (1..9)
# - - - - - - - - - - - - - - - - - - - #
#   RETURNS: 
#    * Numeric key code
# -
sub getCode {
  my($inStr,$cur) = @_;                   # Passed param (instruction string, current key)
  my(%dp,@instructions,%lp,%rp,@tmp,%up); # Inits
  @tmp = (2,3,5,6,8,9);                   # Temporary array for RIGHT possibilies
  %rp = map { $_ => 1 } @tmp;             # Possible 'R' movement keypad options
  @tmp = (1,2,4,5,7,8);                   # Temporary array for LEFT possibilies
  %lp = map { $_ => 1 } @tmp;             # Possible 'L' movement keypad options
  @tmp = (4,5,6,7,8,9);                   # Temporary array for DOWN possibilies
  %dp = map { $_ => 1 } @tmp;             # Possible 'D' movement keypad options
  @tmp = (1,2,3,4,5,6);                   # Temporary array for UP possibilies
  %up = map { $_ => 1 } @tmp;             # Possible 'U' movement keypad options
  @instructions = split("",$inStr);       # Split input string into character array
  foreach(@instructions){                 # Each step in instrucions
    if($_ eq "U"){                        # Up instruciton
      if(defined($up{($cur-3)})){         # Movement is valid within hash constraints
        $cur = $cur - 3;                  # Shift current key up
      }
    } elsif($_ eq "D"){                   # Down instruciton
      if(defined($dp{($cur+3)})){         # Movement is valid within hash constraints
        $cur = $cur + 3;                  # Shift current key down
      }
    } elsif($_ eq "L"){                   # Left instruciton
      if(defined($lp{($cur-1)})){         # Movement is valid within hash constraints
        $cur = $cur - 1;                  # Shift current key to left
      }
    } elsif($_ eq "R"){                   # Right instruciton
      if(defined($rp{($cur+1)})){         # Movement is valid within hash constraints
        $cur = $cur + 1;                  # Shift current key to right
      }
    }
  }
  return $cur;                            # Return result code
}
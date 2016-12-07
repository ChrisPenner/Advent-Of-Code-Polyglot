#!/usr/local/bin/perl
use strict;
use warnings;
# -
# Advent of Code 2016 - Day 2 - Part 2
# - Tyler Normile - #
#   NOTES: 
#     U (up)    = 
#     D (down)  = 
#     L (left)  = 
#     R (right) = 
# - - - - - - - - - - - - - - - - - - - - - - - - - - #
#   USAGE: perl part2.pl < inputFilename
# -

my($char,@data,$input,$key,$pwd);       # Inits
while(<>){                              # Get STDIN as input
  $input .= $_;                         # Append to input
}
$pwd = "";                              # Password result
@data = split(/^/m,$input);             # Split input(on CRLF) into array
$key = 5;                               # Starting key
foreach(@data){                         # Each line of instruction (each key)
  $key = getCode($_,$key);              # Perform keys instructions (instruction string, current key)
  if($key == 10){                       # Numeric to alpha conversion for greater than 9
    $char = "A";
  } elsif($key == 11){
    $char = "B";
  } elsif($key == 12){
    $char = "C";
  } elsif($key == 13){
    $char = "D";
  } else {                              # Standard numeric key
    $char = $key;
  }
  $pwd .= $char;                         # Append key to password
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
  my(%dp,@instructions,%id,%iu,,%ir,%il,%lp,%rp,@tmp,%up); # Inits
  @tmp = (3,4,6,7,8,9,11,12);             # Temporary array for RIGHT possibilies
  %rp = map { $_ => 1 } @tmp;             # Possible 'R' movement keypad options
  @tmp = (2,3,5,6,7,8,10,11);             # Temporary array for LEFT possibilies
  %lp = map { $_ => 1 } @tmp;             # Possible 'L' movement keypad options
  @tmp = (3,6,7,8,10,11,12,13);           # Temporary array for DOWN possibilies
  %dp = map { $_ => 1 } @tmp;             # Possible 'D' movement keypad options
  @tmp = (11,6,7,8,2,3,4,1);              # Temporary array for UP possibilies
  %up = map { $_ => 1 } @tmp;             # Possible 'U' movement keypad options
  @tmp = (5,2,1,4,9);                     # Temporary array for invalid UP movemeents
  %iu = map { $_ => 1 } @tmp;             # Invalid UP starting keys
  @tmp = (10,12,13,5,9);                  # Temporary array for invalid DOWN movemeents
  %id = map { $_ => 1 } @tmp;             # Invalid DOWN starting keys
  @tmp = (1,2,5,10,13);                   # Temporary array for invalid LEFT movemeents
  %il = map { $_ => 1 } @tmp;             # Invalid LEFT starting keys
  @tmp = (1,4,9,12,13);                   # Temporary array for invalid RIGHT movemeents
  %ir = map { $_ => 1 } @tmp;             # Invalid RIGHT starting keys
  @instructions = split("",$inStr);       # Split input string into character array
  foreach(@instructions){                 # Each step in instrucions
    if($_ eq "U"){                        # Up instruciton
      if(!defined($iu{$cur})){            # Not apart of invalid set
        if(defined($up{$cur-4})){         # Movement is valid within hash constraints
          $cur = $cur - 4;                # Shift current key up
          print "U: ${cur}\n";
        } elsif($cur == 3 || $cur == 13){ # Special ase, decrement only 2
          $cur = $cur - 2;                # Shift current key up
        }
      } 
    } elsif($_ eq "D"){                   # Down instruciton
      if(!defined($id{$cur})){            # Not apart of invalid set
        if(defined($dp{$cur+4})){         # Movement is valid within hash constraints
          $cur = $cur + 4;                # Shift current key down
          print "D: ${cur}\n";
        } elsif($cur == 11 || $cur == 1){ # Special case, increment only 2
          $cur = $cur + 2;                # Shift current key down
        }
      }
    } elsif($_ eq "L"){                   # Left instruciton
      if(!defined($il{$cur})){            # Not apart of invalid set
        if(defined($lp{$cur-1})){         # Movement is valid within hash constraints
          $cur = $cur - 1;                # Shift current key left
        }
      }
    } elsif($_ eq "R"){                   # Right instruciton
      if(!defined($ir{$cur})){            # Not apart of invalid set
        if(defined($rp{$cur+1})){         # Movement is valid within hash constraints
          $cur = $cur + 1;                # Shift current key right
        }
      }
    }
  }
  return $cur;                            # Return result code
}
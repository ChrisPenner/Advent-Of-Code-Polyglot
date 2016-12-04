#!/usr/local/bin/perl
use strict;
use warnings;
# -
# Advent of Code 2016 - Day 1 - Part 2
# - Tyler Normile - #
#   North => 0
#   East  => 1
#   South => 2
#   West  => 3
# - - - - - - - - - - - - - - - - - - - - - - - - - - #
#   USAGE: perl part2.pl < inputFilename
# -

my($input) = <>;                        # STDIN
my(@data,$fnd,$i,%location,$look,$x,$y);# Inits
$fnd = "";                              # Found coordinates
$i = 0;                                 # General move counter
$x = 0;                                 # X distance
$y = 0;                                 # Y distance

%location = ();                         # Locations hash (Key = X,Y coordinates of moves)
$look = 0;                              # Start facing North => 0; 
@data = split(", ",$input);             # Split input(comma space) into array
foreach(@data){                         # Each movement order in list
  $fnd = move($_);                      # Perform movement with input     
  $i++;                                 # Increment move counter (each input)
  if($fnd ne ""){                       # Move return not empty (found solution to part2)
    print "\nFound Headquarters: ${fnd}\n"; # Output part2 (x,y Coordinates) we visited twice
    my(@tmp) = split(",",$fnd);         # Split result coordinates on comma (Xy,Y)
    print "\nToal distance away: ".($tmp[0]+$tmp[1])."\n\n"; # Output part2 solution total 
    last;                               # Break out of loop
  }
}

# - Move direction and distance - #
#   -> Update looking direction
#   -> Track distance traveled across X and Y planes
#   @PARAM: 
#    * Movement direction (L|R) and distance (###) (e.g. R185)
#   RETURNS: 
#    -> Result solution key (X,Y) or null if not yet solved
# -
sub move {
  my($movement) = shift;          # Movement parameter (X###)
  my($dir,$dist) = ($movement =~ /^(.{1})(.*)/); # First char in $dir, rest in $dist
  my($key,$res);                  # Inits
  $key = "";                      # location hash key
  $res = "";                      # Result from chkLocation(); (part2 solution coordinates)
  # - Change direction - #
  if($dir eq "L"){                # Left direction
    $look--;                      # Decrement looking direction
  } elsif($dir eq "R"){           # Right direction
    $look++;                      # Increment looking direction
  }
  
  # - Adjust looking direction - #
  if($look < 0){ $look = 4 - abs($look); }  # If $look is negative subtract that number form 4
  # Instead of using the absolute value of $look above, could do (4 + $look)
  $look = $look % 4;              # Check for modulus change in direction

  # Adjust distance with direction (think of this as a grid(X,Y))
  if($look == 0){                 # Looking North
    for(my $d = 1; $d <= $dist; $d++){ # Cycle through (X,Y) points while moving north
      $key = $x.",".($y+$d);      # Build hash key with X,Y
      $res = chkLocation($key);   # Check locaiton 
      if($res ne ""){ last; }     # Break out of for if solved 
    }
    $y = $y + $dist;              # Distance moved North    
  } elsif($look == 1){            # Looking East
    for(my $d = 1; $d <= $dist; $d++){ # Cycle through (X,Y) points while moving east
      $key = ($x+$d).",".$y;      # Build hash key with X,Y    
      $res = chkLocation($key);   # Check locaiton
      if($res ne ""){ last; }     # Break out of for if solved
    }
    $x = $x + $dist;              # Distance moved East
  } elsif($look == 2){            # Looking South
    for(my $d = -1; $d >= $dist; $d--){ # Cycle through (X,Y) points while moving south
      $key = $x.",".($y-$d);      # Build hash key with X,Y    
      $res = chkLocation($key);   # Check locaiton       
      if($res ne ""){ last; }     # Break out of for if solved 
    }
    $y = $y - $dist;              # Distance moved South
  } elsif($look == 3){            # Looking West
     for(my $d = -1; $d >= $dist; $d--){ # Cycle through (X,Y) points while moving west
      $key = ($x-$d).",".$y;      # Build hash key with X,Y    
      $res = chkLocation($key);   # Check locaiton       
      if($res ne ""){ last; }     # Break out of for if solved
    }
    $x = $x - $dist;              # Distance moved West
  }
  return $res;                    # Return result (empty unless part2 is solved)
}
# - Check location - # 
# -
sub chkLocation {
  my($key) = shift;               # Passed param (X,Y)
  if(defined($location{$key})){   # Second time visiting location
    return $key;                  # Return key (X,Y)
  } else {                        # First time visiting location
    $location{$key} = $i;         # Add new location coordinates to visited
    return "";                    # Return empty
  }
}
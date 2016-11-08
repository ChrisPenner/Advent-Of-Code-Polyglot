#!perl -w
use strict;
use warnings;
# - 
# Advent of Code 
# Solution Day-Part 5-1 
# - 
my($ns) = 0;                          # Nice string counter
my($cond) = 0;                        # Condition init
my($inf) = "input.txt";               # Input path/filename
open(my $IN,"<",$inf)                 # Open input file
  or die "Unable to open input file!\n";
my(@strs) = <$IN>;                    # Slurp file into array
close($IN);                           # Close input file
foreach(@strs){                       # Each naughty or nice string           
  chomp($_);                          # Strip out crlf
  my($str) = $_;                      # String in array
  # Check bad requirements first
  if(!($str =~ m/(ab|cd|pq|xy)/)){   # Does not contain bad substring
    # Check for good requirements
    if($str =~ m/[aeiou].*[aeiou].*[aeiou]/){ # Contains 3 insances of voewls, probably a better way avail than repeating
      # Must be double letter next to eachother not in entire string
      my(@crarr) = split("",$str);     # Split string into char array
      for(my $i = 0; $i <= $#crarr; $i++){  # Each character in array
        if(exists($crarr[$i+1])){           # Next chracter in array exists(not the end of string) 
          if($crarr[$i] eq $crarr[$i+1]){   # Does next character match currrent character
            $ns++;                      # Increment nice string
            last;                       # Break out of for loop
          }  
        }
      }
    } # Else bad string
  } # Else bad string
}
print "Nice strings: ".$ns."\n";      # Write out result
#!perl -w
use strict;
use warnings;
# - 
# Advent of Code 
# Solution Day-Part 9-1 
# Permute -> http://search.cpan.org/~dapm/perl-5.14.4/pod/perlfaq4.pod#How_do_I_permute_N_elements_of_a_list?
# ALT Solution -> http://search.cpan.org/~edpratomo/Algorithm-Permute-0.12/Permute.pm
# LOCATIONS:
#   -> Snowdin
#   -> AlphaCentauri
#   -> Arbre
#   -> Norrath
#   -> Tambi
#   -> Straylight
#   -> Tristram
#   -> Faerun
# - 
my($inf) = "input.txt";               # Input path/filename
my(%loc) = ();                        # Locations hash
my($res);                             # Results (Shortest distance)
open(my $IN,"<",$inf)                 # Open input file
  or die "Unable to open input file!\n";
my(@strs) = <$IN>;                    # Slurp file into array
close($IN);                           # Close input file
foreach(@strs){                       # Each string in array
  chomp;                              # Strip CRLF ($_)
  my($loc1,$loc2,$dist) = /(\w+) to (\w+) = (\d+)/g;
  $loc{$loc1}{$loc2} = $dist;         # Add locations to hash
  $loc{$loc2}{$loc1} = $dist;         # Add reversed locations to hash
}
permutator([keys %loc], []);          # Permute sub routine call

print "Shortest Distance: ".$res."\n";# Write out output

# Permute routine
sub permutator {
  my @items = @{$_[0]};     # Depart and Arrival locations
  my @perms = @{$_[1]};     # Distances
  if(!(@items)){            
    my $d = 0;              # Init distance
    for(my $i=0; $i < $#perms; $i++){ # Each distance
      $d += $loc{$perms[$i]}{$perms[$i+1]}; # Sum distance
    }
    if(!($res) || ($d<$res)){
      $res = $d;            # Set result to distance
    }
  } else {
    my(@newitems,@newperms,$i);
    foreach $i (0 .. $#items){
      @newitems = @items;
      @newperms = @perms;
      unshift(@newperms, splice(@newitems, $i, 1));
      permute([@newitems], [@newperms]); # Recursion,Recursion
    }
  }
}
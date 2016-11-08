# Preamble: Fields look like a set of numbers.
# We also have a total amount of paper.
BEGIN { FPAT="([0-9]+)"; total = 0; };

# Helper function because awk doesn't have it.
# Fun fact: also works on STRINGS, BALLS and CHEESE.
function min(a, b) {
    if(a<b) return a;
    return b;
}

# The main body of our program (matches any record)

{
    # $1 -> length
    # $2 -> width
    # $3 -> height
    al = $1 * $2;
    aw = $2 * $3;
    ah = $1 * $3;
    # Get the smallest area side.
    small = min(al, min(ah, aw));
    # Add it to our accumulator.
    total += small;
    # And add the area of our box.
    total += 2 * ( al + aw + ah );
}

END { printf("Elves need %d total paper\n", total); };

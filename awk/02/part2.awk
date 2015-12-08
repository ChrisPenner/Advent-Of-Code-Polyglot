# This is the preamble
# We define that fields look like a series of numbers.
# We're mostly not going to see changing field sizes.
BEGIN { FPAT="([0-9]+)"; ribbon_ft = 0; };

# Helper function: Awk doesn't have min() built in.
function max(a, b) {
    if(a>b) return a;
    else return b;
}

# The main body of our program (handles any record)
{
    len = $1;
    width = $2;
    height = $3; 

    # bow is simply lots of ribbon.
    bow = len * width * height;

    # Our problem is to determine the following:
    # The area of the smallest face
    # such that a 1 x 2 x 3 package is
    # ( 1 + 1 ) + ( 2 + 2 ) = 2+4 = 6 ft
    a = len+len;
    b = width+width;
    c = height+height;
    
    #
    # What this does is sum up the sides
    # and then remove the biggest side.
    # 
    perim = (a+b+c) - (max(a, max(b, c)));

    ribbon_ft += perim+bow;
};
END { printf("ribbon purchase = %d ft\n", ribbon_ft); }

/**
 *
""" --- Day 2: I Was Told There Would Be No Math ---

The elves are running low on wrapping paper,
and so they need to submit an order for more.
They have a list of the dimensions (length l, width w, and height h)
of each present, and only want to order exactly as much as they need.

Fortunately, every present is a box (a perfect right rectangular prism),
which makes calculating the required wrapping paper for each
gift a little easier: find the surface area of the box,
which is 2*l*w + 2*w*h + 2*h*l.
The elves also need a little extra paper for each present:
the area of the smallest side.

For example:

A present with dimensions 2x3x4 requires
2*6 + 2*12 + 2*8 = 52 square feet of wrapping paper
plus 6 square feet of slack, for a total of 58 square feet.
A present with dimensions 1x1x10 requires
2*1 + 2*10 + 2*10 = 42 square feet of wrapping paper
plus 1 square foot of slack, for a total of 43 square feet.
All numbers in the elves' list are in feet.
How many total square feet of wrapping paper should they order?

--- Part Two ---

The elves are also running low on ribbon.
Ribbon is all the same width,
so they only have to worry about the length they need to order,
which they would again like to be exact.

The ribbon required to wrap a present
is the shortest distance around its sides,
or the smallest perimeter of any one face.
Each present also requires a bow made out of ribbon as well;
the feet of ribbon required for the perfect bow is
equal to the cubic feet of volume of the present.
Don't ask how they tie the bow, though; they'll never tell.

For example:

 - A present with dimensions 2x3x4 requires
    2+2+3+3 = 10 feet of ribbon to wrap the present
    plus 2*3*4 = 24 feet of ribbon for the bow,
    for a total of 34 feet.
 - A present with dimensions 1x1x10 requires
    1+1+1+1 = 4 feet of ribbon to wrap the present
    plus 1*1*10 = 10 feet of ribbon for the bow,
    for a total of 14 feet.

How many total feet of ribbon should they order?
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


struct Answer {
    long packing_paper;  // area of packing paper
    long ribbon_length;  // length of ribbon
} answer;

/**
 * Solve the problem
 * @param const char **filename file containing the input
 * @return struct Answer total packing paper required and ribbon length
 */
void solve(const char *filename) {
    FILE *fp;  // file pointer for input file
    char *line = NULL;  // line read from file
    ssize_t read;  // bytes read from line in file
    size_t len = 0;  // length of line

    char *token = NULL;  // tokenized string
    char *str_end;  // end character of tokenized string

    long sides[3];  // sides of package
    long max = 0;  // maximum side in current package

    int i = 0;  // temporary interger counter

    // Open and read the file
    fp = fopen(filename, "r");

    // Read the file line by line stopping at EOF,
    // when read gets a value of -1 from getline
    while((read = getline(&line, &len, fp)) != -1) {
        // Tokenize the string by separating at 'x' character
        token = strtok(line, "x");

        // For each token, convert it to int,
        // and assign it to the package sides array
        for (i=0; i<3; i++, token=strtok(NULL, "x")) {
            sides[i] = strtol(token, &str_end, 10);
        }

        // Add the areas of each side of the package
        // The (x+1) % 3 will always return the values between 0 and 2
        for (i=0; i<3; i++) {
            answer.packing_paper += 2 * sides[i] * sides[(i+1) % 3];
        }

        // Get the maximum dimension of the package.
        // This will be used to select the two smallest sides,
        // which will make up the smallest area on the package.
        for (i=1, max=0; i<3; i++) {
            if (sides[max] < sides[i]) {
                max = i;
            }
        }

        // Add the two area covered by the two smallest sides.
        // The (x+1) % 3 and (x+2) % 3 will ensure that the
        // correct sides are chosen irrespective of which is the max side.
        // f(x) -> y,z : the other sides on the package
        // x,y,z : max() = 2. min() = 0
        // min1(x) -> x+1 (next side) modulo 3 (to wrap around if needed)
        // min2(x) -> x+2 (second side) modulo 3 (to wrap around if needed)
        answer.packing_paper += sides[(max + 1) % 3] * sides[(max + 2) % 3];

        // Length of ribbon paper required to wrap around the package
        // is twice the sides of two smallest sides.
        // Which is all sides except the max one.
        answer.ribbon_length += 2 * (sides[(max + 1) % 3] + sides[(max + 2) % 3]);

        // Ribbon required for the bow is volume of the package
        answer.ribbon_length += sides[0] * sides[1] * sides[2];
    }

    // Close the file
    fclose(fp);

    // Free any memory occupied by line pointed
    if (line) {
        free(line);
    }
}

int main(int args, char **argv)
{
    solve("./input.txt");
    printf("%ld sq.ft of packing_paper, %ld ft of ribbon.\n",
        answer.packing_paper, answer.ribbon_length);

    return 0;
}

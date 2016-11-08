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
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


/**
 * Solve the problem
 * @param const char **filename file containing the input
 * @return long total packing paper required
 */
long solve(const char *filename) {
    FILE *fp;  // file pointer for input file
    char *line = NULL;  // line read from file
    ssize_t read;  // bytes read from line in file
    size_t len = 0;  // length of line

    char *token = NULL;  // tokenized string
    char *str_end;  // end character of tokenized string

    long sides[3];  // sides of package
    long max = 0;  // maximum side in current package

    int i = 0;  // temporary interger counter

    long packing_paper = 0;  // area of packing paper

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
            packing_paper += 2 * sides[i] * sides[(i+1) % 3];
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
        packing_paper += sides[(max + 1) % 3] * sides[(max + 2) % 3];
    }

    // Close the file
    fclose(fp);

    // Free any memory occupied by line pointed
    if (line) {
        free(line);
    }

    return packing_paper;
}

int main(int args, char **argv)
{
    long answer = 0;

    answer = solve("./input.txt");
    printf("%ld\n", answer);

    return 0;
}

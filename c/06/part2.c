/**
 * --- Day 6: Probably a Fire Hazard ---

Because your neighbors keep defeating you in the holiday house
decorating contest year after year,
you've decided to deploy one million lights in a 1000x1000 grid.

Furthermore, because you've been especially nice this year,
Santa has mailed you instructions
on how to display the ideal lighting configuration.

Lights in your grid are numbered from 0 to 999 in each direction;
the lights at each corner are at 0,0, 0,999, 999,999, and 999,0.
The instructions include whether to turn on, turn off,
or toggle various inclusive ranges given as coordinate pairs.
Each coordinate pair represents opposite corners of a rectangle, inclusive;
a coordinate pair like 0,0 through 2,2
therefore refers to 9 lights in a 3x3 square.
The lights all start turned off.

To defeat your neighbors this year,
all you have to do is set up your lights by doing the
instructions Santa sent you in order.

For example:

turn on 0,0 through 999,999 would turn on (or leave on) every light.
toggle 0,0 through 999,0 would toggle the first line of 1000 lights,
turning off the ones that were on, and turning on the ones that were off.
turn off 499,499 through 500,500 would turn off
(or leave off) the middle four lights.

After following the instructions, how many lights are lit?

--- Part Two ---

You just finish implementing your winning light pattern when you realize
you mistranslated Santa's message from Ancient Nordic Elvish.

The light grid you bought actually has individual brightness controls;
each light can have a brightness of zero or more.
The lights all start at zero.

The phrase turn on actually means that you should
increase the brightness of those lights by 1.

The phrase turn off actually means that you should
decrease the brightness of those lights by 1, to a minimum of zero.

The phrase toggle actually means that you should
increase the brightness of those lights by 2.

What is the total brightness of all lights combined
after following Santa's instructions?

For example:

turn on 0,0 through 0,0 would increase the total brightness by 1.
toggle 0,0 through 999,999 would increase the total brightness
by 2000000.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <regex.h>


typedef enum {OFF, ON, TOGGLE} Command;

const char* commands[] = {
    "turn off ",
    "turn on ",
    "toggle ",
};

const char* pattern = "([a-zA-Z]+ *[a-zA-Z]*) ([0-9]+),([0-9]+) through ([0-9]+),([0-9]+)";
regex_t r_compiled;



Command parse_command(char* line)
{
    if (strstr(line, "toggle")) {
        return TOGGLE;
    } else if (strstr(line, "turn off")) {
        return OFF;
    } else if (strstr(line, "turn on")) {
        return ON;
    }
    return OFF;
}


int main(int argc, char** argv)
{
    FILE* fp = NULL;  // file pointer for input file
    char* line = NULL;  // line of input
    size_t len = 0;  // length of input read
    ssize_t read = 0;  // length of line

    int regex_error = 0;  // regex error in execution
    regmatch_t pm[6];  // regex matches
    long offset = 0;  // offset of regex match
    int r_len = 0;  // length of matched object
    char result[256];  // buffer to hold match
    char* end;  // end pointer used in string conversions

    // false: OFF; true: ON
    // also works with enum Command
    long lights[1000][1000] = { 0 };  // lights 2D array

    long start_pos[2];  // starting position of command
    long end_pos[2];  // ending position of command

    long i = 0;  // temp ; x-axis
    long j = 0;  // temp ; y-axis

    long brightness = 0;  // counter for brightness

    Command command = OFF;  // parsed command

    // Compile regex
    if (regcomp(&r_compiled, pattern, REG_EXTENDED)) {
        printf("Regex compilation error.\n");
        return -1;
    }

    // open and read file line by line
    fp = fopen("./input.txt", "r");
    while((read=getline(&line, &len, fp)) != -1) {

        // execute regex to extract matches
        // if there's any error, exit the program
        regex_error = regexec(&r_compiled, line, 6, pm, REG_EXTENDED);
        if (regex_error == REG_NOMATCH) {
            printf("No matches.\n");
            return -1;
        }

        // COMMAND
        // get length of command, and copy to buffer.
        r_len = pm[1].rm_eo - pm[1].rm_so;
        memcpy(result, line + pm[1].rm_so, r_len);
        result[len] = '\0';  // set
        // parse result into enum Command
        command = parse_command(result);

        // START POS (x)
        len = pm[2].rm_eo - pm[2].rm_so;
        start_pos[0] = strtol(line + pm[2].rm_so, &end, 10);

        // START POS (y)
        len = pm[3].rm_eo - pm[3].rm_so;
        start_pos[1] = strtol(line + pm[3].rm_so, &end, 10);

        // END POS (x)
        len = pm[4].rm_eo - pm[4].rm_so;
        end_pos[0] = strtol(line + pm[4].rm_so, &end, 10);

        // END POS (y)
        len = pm[5].rm_eo - pm[5].rm_so;
        end_pos[1] = strtol(line + pm[5].rm_so, &end, 10);

        // Set lights brightness
        for (i=start_pos[0]; i<=end_pos[0]; i++) {
            for (j=start_pos[1]; j<=end_pos[1]; j++) {
                if (command == OFF) {
                    if (lights[i][j] > 0) {
                        lights[i][j] -= 1;
                    }
                } else if (command == ON) {
                    lights[i][j] += 1;
                } else if (command == TOGGLE) {
                    lights[i][j] += 2;
                }
            }
        }
    }

    // Calculate the total brightness of lights
    for (i=0, brightness=0; i<1000; i++) {
        for (j=0; j<1000; j++) {
            brightness += lights[i][j];
        }
    }
    printf("%ld\n", brightness);

    regfree(&r_compiled);
    fclose(fp);

    return 0;
}
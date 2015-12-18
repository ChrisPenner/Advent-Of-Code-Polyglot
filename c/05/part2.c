/**
 * --- Day 5: Doesn't He Have Intern-Elves For This? ---

Santa needs help figuring out which strings in his text file are naughty or nice.

A nice string is one with all of the following properties:

It contains at least three vowels (aeiou only), like aei, xazegov, or aeiouaeiouaeiou.
It contains at least one letter that appears twice in a row, like xx, abcdde (dd), or aabbccdd (aa, bb, cc, or dd).
It does not contain the strings ab, cd, pq, or xy, even if they are part of one of the other requirements.
For example:

ugknbfddgicrmopn is nice because it has at least three vowels (u...i...o...), a double letter (...dd...), and none of the disallowed substrings.
aaa is nice because it has at least three vowels and a double letter, even though the letters used by different rules overlap.
jchzalrnumimnmhp is naughty because it has no double letter.
haegwjzuvuyypxyu is naughty because it contains the string xy.
dvszwmarrgswjxmb is naughty because it contains only one vowel.
How many strings are nice?

--- Part Two ---

Realizing the error of his ways, Santa has switched to a better model
of determining whether a string is naughty or nice.
None of the old rules apply, as they are all clearly ridiculous.

Now, a nice string is one with all of the following properties:

It contains a pair of any two letters that appears at least twice
in the string without overlapping, like xyxy (xy) or aabcdefgaa (aa),
but not like aaa (aa, but it overlaps).

It contains at least one letter
which repeats with exactly one letter between them,
like xyx, abcdefeghi (efe), or even aaa.

For example:

qjhvhtzxzqqjkmpb is nice because is has a pair that appears twice (qj)
and a letter that repeats with exactly one letter between them (zxz).

xxyxx is nice because it has a pair that appears twice
and a letter that repeats with one between,
even though the letters used by each rule overlap.

uurcxstgmygtbstg is naughty because it has a pair (tg)
but no repeat with a single letter between them.

ieodomkazucvgmuy is naughty because it has a repeating letter
with one between (odo), but no pair that appears twice.

How many strings are nice under these new rules?
 */


#include <stdio.h>
#include <string.h>
#include <stdbool.h>


/**
 * check if text has a pair appearing twice without overlapping
 * @param  text text to be tested
 * @return  bool true if it doesn, false otherwise
 */
bool has_double_pair(char* text)
{
    int i = 0;
    char pair[3] = {'x', 'x', '\0'};

    // Go over each pair of letters, and see if they occur more than once,
    // after that point in the string.
    // This will not iterate over overlapping substrings.
    for(; i<=strlen(text) - 3; i++) {
        pair[0] = text[i];
        pair[1] = text[i + 1];
        if (strstr(&text[i + 2], pair)) {
            return true;
        }
    }

    return false;
}


/**
 * check if a string has a repeating letter with one letter in between
 * @param  text text to be tested
 * @return  bool true if it does, false otherwise
 */
bool has_repeating_letter(char* text)
{
    // Check every combination of three letters by testing if
    // the first and third letter is the same.
    // Return true if it is, else return false at end of text.
    int i = 0;
    for(; i<strlen(text)-2; i++) {
        if (text[i] == text[i + 2]) {
            return true;
        }
    }

    return false;
}


/**
 * Check if string is naughty or nice.
 * @param  text text to be tested
 * @return  bool true if text is nice, false if naughty
 */
bool string_is_nice(char* text)
{
    // Check if string satisfies all conditions for being nice.
    // If it doesn't satisfy any condition, return false.
    // If it satisfies all conditions, return true.
    if (!has_double_pair(text)) {
        return false;
    } else if (!has_repeating_letter(text)) {
        return false;
    } else {
        return true;
    }
}


/**
 * Get the no of nice strings in file
 * @param  filename name of input file
 * @return  int no of nice strings
 */
int get_no_of_nice_strings(const char* filename)
{
    FILE* fp;  // file pointer to input file;
    char* line = NULL;  // line in input
    size_t len = 0;  // length of input read
    ssize_t read = 0;  // length of line read

    int nice_strings = 0;  // no of nice strings

    // Read files line by line,
    // check if the string is nice, and increment counter if it is.
    fp = fopen(filename, "r");
    while((read=getline(&line, &len, fp)) != -1) {
        if (string_is_nice(line)) {
            nice_strings += 1;
        }
    }
    fclose(fp);

    return nice_strings;
}


int main(int argc, char** argv)
{
    int nice_strings = 0;

    nice_strings = get_no_of_nice_strings("./input.txt");
    printf("%d\n", nice_strings);

    return 0;
}

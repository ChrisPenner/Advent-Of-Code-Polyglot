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
 */


#include <stdio.h>
#include <string.h>
#include <stdbool.h>


/**
 * check if text has any of the bad strings
 * @param  text text to be tested for bad strings
 * @return  bool true if there are bad strings, false otherwise
 */
bool has_bad_strings(char* text)
{
    // declare all the bad strings
    const char* bad_strings[] = {"ab", "cd", "pq", "xy"};
    int i = 0;

    // iteratively check if a bad string is present in text
    // If found, return true, otherwise false.
    for (i=0; i<sizeof(bad_strings)/sizeof(bad_strings[0]); i++) {
        if (strstr(text, bad_strings[i])) {
            return true;
        }
    }

    return false;
}


/**
 * check if text has any double letters
 * @param  text text to be tested for double letters
 * @return  bool true if there are double letters, false otherwise
 */
bool has_double_letters(char* text)
{
    // Check if any character is repeated (with the next one)
    // Return true if it is, false otherwise
    int i = 0;
    for(; i<strlen(text) - 1; i++) {
        if (text[i] == text[i + 1]) {
            return true;
        }
    }

    return false;
}


/**
 * check if the character is a vowel
 * @param  character character to be tested
 * @return  bool true if it's a vowel, false otherwise
 */
bool is_vowel(char character)
{
    switch(character) {
        // if character is a vowel, return true
        case 'a':
        case 'e':
        case 'i':
        case 'o':
        case 'u':
            return true;
            break;
        // character is not a vowel, return false
        default:
        return false;
    }
}


/**
 * check if text has the required number of vowels
 * @param  text         text to be tested for vowels
 * @param  no_of_vowels no of vowels that should be in text
 * @return  bool true if there are required no of vowels, false otherwise
 */
bool has_required_vowels(char* text, int no_of_vowels)
{
    int i = 0;
    int vowels = 0;

    // Check every character, and if it is a vowel, increment the count.
    // Check if count is equal to the required no of vowels,
    // if they're equal return true, otherwise return false at the end.
    for(; i<strlen(text); i++) {
        if (is_vowel(text[i])) {
            vowels += 1;
            if (vowels == no_of_vowels) {
                return true;
            }
        }
    }

    return false;
}


/**
 * Check if string is naughty or nice.
 * @param  text text to be tested
 * @return  bool true if text is nice, false if naughty
 */
bool string_is_nice(char *text)
{
    // Check if string satisfies all conditions for being nice.
    // If it doesn't satisfy any condition, return false.
    // If it satisfies all conditions, return true.
    if (has_bad_strings(text)) {
        return false;
    } else if (!has_double_letters(text)) {
        return false;
    } else if (!has_required_vowels(text, 3)) {
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

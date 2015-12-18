/**
 * --- Day 4: The Ideal Stocking Stuffer ---

Santa needs help mining some AdventCoins
(very similar to bitcoins) to use as gifts for all the
economically forward-thinking little girls and boys.

To do this, he needs to find MD5 hashes which,
in hexadecimal, start with at least five zeroes.
The input to the MD5 hash is some secret key
(your puzzle input, given below) followed by a number in decimal.
To mine AdventCoins, you must find Santa the lowest positive number
(no leading zeroes: 1, 2, 3, ...) that produces such a hash.

For example:

If your secret key is abcdef,
the answer is 609043, because the MD5 hash of abcdef609043
starts with five zeroes (000001dbbfa...),
and it is the lowest such number to do so.

If your secret key is pqrstuv,
the lowest number it combines with to make an MD5 hash
starting with five zeroes is 1048970;
that is, the MD5 hash of pqrstuv1048970 looks like 000006136ef....

--- Part Two ---

Now find one that starts with six zeroes.
 */


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#if defined(__APPLE__)
#  define COMMON_DIGEST_FOR_OPENSSL
#  include <CommonCrypto/CommonDigest.h>
#  define SHA1 CC_SHA1
#else
#  include <openssl/md5.h>
#endif


/**
 * calculate MD5 hash for the given text stored in md5hash
 * @param text    text whose md5 hash is to be calculated
 * @param md5hash memory where hash will be stored
 */
void calculate_md5(const char* text, char* md5hash)
{
    // digest is the generated md5 hash
    unsigned char digest[16];

    // calculate hash
    MD5_CTX md5_ctx;
    MD5_Init(&md5_ctx);
    MD5_Update(&md5_ctx, text, strlen(text));
    MD5_Final(digest, &md5_ctx);

    // convert hash to hexadecimal
    for(int i = 0; i < 16; ++i) {
        sprintf(&md5hash[i*2], "%02x", (unsigned int)digest[i]);
    }
}


/**
 * Concatenate two strings through memory allocation.
 * @param  s1 string 1
 * @param  s2 string 2
 * @return  char* pointer to allocated memory
 */
char* concat(char* s1, char* s2)
{
    size_t len1 = strlen(s1);
    size_t len2 = strlen(s2);
    char* result = malloc(len1+len2+1);//+1 for the zero-terminator
    //in real code you would check for errors in malloc here
    memcpy(result, s1, len1);
    memcpy(result+len1, s2, len2+1);//+1 to copy the null-terminator
    return result;
}


int main(int argc, char** argv)
{
    FILE* fp;  // file pointer for input file

    char* text = NULL;  // file pointer for input
    size_t len = 0;  // length of input

    long number = 0;  // number to added to the text before hashing
    char str_number[256];  // string buffer to hold string converted number
    char* answer = NULL;  // string concatenation of text and number
    char md5hash[33];  // md5 hash of answer

    // Required condition for zeroes in md5 hash
    const char* zeroes = "000000";

    // Read text from file
    fp = fopen("./input.txt", "r");
    getline(&text, &len, fp);
    fclose(fp);
    // Clean text if necessary.
    len = strlen(text);
    if (text[len-1] == 10) {
        text[len-1] = '\0';
    }

    // High ranged loop to raise numbers for hash
    while(number >= 0) {

        // convert number to string
        sprintf(str_number, "%ld", number);
        // concatenate text with number
        answer = concat(text, str_number);
        // calculate md5 hash of text+number
        calculate_md5(answer, md5hash);
        // check if hash the right number of zeroes at start
        if (strncmp(zeroes, md5hash, strlen(zeroes)) == 0) {
            break;
        }
        // if it doesn't, free any used memory
        free(answer);
        // increment number
        number += 1;
    }

    printf("%ld", number);

    // free any used memory
    if (text) {
        free(text);
    }
    if (answer) {
        free(answer);
    }

    return 0;
}

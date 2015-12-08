#include <stdio.h>

int main(int argc, char** argv) {
    // What we're doing
    // This is an O(N) solution to the following problem:
    // Each ( and ) character will increment or decrement the floor,
    // respectively.
    // Invalid input is ignored.

    FILE* input_fd = fopen("input.txt", "r");
    if(!input_fd) {
        fprintf(stderr, "Need an input.txt, but none given\n");
        return -1;
    }
    char c_char = 0x00;
    int accum = 0; // it is assumed we are on the ground floor to start.
    int pos = 0;
    while( (c_char = fgetc(input_fd)) != EOF) {
        if( c_char == '(')  accum++;
        else if( c_char == ')')  accum--;
        else { fprintf(stderr, "Invalid input char %c\n", c_char); }
        pos++;
        if(accum < 0) { printf("%d\n", pos); return 0 ; }
    }
    fclose(input_fd);
    printf("Santa never hit the basement! end floor = %d\n", accum);
    return 0;
}

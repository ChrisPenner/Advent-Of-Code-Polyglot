/**
 * --- Day 3: Perfectly Spherical Houses in a Vacuum ---

Santa is delivering presents to an infinite two-dimensional grid of houses.

He begins by delivering a present to the house
at his starting location, and then an elf at the North Pole
calls him via radio and tells him where to move next.
Moves are always exactly one house to the
north (^), south (v), east (>), or west (<).
After each move,
he delivers another present to the house at his new location.

However, the elf back at the north pole has had a little too much eggnog,
and so his directions are a little off,
and Santa ends up visiting some houses more than once.
How many houses receive at least one present?

For example:

> delivers presents to 2 houses:
one at the starting location, and one to the east.

^>v< delivers presents to 4 houses in a square,
including twice to the house at his starting/ending location.

^v^v^v^v^v delivers a bunch of presents
to some very lucky children at only 2 houses.
 */


#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>


/**
 * Position in Cartesian Plane.
 * Defines a node in Linked-List.
 */
typedef struct Position {
    long x;
    long y;
    struct Position* next;
} Position;


/**
 * Parse character into direction on Cartesian plane
 * @param move      character from file signalling the next move
 * @param direction integer array of two elements for x and y movement
 */
void parse_direction(char move, int* direction)
{

    // direction[0] : X-Axis
    // direction[1] : Y-Axis
    switch(move) {
        case '^':  // NORTH +1 Y-Axis
            direction[0] = 0;
            direction[1] = 1;
            break;
        case 'v':  // SOUTH -1 Y-Axis
            direction[0] = 0;
            direction[1] = -1;
            break;
        case '>':  // EAST +1 X-Axis
            direction[0] = 1;
            direction[1] = 0;
            break;
        case '<':  // WEST -1 X-Axis
            direction[0] = -1;
            direction[1] = 0;
            break;
    }
}


/**
 * Check if the given Position is in the List.
 * @param  head     head of linked-list
 * @param  position position to be checked
 * @return          bool True if node is present, False otherwise
 */
bool position_was_visited(Position* head, Position position)
{
    // Iterate over the list and check if positions match
    // for the given node with the specified position.
    // Return true if they do,
    // otherwise iterate till end of list, and return False.
    // If the list is empty, i.e. head is NULL,
    // the while loop will terminate, and false will be returned.
    while(head) {
        if (head->x == position.x && head->y == position.y) {
            return true;
        }
        head = head->next;
    }

    return false;
}


/**
 * Mark Position as visited by adding it to list.
 * @param  head     pointer for head of linked-list
 * @param  position position to be marked, and added to list
 * @return          void
 */
void mark_position_visited(Position** head, Position position)
{
    Position* item = (Position*)malloc(sizeof(Position));
    item->x = position.x;
    item->y = position.y;
    item->next = *head;
    *head = item;
}


/**
 * Calculate no of nodes in list.
 * @param  head head of linked-list
 * @return  int no of nodes
 */
long list_length(Position* head)
{
    long length = 0;
    while(head) {
        length += 1;
        head = head->next;
    }

    return length;
}


/**
 * Free memory occupied by linked list
 * @param head pointer for head of linked list
 *
 * Also sets the head pointer in main() to NULL,
 * thereby preventing any dangling pointers
 */
void clear_memory(Position** head)
{
    Position* next;
    while(*head) {
        next = *head;
        *head = next->next;
        free(next);
    }
}


/**
 * Return the other entity from whoever was active last time
 * @param  last_switched pointer to who was last active
 * @param  santa         pointer to Santa's Position
 * @param  robot         pointer to Robot's Position
 * @return               Position* entity who is active now
 */
Position* switcher(Position* last_switched, Position* santa, Position* robot)
{
    if (last_switched == santa){
        return robot;
    } else {
        return santa;
    }
}


int main(int argc, char **argv)
{
    FILE* fp;  // file pointer to input file
    char move = '\0';  // character depicting next move
    int direction[2];  // direction of the move in cartesian plane

    Position* head = NULL;  // head of set (linked list)
    Position santa_position;  // current santa position
    santa_position.x = 0;
    santa_position.y = 0;
    Position robot_position;  // current robot position
    robot_position.x = 0;
    robot_position.y = 0;
    mark_position_visited(&head, santa_position);

    // Since Santa goes first,
    // Robot would have been the one before that.
    // Current member will hold whoever is moving currently.
    Position* current_member = &robot_position;

    fp = fopen("./input.txt", "r");

    // Read the file one character at a time
    while((move=fgetc(fp)) != EOF) {

        // Get the next move
        parse_direction(move, direction);

        // Get position of currently active member
        current_member = switcher(current_member, &santa_position, &robot_position);

        // Add the next move to current position
        current_member->x += direction[0];
        current_member->y += direction[1];

        // Check if position has been previously visited.
        // If it hasn't been, mark it as visited.
        if (!position_was_visited(head, *current_member)) {
            mark_position_visited(&head, *current_member);
        }
    }

    printf("%ld\n", list_length(head));

    // Free the list and close the file.
    clear_memory(&head);
    fclose(fp);

    return 0;
}
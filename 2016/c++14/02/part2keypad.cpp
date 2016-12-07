// Advent of Code 2016 Day 2

#include "part2keypad.hpp"

#include <iostream>

Part2Keypad::Part2Keypad() : keypad{std::array<char, 5>{'_', '_', '1', '_', '_'},
									std::array<char, 5>{'_', '2', '3', '4', '_'},
									std::array<char, 5>{'5', '6', '7', '8', '9'},
									std::array<char, 5>{'_', 'A', 'B', 'C', '_'},
									std::array<char, 5>{'_', '_', 'D', '_', '_'}},
							 currentRow{2}, currentCol{0}
{
}

void Part2Keypad::move(char direction)
{
	// (0, 0) is top left corner
	// it is impossible to go Up and cause currentRow to become >4, so it's not checked
	// etc etc with the other directions
	switch (direction) {
		case 'U':
			currentRow -= 1;				
			if (currentRow < 0 || getCurrentNumber() == '_') {
				currentRow += 1;	// rollback move
			}
			break;
		case 'D':
			currentRow += 1;
			if (currentRow > 4 || getCurrentNumber() == '_') {
				currentRow -= 1;	// rollback move
			}
			break;
		case 'L':
			currentCol -= 1;
			if (currentCol < 0 || getCurrentNumber() == '_') {
				currentCol += 1;	//rollback move
			}
			break;
		case 'R':
			currentCol += 1;
			if (currentCol > 4 || getCurrentNumber() == '_') {
				currentCol -= 1;	//rollback move
			}
			break;
	}

}

char Part2Keypad::getCurrentNumber() 
{
	return keypad[currentRow][currentCol];
}

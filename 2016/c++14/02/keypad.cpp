// Advent of Code 2016 Day 2

#include "keypad.hpp"

#include <iostream>

Keypad::Keypad() : keypad{std::array<int, 3>{1, 2, 3}, 
						  std::array<int, 3>{4, 5, 6},
						  std::array<int, 3>{7, 8, 9}}, 
				   currentRow{1},  currentCol{1}
{
}

void Keypad::move(char direction)
{
	// (0, 0) is top-left corner
	switch (direction) {
		case 'U':
			currentRow -= 1;
			break;
		case 'D':
			currentRow += 1;
			break;
		case 'L':
			currentCol -= 1;
			break;
		case 'R':
			currentCol += 1;
			break;
	}

	// clamp values to [0, 2]
	if (currentRow < 0) currentRow = 0;
	if (currentRow > 2) currentRow = 2;
	if (currentCol < 0) currentCol = 0;
	if (currentCol > 2) currentCol = 2;
}

int Keypad::getCurrentNumber()
{
	return keypad[currentRow][currentCol];
}

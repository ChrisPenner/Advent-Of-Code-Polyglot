// Advent of Code 2016 Day 2

#ifndef PART2KEYPAD_HPP
#define PART2KEYPAD_HPP

#include <array>

class Part2Keypad {
public:
	Part2Keypad();
	
	void move(char direction);
	char getCurrentNumber();
	
private:
	std::array<std::array<char, 5>, 5> keypad;
	int currentRow;
	int currentCol;
};

#endif // PART2KEYPAD_HPP

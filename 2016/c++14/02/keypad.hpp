// Advent of Code 2016 Day 2

#ifndef KEYPAD_HPP
#define KEYPAD_HPP

#include <array>

class Keypad {
public:
	Keypad();
	
	void move(char direction);
	int getCurrentNumber();
	
private:
	std::array<std::array<int, 3>, 3> keypad;
	int currentRow;
	int currentCol;
};

#endif // KEYPAD_HPP

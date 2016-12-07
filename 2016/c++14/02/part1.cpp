// Advent of Code 2016 Day 2

#include <iostream>
#include <string>

#include "keypad.hpp"

int main()
{
	Keypad k;
	std::string temp;
	while (std::getline(std::cin, temp)) {

		for (const char& c : temp) {
			k.move(c);
		}
		std::cout << k.getCurrentNumber();
	}
	std::cout << std::endl;
	return 0;
}

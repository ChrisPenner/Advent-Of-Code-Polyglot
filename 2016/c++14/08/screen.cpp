// Advent of Code 2016 Day 8

#include "screen.hpp"

#include <iostream>

const int Screen::ROWLENGTH{50};
const int Screen::COLLENGTH{6};

Screen::Screen() : screen{}
{
	for (auto& row : screen) {
		row = std::array<char, 50>();
		for (auto& col : row) {
			col = '.';
		}
	}
}

void Screen::rect(int cols, int rows)
{
	for (int i = 0; i < rows; ++i) {
		for (int j = 0; j < cols; ++j) {
			screen[i][j] = '#';
		}
	}
}

void Screen::rotateCol(int col, int amt)
{
	for (int i = 0; i < amt; ++i) {
		for (int row = COLLENGTH - 1; row > 0; --row) {
			char temp{screen[row][col]};
			screen[row][col] = screen[row - 1][col];
			screen[row - 1][col] = temp;
		}
	}
}

void Screen::rotateRow(int row, int amt)
{
	for (int i = 0; i < amt; ++i) {
		for (int col = ROWLENGTH - 1; col > 0; --col) {
			char temp{screen[row][col]};
			screen[row][col] = screen[row][col - 1];
			screen[row][col - 1] = temp;
		}
	}
}

int Screen::numPixelsOn()
{
	int count{0};
	for (const auto& row : screen) {
		for (const auto& pixel : row) {
			if (pixel != '.') ++count;
		}
	}
	return count;
}

void Screen::displayScreen()
{
	for (const auto& row : screen) {
		for (const auto& pixel : row) {
			std::cout << pixel;
		}
		std::cout << std::endl;
	}
}

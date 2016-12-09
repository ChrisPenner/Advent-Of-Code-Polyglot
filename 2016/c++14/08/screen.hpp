// Advent of Code 2016 Day 8

#include <array>

class Screen {
public:
	Screen();
	void rect(int cols, int rows);
	void rotateCol(int col, int amt);
	void rotateRow(int row, int amt);

	void displayScreen();
	int numPixelsOn();

private:
	static const int ROWLENGTH;
	static const int COLLENGTH;
	std::array<std::array<char, 50>, 6> screen;
};

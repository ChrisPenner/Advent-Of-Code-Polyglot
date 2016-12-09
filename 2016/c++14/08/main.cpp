// Advent of Code 2016 Day 8

#include <iostream>
#include <vector>
#include <string>
#include <utility>

#include "screen.hpp"

enum class Instr{ rect, rotate_col, rotate_row, invalid_instr };

Instr getInstr(const std::string& line)
{
	if (line.find("rect") == 0) return Instr::rect;
	if (line.find("column") != std::string::npos) return Instr::rotate_col;
	if (line.find("row") != std::string::npos) return Instr::rotate_row;
	
	// else say it's an invalid line
	return Instr::invalid_instr;
}

std::pair<int, int> getParams(const std::string& line, Instr instrType)
{
	if (instrType == Instr::rect) {
		// too lazy to type out std::string::size_type
		auto instrEnd{line.find(' ')};
		auto paramSeparator{line.find('x')};

		std::string row{line.substr(instrEnd + 1, paramSeparator - instrEnd - 1)};
		std::string col{line.substr(paramSeparator + 1, line.size() - paramSeparator)};

		return std::pair<int, int>(std::stoi(row), std::stoi(col));

	} else if (instrType == Instr::rotate_col || instrType == Instr::rotate_row) {
		// too lazy to type out std::string::size_type
		auto rowOrColBegin{line.find('=')};
		auto amtBegin{line.find("by ")};

		
		std::string rowOrCol{line.substr(rowOrColBegin + 1, amtBegin - rowOrColBegin - 2)};
		std::string amt{line.substr(amtBegin + 3, line.size() - amtBegin + 3)};
		
		return std::pair<int, int>(std::stoi(rowOrCol), std::stoi(amt));

	} else {
		return std::pair<int, int>(-1, -1); // should probably throw an exception but eh
	}
}

void runInstr(Screen& s, Instr instrType, const std::pair<int, int>& params)
{
	if (instrType == Instr::rect) {
		s.rect(params.first, params.second);
	} else if (instrType == Instr::rotate_col) {
		s.rotateCol(params.first, params.second);
	} else if (instrType == Instr::rotate_row) {
		s.rotateRow(params.first, params.second);
	}
}

int main()
{
	Screen s;
	
	std::string line;
	while (std::getline(std::cin, line)) {
		Instr instrType{getInstr(line)};
		std::pair<int, int> params{getParams(line, instrType)};	

		runInstr(s, instrType, params);
	}

	s.displayScreen();
	std::cout << "Number of on pixels: " << s.numPixelsOn() << std::endl;

	return 0;
}

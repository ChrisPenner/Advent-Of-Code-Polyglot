// Advent of Code 2016 Day 3

#include <iostream>
#include <array>
#include <vector>
#include <string>

bool isTriangle(const std::array<int, 3>& sides)
{
	return (sides[0] + sides[1] > sides[2] 
			&& sides[0] + sides[2] > sides[1] 
			&& sides[1] + sides[2] > sides[0]);
}

std::array<int, 3> parse(const std::string& line)
{
	std::array<int, 3> triangle;

	for (int side = 0; side < 3; ++side) {
		// each column is 5 chars wide; iterate through ranges [0, 5), [5, 10), [10, 15)
		for (int i = side * 5; i < (side + 1) * 5; ++i) {
			// when a number is first encountered in a 5-char column, 
			// the rest are guaranteed to be part of the same number
			if (line[i] != ' ') {
				triangle[side] = std::stoi(line.substr(i, 5 * (side + 1) - i));
				break;
			}
		}
	}

	return triangle;
}

int main()
{
	std::vector<std::array<int, 3>> sidesList;

	std::string line;
	while (std::getline(std::cin, line)) {
		sidesList.push_back(parse(line));
	}

	int count{0};
	for (const auto& tri : sidesList) {
		if (isTriangle(tri)) {
			++count;
		}
	}

	std::cout << "Number of possible triangles: " << count << std::endl;

	return 0;
}

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

// parses 3 lines at a time
std::array<std::array<int, 3>, 3> parseVertical(const std::array<std::string, 3>& lines)
{
	// an array of triples of triangle side lengths
	std::array<std::array<int, 3>, 3> triArray;

	for (int side = 0; side < 3; ++side) {

		std::array<bool, 3> doneArray{false, false, false};

		for (int i = side * 5; i < (side + 1) * 5; ++i) {
			for (int line = 0; line < 3; ++line) {

				/* if the beginning of the number has already been found on a line, the number
				   will have been put into triArray and doneArray[line] will equal true. can 
				   skip this line from now until side increments */
				if (lines[line][i] != ' ' && !doneArray[line]) {
					triArray[side][line] = 
										std::stoi(lines[line].substr(i, 5 * (side + 1) - i));
					doneArray[line] = true;
				}
			}
		}
	}

	return triArray;
}

void addToVector(const std::array<std::array<int, 3>, 3>& triArray,
				 std::vector<std::array<int, 3>>& sidesList)
{
	for (const auto& tri : triArray) {
		sidesList.push_back(tri);
	}
}

int main(int argc, char** argv)
{
	std::vector<std::array<int, 3>> sidesList;

	std::array<std::string, 3> threeLines;
	while (true) {
		for (int i = 0; i < 3; ++i) {
			std::getline(std::cin, threeLines[i]);
		}

		// must check for EOF after the loop because of the extra newline character (I think)
		if (std::cin.eof()) break;
		addToVector(parseVertical(threeLines), sidesList);
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

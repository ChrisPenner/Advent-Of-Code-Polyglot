// Advent of Code 2016 Day 1

#include <iostream>
#include <vector>
#include <string>

#include "mapgrid.hpp"

int main() {
	MapGrid map;
	std::vector<std::string> steps;

	std::string step;

	// extract each space-delimited token
	while (std::cin >> step) {
		if (step.back() == ',') {
			steps.push_back(step.substr(0, step.size() - 1)); // remove ending comma and add to steps
		} else {
			steps.push_back(step);
		}
	}

	for (const auto& elem : steps) {
		char direction{elem.front()};
		int distance{std::stoi(elem.substr(1, elem.size() - 1))}; // skip first character

		map.turn(direction);

		// check if any spaces passed have already been visited
		bool foundVisitedPoint{map.walkForwardWithCheck(distance)};
		if (foundVisitedPoint) {
			Point currentPoint{map.getCurrentPoint()};
			std::cout << "First previously visited point: (" << currentPoint.row << ", "
					<< currentPoint.col << ")\n";
			std::cout << "Distance to that point: " << map.getTaxicabDistance() 
					<< std::endl;
			return 0;
		}
	}

	std::cout << "Distance from start: " << map.getTaxicabDistance() << std::endl;

	return 0;
}


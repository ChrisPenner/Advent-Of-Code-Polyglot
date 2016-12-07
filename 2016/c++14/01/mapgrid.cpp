// Advent of Code 2016 Day 1 Puzzle 1

#include "mapgrid.hpp"

#include <cmath>
#include <algorithm>

Point::Point(int rowVal, int colVal) : row{rowVal}, col{colVal}
{
}

bool operator==(const Point& lhs, const Point& rhs)
{
	return lhs.row == rhs.row && lhs.col == rhs.col;
}

bool operator!=(const Point& lhs, const Point& rhs)
{
	return lhs.row != rhs.row || lhs.col != rhs.col;
}

MapGrid::MapGrid() : currentDirection{Direction::up}, currentRow{0}, currentCol{0}, 
					 visitedPoints{Point(0, 0)} // add origin to list of visited points
{
}

void MapGrid::turn(char turnDirection)
{
	if (turnDirection == 'L') {
		switch (currentDirection) {
			case Direction::up:
				currentDirection = Direction::left;
				break;
			case Direction::right:
				currentDirection = Direction::up;
				break;
			case Direction::down:
				currentDirection = Direction::right;
				break;
			case Direction::left:
				currentDirection = Direction::down;
				break;
		}
	} else if (turnDirection == 'R') {
		switch (currentDirection) {
			case Direction::up:
				currentDirection = Direction::right;
				break;
			case Direction::right:
				currentDirection = Direction::down;
				break;
			case Direction::down:
				currentDirection = Direction::left;
				break;
			case Direction::left:
				currentDirection = Direction::up;
				break;
		}
	}
}

void MapGrid::walkForward(int numSpaces)
{
	for (int i = numSpaces; i > 0; --i) {
		switch (currentDirection) {
			case Direction::left:
				currentCol += 1;
				break;
			case Direction::right:
				currentCol -= 1;
				break;
			case Direction::up:
				currentRow -= 1;	// grid's origin is in top-left corner
				break;
			case Direction::down:
				currentRow += 1;
				break;
		}
	}
}

// returns true once an already-visited point is encountered
// returns false if all points on this walk have never been visited
bool MapGrid::walkForwardWithCheck(int numSpaces)
{
	for (int i = numSpaces; i > 0; --i) {
		switch (currentDirection) {
			case Direction::left:
				currentCol += 1;
				break;
			case Direction::right:
				currentCol -= 1;
				break;
			case Direction::up:
				currentRow -= 1;	// grid's origin is in top-left corner
				break;
			case Direction::down:
				currentRow += 1;
				break;
		}

		Point currentPoint{currentRow, currentCol};
		if (!checkVisitedPoints(currentPoint)) {
			visitedPoints.push_back(currentPoint);
		} else {
			return true;
		}
	}

	return false;
}

int MapGrid::getTaxicabDistance()
{
	return std::abs(currentRow) + std::abs(currentCol);
}

int MapGrid::getTaxicabDistance(const Point& location)
{
	return std::abs(location.row) + std::abs(location.col);
}

Point MapGrid::getCurrentPoint()
{
	return Point(currentRow, currentCol);
}

// search through all visited Points and return whether the argument already exists
// not terribly elegant or efficient but meh
bool MapGrid::checkVisitedPoints(const Point& point)
{
	return std::find(visitedPoints.cbegin(), visitedPoints.cend(), point) != visitedPoints.cend();
}

// Advent of Code 2016 Day 1 Puzzle 1

#ifndef MAPGRID_HPP
#define MAPGRID_HPP

#include <vector>

enum class Direction { left, up, right, down };

struct Point {
	int row, col;

	Point(int rowVal, int colVal);

	// equality operator overload for std::find in checkVisitedPoints
	friend bool operator==(const Point& lhs, const Point& rhs);
	friend bool operator!=(const Point& lhs, const Point& rhs);
};

class MapGrid {
public:
	MapGrid();
	void turn(char turnDirection);
	void walkForward(int numSpaces);
	bool walkForwardWithCheck(int numSpaces);

	int getTaxicabDistance(); // get distance to current location if unspecified
	int getTaxicabDistance(const Point& location);

	Point getCurrentPoint();

private:
	Direction currentDirection;
	int currentRow;
	int currentCol;

	std::vector<Point> visitedPoints;
	bool checkVisitedPoints(const Point& point);
};

#endif // MAPGRID_HPP

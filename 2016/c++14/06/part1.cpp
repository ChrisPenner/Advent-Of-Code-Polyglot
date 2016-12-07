// Advent of Code 2016 Day 6

#include <iostream>
#include <string>
#include <array>
#include <map>
#include <algorithm>

int main()
{
	std::array<std::map<char, int>, 8> mapArray;

	std::string line;
	while (std::cin >> line) {
		for (int i = 0; i < 8; ++i) {
			char c{line[i]};
			++mapArray[i][c];
		}
	}

	std::string correctedMessage;
	for (const auto& map : mapArray) {
		/* std::max_element returns an Iterator to a std::pair<char, int>, so
		   treat the return value as if it were a pointer
		*/
		correctedMessage += std::max_element(map.cbegin(), map.cend(), 
												[](const auto& kv1, const auto& kv2) {
													return kv1.second < kv2.second;
												}
											)->first;
	}

	std::cout << correctedMessage << std::endl;

	return 0;
}

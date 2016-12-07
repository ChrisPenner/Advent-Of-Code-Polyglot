// Advent of Code 2016 Day 4

#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <algorithm>

std::string getChecksum(const std::string& line, std::string::size_type checksumStart)
{
	return line.substr(checksumStart + 1, line.size() - checksumStart - 2);
}

std::string getEncryptedName(const std::string& line, std::string::size_type checksumStart)
{
	return line.substr(0, checksumStart - 4);
}

int getSectorID(const std::string& line, std::string::size_type checksumStart)
{
	return std::stoi(line.substr(checksumStart - 3, 3));
}

std::map<char, int> countChars(const std::string& line)
{
	std::map<char, int> charMap;

	for (const char letter : line) {
		if (letter == '-') {
			continue;
		}
		else if (charMap.find(letter) == charMap.end()) {
			charMap[letter] = 1;
		} else {
			++charMap[letter];
		}
	}

	return charMap;
}

bool isRealRoom(const std::map<char, int>& charMap, const std::string& checksum)
{
	std::vector<std::pair<char, int>> charCountVector{charMap.begin(), charMap.end()};

	std::sort(charCountVector.begin(), charCountVector.end(),
				[](const auto& kv1, const auto& kv2) {
					if (kv1.second == kv2.second) {
						return kv1.first < kv2.first;
					} else {
						return kv1.second > kv2.second;
					}
				}
	);

	for (unsigned int i = 0; i < checksum.size(); ++i) {
		if (checksum[i] != charCountVector[i].first) {
			return false;
		}
	}
	
	return true;
}

std::string decryptName(const std::string& encryptedName, const int sectorID)
{
	std::string decryptedName;

	for (const char& letter : encryptedName) {
		if (letter == '-') {
			decryptedName += ' ';
		} else {
			int shift{sectorID % 26};
			if (letter + shift > 'z') {
				decryptedName += static_cast<char>(letter + shift - 26);
			} else {
				decryptedName += static_cast<char>(letter + shift);
			}
		}
	}

	return decryptedName;
}

int main()
{
	std::string line;
	
	while (std::getline(std::cin, line)) {
		std::string::size_type checksumStart{line.find_first_of("[")};

		std::string checksum{getChecksum(line, checksumStart)};
		std::string encryptedName{getEncryptedName(line, checksumStart)};

		auto charMap{countChars(encryptedName)};
		if (isRealRoom(charMap, checksum)) {
			int sectorID{getSectorID(line, checksumStart)};

			std::string name{decryptName(encryptedName, sectorID)};
			if (name.find("north") != std::string::npos) {
				std::cout << name << " " << sectorID << std::endl;
			}
		}
	}

	return 0;
}

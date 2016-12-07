// Advent of Code 2016 Day 7

#include <iostream>
#include <string>
#include <vector>

bool hasABBA(const std::string& seq)
{
	for (unsigned int i = 0; i <= seq.size() - 4; ++i) {
		char a{seq[i]};
		char b{seq[i + 1]};

		if (a == b) continue;
		if (seq[i + 2] == b && seq[i + 3] == a) {
			return true;
		}
	}

	return false;
}

bool hasTLS(const std::vector<std::string>& seqList)
{
	bool ABBAfound{false};

	int flip{1}; // 1 = non-Hypernet, -1 = Hypernet
	for (const auto& seq : seqList) {
		bool containsABBA{hasABBA(seq)};

		if (flip < 0 && containsABBA) {
			return false; // return false on first ABBA in a Hypernet seq
		} else if (flip > 0 && containsABBA) {
			ABBAfound = true; // must check all seqs
		}

		flip *= -1;
	}

	return ABBAfound;
}

int main()
{
	int tlsCount{0};

	std::string line;
	while (std::cin >> line) {
		// seqList contains alternating non-Hypernet and Hypernet sequences
		std::vector<std::string> seqList;

		unsigned int startOfSeq{0};
		for (unsigned int i = 0; i < line.size(); ++i) {
			// use brackets as terminating char for all sequences except the very last one
			if (line[i] == '[' || line[i] == ']') {
				seqList.push_back(line.substr(startOfSeq, i - startOfSeq));
				startOfSeq = i + 1; // set startOfSeq to index of first char after bracket
			}
		}
		// last sequence ends with a newline, not a bracket
		seqList.push_back(line.substr(startOfSeq, line.size() - startOfSeq));

		if (hasTLS(seqList)) {
			++tlsCount;
		}
	}

	std::cout << tlsCount << std::endl;

	return 0;
}

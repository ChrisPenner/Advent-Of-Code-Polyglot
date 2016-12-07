// Advent of Code 2016 Day 7

#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

void putABAsInto(std::vector<std::string>& ABAlist, const std::string& seq)
{
	for (unsigned int i = 0; i <= seq.size() - 3; ++i) {
		char a{seq[i]};
		char b{seq[i + 1]};

		if (a == b) continue;
		if (seq[i + 2] == a) {
			ABAlist.push_back(seq.substr(i, 3));		
		}
	}
}

// just for clarity
void putBABsInto(std::vector<std::string>& BABlist, const std::string& seq)
{
	for (unsigned int i = 0; i <= seq.size() - 3; ++i) {
		char a{seq[i]};
		char b{seq[i + 1]};

		if (a == b) continue;
		if (seq[i + 2] == a) {
			BABlist.push_back(seq.substr(i, 3));
		}
	}
}

std::string getBABfromABA(const std::string& ABA)
{
	return std::string{std::string() + ABA[1] + ABA[0] + ABA[1]};
}

bool supportsSSL(const std::vector<std::string>& seqList)
{
	std::vector<std::string> ABAlist;
	std::vector<std::string> BABlist;

	int flip{1}; // 1 = non-Hypernet sequence, -1 = Hypernet sequence
	for (const auto& seq : seqList) {
		if (flip > 0) {
			putABAsInto(ABAlist, seq);
		} else if (flip < 0) {
			putBABsInto(BABlist, seq);
		}

		flip *= -1;
	}

	for (const auto& ABA : ABAlist) {
		std::string constructedBAB{getBABfromABA(ABA)};
		if (std::find(BABlist.cbegin(), BABlist.cend(), constructedBAB) != BABlist.cend()) {
			return true;
		}
	}

	return false;
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

		if (supportsSSL(seqList)) {
			++tlsCount;
		}
	}

	std::cout << tlsCount << std::endl;

	return 0;
}

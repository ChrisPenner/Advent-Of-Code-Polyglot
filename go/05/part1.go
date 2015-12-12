package main

import (
	"fmt"
	"regexp"
	"os"
	"bufio"
	"strings"
)

func main() {

	lines := getInput("input.txt")

	niceStrings := 0

	for _, line := range lines {
		if isNiceString(line) {
			niceStrings++
		}
	}

	fmt.Printf("There are %d nice strings in part 1\n", niceStrings)
	
}

func isNiceString(line string) bool {
	return hasThreeVowels(line) && hasRepeatingChar(line) && !hasInvalidSubstring(line)
}

func hasThreeVowels(line string) bool {
	matched, _ := regexp.MatchString(".*[aeiou].*[aeiou].*[aeiou].*", line);
	return matched
}

func hasRepeatingChar(line string) bool {
	
	prevChar := ""
	
	for _, char := range line {
		
		// Found a repeating char
		if prevChar == string(char) {
			return true
		}

		prevChar = string(char)

	}

	return false
}

func hasInvalidSubstring(line string) bool {
	// Doesn't contain substrings 'ab', 'cd', 'pq', or 'xy'
	return strings.Contains(line, "ab") || strings.Contains(line, "cd") || strings.Contains(line, "pq") || strings.Contains(line, "xy")
}

func getInput(filepath string) []string {
	
	file, err := os.Open(filepath)

	if err != nil {
		panic(err)
	}

	defer file.Close()
	var lines []string

	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}

	return lines
}
package main

import (
	"fmt"
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

	fmt.Printf("There are %d nice strings in part 2\n", niceStrings)
	
}

func isNiceString(line string) bool {
	return hasRepeatingPair(line) && hasSandwhichedChar(line)
}

func hasSandwhichedChar(line string) bool {

	if len(line) < 2 {
		return false
	}

	for i := 0; i < len(line) - 2; i++ {
		if line[i] == line[i+2] {
			return true
		}
	}

	return false
}

func hasRepeatingPair(line string) bool {

	for i := 0; i < len(line) - 1; i++ {
		pair := string(line[i]) + string(line[i+1])
		
		s1 := line[:i] 		// part of string before the pair
		s2 := line[i+2:len(line)]	// part of string after the pair
		
		if strings.Contains(s1, pair) || strings.Contains(s2, pair) {
			return true
		}
		
	}

	return false

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
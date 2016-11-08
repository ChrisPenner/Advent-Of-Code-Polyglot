package main

import (
	"fmt"
	"os"
	"bufio"
)

func main() {

	input := getInput("input.txt")
	findFinalFloor(input)

}

func findFinalFloor(input []string) {

	floor := 0
	for _, line := range input {
		for _, char := range line {
			switch string(char) {
			case "(":
				floor++
			case ")":
				floor--
			}
		}
	}

	fmt.Printf("You end up on floor %d\n", floor)

}

func getInput(filepath string) []string {

	file, err := os.Open(filepath)

	if err != nil {
		panic(err)
	}

	defer file.Close()
	var lines []string

	scanner := bufio.NewScanner(file)

	// Read all lines of the file
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}

	return lines
	
}
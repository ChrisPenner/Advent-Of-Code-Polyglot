package main

import (
	"fmt"
	"os"
	"bufio"
)

func main() {

	input := getInput("input.txt")
	findBasementEntrance(input)

}

func findBasementEntrance(input []string) {

	floor := 0

	for _, line := range input {
		for i, char := range line {
			switch string(char) {
			case "(":
				floor++
			case ")":
				floor--

				if floor == -1 {
					fmt.Printf("Santa entered the basement at position %d\n", i+1)
					return
				}


			}
		}
	}

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
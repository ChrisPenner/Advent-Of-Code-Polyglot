package main

import (
	"crypto/md5"
	"fmt"
	"strconv"
)

func main() {

	input := "ugkcyxxp"
	part1 := ""
	counter := 0

	for len(part1) != 8 {
		hashInput := []byte(input + strconv.Itoa(counter))
		counter = counter + 1
		output := fmt.Sprintf("%x", md5.Sum(hashInput))

		if output[:5] == "00000" {
			fmt.Println(part1, output, counter)
		}

	}

	fmt.Println(part1)

}

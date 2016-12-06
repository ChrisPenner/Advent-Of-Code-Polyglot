package main

import (
	"crypto/md5"
	"fmt"
	"strconv"
)

func main() {

	input := "ugkcyxxp"
	counter := 0

	part2 := "        "

	found := 0
	for found < 8 {
		hashInput := []byte(input + strconv.Itoa(counter))
		counter = counter + 1
		output := fmt.Sprintf("%x", md5.Sum(hashInput))

		if output[:5] == "00000" {
			index, err := strconv.Atoi(string(output[5]))
			if err != nil || index > 7 || string(part2[index]) != " " {
				continue
			}

			newPassword := []rune(part2)
			newPassword[index] = rune(output[6])
			part2 = string(newPassword)
			found = found + 1

		}

	}

	fmt.Println(part2)

}

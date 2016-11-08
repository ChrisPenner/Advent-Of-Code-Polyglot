package main

import (
	"fmt"
	"crypto/md5"
	"strconv"
	"encoding/hex"
)

func main() {

	// This was my secret but it
	// is easily changed
	secret := "yzbqklnj"

	findZeroPaddedHash(secret, 5) // Part 1
	findZeroPaddedHash(secret, 6) // Part 2

}

/**
 * Continually hashes the "secret" adding 
 * @param  {string} secret	the string to hash
 * @param  {int} numZeros the number of zeros to look for
 */
func findZeroPaddedHash(secret string, numZeros int) {

	done := false

	for i := 0; !done; i++ {
		
		hash := md5.Sum([]byte(secret + strconv.Itoa(i)))
		hashString := hex.EncodeToString(hash[:])

		// Check to make sure there are numZeros zeros at the 
		// front of the hash
		for j := 0; j < numZeros; j++ {
			
			if hashString[j] != 48 {
				break
			}

			if j == numZeros - 1 {
				fmt.Printf("Found hash with %d preceding zeros at %d\n", numZeros, i)
				done = true
				break
			}

		}

	}

}
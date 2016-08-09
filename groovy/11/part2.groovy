#!/usr/bin/env groovy

// Your puzzle input
def pwd = 'hxbxwxba'

char getNextChar(char c) {
    def a = 97                      // ASCII value of 'a'
    def n = (c - a + 1) % 26        // next letter as an int
    (char) n + a                    // back to char
}

String getNextString(String chars) {
    def nextChar = getNextChar(chars[-1] as char)
    def firstChars = chars[0..<-1]

    // Replace the last character by the next one
    if (nextChar != 'a') return firstChars + nextChar

    // Overflow: recursively get next string on password minus last char
    return getNextString(firstChars) + nextChar
}

boolean containsForbiddenChars(String password) {
    def forbiddenChars = ['i', 'o', 'l']
    forbiddenChars.any { password.contains it }
}

boolean containsPair(String password) {
    // ([a-z]) -> any letter
    // \1 -> repeating
    // ([a-z])\2/ -> another pair of letters
    def pairs = /([a-z])\1.*([a-z])\2/
    password.find(pairs)
}

boolean containsSequence(String password) {
    def chars = password.toCharArray()
    (0..password.length()-3).any { n ->
        int a = chars[n]
        int b = chars[n + 1]
        int c = chars[n + 2]
        a + 1 == b && b + 1 == c
    }
}

boolean isValid(String password) {
    containsPair(password) &&
        !containsForbiddenChars(password) &&
        containsSequence(password)
}

String findNext(String password) {
    while (true) {
        password = getNextString(password)
        if (isValid(password)) return password
    }
}


println findNext(findNext(pwd))

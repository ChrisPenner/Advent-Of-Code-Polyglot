#!/usr/bin/env groovy

// Your puzzle input
def pwd = 'hxbxwxba'

char getNextChar(char c) {
    def a = 97                      // ASCII value of 'a'
    def n = (c - a + 1) % 26        // next letter as an int
    (char) n + a                    // back to char
}

String getNextString(s) {
    def nextChar = getNextChar(s[-1] as char)
    def firstChars = s[0..<-1]

    // Replace the last character by the next one
    if (nextChar != 'a') return firstChars + nextChar

    // Overflow: recursively get next string on password minus last char
    return getNextString(firstChars) + nextChar
}

boolean containsForbiddenChars(password) {
    password =~ /i|o|l/
}

boolean containsPair(password) {
    // ([a-z]) -> any letter
    // \1 -> repeating
    // ([a-z])\2/ -> another pair of letters
    def pairs = /([a-z])\1.*([a-z])\2/
    password.find(pairs)
}

boolean containsSequence(password) {
    def chars = password.toCharArray()
    (0..password.length()-3).any { n ->
        int a = chars[n]
        int b = chars[n + 1]
        int c = chars[n + 2]
        a + 1 == b && b + 1 == c
    }
}

boolean isValid(password) {
    containsPair(password) &&
        !containsForbiddenChars(password) &&
        containsSequence(password)
}


while (!isValid(pwd)) {
    pwd = getNextString(pwd)
}
println pwd

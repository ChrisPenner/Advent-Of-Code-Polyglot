<?php

$input = file_get_contents("input");

$goodStringAmount = 0;

foreach (explode("\n", $input) as $string) {
    if (isGoodString($string)) {
        $goodStringAmount++;
    }
}

echo $goodStringAmount;

function isGoodString($string) {
    // Check repeating char with exactly one char in between
    $repeatingCharFound = repeatingCharFound($string);

    // Check repeating substrings of length 2
    $repeatingStringFound = repeatingStringFound($string);

    return $repeatingCharFound && $repeatingStringFound;
}

function repeatingStringFound($string) {
    $charArray = str_split($string);

    for ($i = 0; $i < count($charArray) - 3; $i++) {
        $remainingString = substr($string, $i + 2);
        if (strpos($remainingString, $charArray[$i] . $charArray[$i + 1]) !== false) {
            return true;
        }
    }

    return false;
}

function repeatingCharFound($string) {
    $charArray = str_split($string);

    foreach ($charArray as $index => $char) {
        if (isset($charArray[$index + 2]) && $charArray[$index + 2] === $char) {
            return true;
        }
    }

    return false;
}
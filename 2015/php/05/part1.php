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

    // Check vowels
    $vowelAmountAllowed = vowelAmountAllowed($string);

    // Check repeating char
    $repeatingCharFound = repeatingCharFound($string);

    // Check bad strings
    $containsNoBadStrings = containsNoBadStrings($string);

    return $vowelAmountAllowed && $repeatingCharFound && $containsNoBadStrings;
}

function repeatingCharFound($string) {
    $lastChar = '';

    foreach (str_split($string) as $char) {
        if ($char === $lastChar) {
            return true;
        }

        $lastChar = $char;
    }

    return false;
}

function vowelAmountAllowed($string) {
    $vowels = array('a', 'e', 'i', 'o', 'u');
    $vowelAmount = 0;

    foreach ($vowels as $vowel) {
        $vowelAmount += substr_count($string, $vowel);
    }

    return $vowelAmount >= 3;
}

function containsNoBadStrings($string) {
    $badStrings = array("ab", "cd", "pq", "xy");

    foreach ($badStrings as $badString) {
        if (strpos($string, $badString) !== false) {
            return false;
        }
    }

    return true;
}
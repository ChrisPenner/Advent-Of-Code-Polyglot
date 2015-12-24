<?php

$input = file_get_contents("input");

$lines = explode("\n", $input);

$totalLength = 0;

foreach ($lines as $line) {
    $trimmedLine = trim($line);
    $length = strlen($trimmedLine);

    $actualString = substr($trimmedLine, 1, $length - 2);
    $actualString = str_replace("\\\"", "\"", $actualString);
    $actualString = str_replace("\\\\", "\\", $actualString);

    $hexOptions = array('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f');
    foreach ($hexOptions as $firstOption) {
        foreach ($hexOptions as $secondOption) {
            $actualString = str_replace("\\x" . $firstOption . $secondOption, ".", $actualString);
        }
    }

    $totalLength += $length - strlen($actualString);
}

echo $totalLength;
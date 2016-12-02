<?php

$input = file_get_contents('input');

$numbers = explode("\n", $input);

foreach ($numbers as $index => $number) {
    $numbers[$index] = intval($number);
}
$max = array_sum($numbers) / 4;

$combinations = getAllCombinations($numbers, $max);

$minParts = 1000;

foreach ($combinations as $combination) {
    $parts = explode(",", $combination);
    if (count($parts) < $minParts) {
        $minParts = count($parts);
    }
}

$complexity = array();

foreach ($combinations as $combination) {
    $parts = explode(",", $combination);
    if (count($parts) == $minParts) {
        $complexity[] = array_product($parts);
    }
}

echo min($complexity);

function getAllCombinations($numbers, $targetValue) {
    if (count($numbers) == 1) {
        if (reset($numbers) == $targetValue) {
            return array(reset($numbers));
        } else {
            return array();
        }
    }

    $options = array();
    foreach ($numbers as $key => $number) {
        $newNumbers = $numbers;
        for ($i = 0; $i <= $key; $i++) {
            unset($newNumbers[$i]);
        }

        if ($targetValue - $number == 0) {
            $options[] = $number;
        }

        if ($targetValue - $number > 0) {
            $subOptions = getAllCombinations($newNumbers, $targetValue - $number);
            foreach ($subOptions as $subOption) {
                $options[] = $number . ',' . $subOption;
            }
        }
    }

    return $options;
}
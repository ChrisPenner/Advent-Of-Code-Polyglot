<?php

$input = file_get_contents('input');

$totalCapacity = 150;

$values = explode("\n", $input);

foreach ($values as $key => $value) {
    $values[$key] = intval(trim($value));
}

echo getOptionCount($values, $totalCapacity);

function getOptionCount($numbers, $targetValue) {
    if (count($numbers) == 1) {
        return intval(reset($numbers) == $targetValue);
    }

    $totalOptionCount = 0;
    foreach ($numbers as $key => $number) {
        $newNumbers = $numbers;
        for ($i = 0; $i <= $key; $i++) {
            unset($newNumbers[$i]);
        }

        if ($targetValue - $number == 0) {
            $totalOptionCount++;
        }

        if ($targetValue - $number > 0) {
            $totalOptionCount += getOptionCount($newNumbers, $targetValue - $number);
        }
    }

    return $totalOptionCount;
}
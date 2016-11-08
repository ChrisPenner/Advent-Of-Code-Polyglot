<?php

$input = 36000000;

$presents = 0;
$i = 0;

$start = microtime(true);

while ($presents < $input) {
    $i++;
    $presents = getPresents($i);
    if ($i % 10000 == 0) {
        echo $i ." => " . $presents . "\n";
    }
}

echo $i . "\n";

function getPresents($number) {
    $totalPresents = 0;

    $dividers = array();

    for ($i = 1; $i <= sqrt($number) + 1; $i++) {
        if ($number % $i === 0) {
            $dividers[] = $i;
        }
    }

    foreach ($dividers as $divider) {
        if ($divider <= 50) {
            $totalPresents += 11 * ($number / $divider);
        }
    }

    return $totalPresents;
}
<?php

$input = file_get_contents("input");

$presents = explode("\n", $input);

$ribbonNeeded = 0;

foreach ($presents as $present) {
    $dimensions = explode("x", trim($present));
    list($l, $w, $h) = $dimensions;

    $ribbonNeeded += 2 * (array_sum($dimensions) - max($dimensions));
    $ribbonNeeded += array_product($dimensions);
}

echo $ribbonNeeded;
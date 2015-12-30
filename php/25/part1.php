<?php

$row = 2947;
$column = 3029;

$lastValue = 20151125;
for ($diagonal = 2; $diagonal < 10000; $diagonal++) {
    for ($i = 0; $i < $diagonal; $i++) {
        $x = $i + 1;
        $y = $diagonal - $i;

        $lastValue *= 252533;
        $lastValue %= 33554393;
        if ($x == $column && $y == $row) {
            echo $lastValue;
            die();
        }
    }
}
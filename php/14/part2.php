<?php

$input = file_get_contents("input");

$lines = explode("\n", $input);

$endTime = 2503;

$positions = array();

foreach ($lines as $line) {
    $words = explode(" ", $line);

    $speed = $words[3];
    $time = $words[6];
    $pause = $words[13] - 1;

    $startTime = 0;
    $pauseTime = -1000;

    $distance = 0;

    $linePositions = array();

    for ($i = 0; $i <= $endTime; $i++) {
        $linePositions[] = $distance;
        if ($i <= $pauseTime + $pause) {
            continue;
        }
        if ($i > $pauseTime + $pause && $pauseTime != -1000) {
            $pauseTime = -1000;
            $startTime = $i;
        }
        if ($i >= $startTime + $time) {
            $pauseTime = $i;
            continue;
        }
        $distance += $speed;
    }

    $positions[] = $linePositions;
}

$points = array();

for ($i = 1; $i <= $endTime; $i++) {
    $winningReindeerPosition = 0;

    foreach ($lines as $index => $temp) {
        if ($positions[$index][$i] > $winningReindeerPosition) {
            $winningReindeerPosition = $positions[$index][$i];
        }
    }

    foreach ($lines as $index => $temp) {
        if ($positions[$index][$i] == $winningReindeerPosition) {
            if (empty($points[$index])) {
                $points[$index] = 1;
            } else {
                $points[$index]++;
            }
        }
    }
}

var_dump($points);
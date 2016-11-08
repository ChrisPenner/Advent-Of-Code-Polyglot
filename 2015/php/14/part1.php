<?php

$input = file_get_contents("input");

$lines = explode("\n", $input);

$endTime = 2503;

foreach ($lines as $line) {
    $words = explode(" ", $line);

    $speed = $words[3];
    $time = $words[6];
    $pause = $words[13] - 1;

    $startTime = 0;
    $pauseTime = -1000;

    $distance = 0;

    for ($i = 0; $i <= $endTime; $i++) {
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

    echo $words[0] . ": " . $distance . "\n";
}
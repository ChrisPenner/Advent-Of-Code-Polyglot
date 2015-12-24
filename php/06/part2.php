<?php

$input = file_get_contents("input");
$lines = explode("\n", $input);

$totalLit = 0;

$lineCoords = array();
foreach ($lines as $line) {
    $filteredWords = array('toggle ', 'turn off ', 'turn on ');

    foreach ($filteredWords as $filteredWord) {
        $line = str_replace($filteredWord, '', $line);
    }

    list($from, $to) = explode(' through ', $line);
    list($fromX, $fromY) = explode(',', $from);
    list($toX, $toY) = explode(',', $to);

    $lineCoords[] = array(
        array($fromX, $fromY),
        array($toX, $toY)
    );
}

for ($x = 0; $x < 1000; $x++) {
    for ($y = 0; $y < 1000; $y++) {
        echo $x . "," . $y . "\n";
        $lit = 0;
        foreach ($lines as $index => $line) {
            if (isAffectedByLine($x, $y, $lineCoords[$index])) {
                $lit = newStatusByLine($line, $lit);
            }
        }
        $totalLit += $lit;
    }
}

echo $totalLit;

function isAffectedByLine($x, $y, $coords) {
    $fromX = $coords[0][0];
    $fromY = $coords[0][1];
    $toX = $coords[1][0];
    $toY = $coords[1][1];

    return $fromX <= $x && $x <= $toX && $fromY <= $y && $y <= $toY;
}

function newStatusByLine($line, $currentStatus) {
    if (substr($line, 0, 6) === 'toggle') {
        return $currentStatus + 2;
    }
    if (substr($line, 0, 7) === 'turn on') {
        return $currentStatus + 1;
    } else {
        return max(0, $currentStatus - 1);
    }
}
<?php

$input = file_get_contents("input");
$lines = explode("\n", $input);

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

$totalLit = 0;

for ($x = 0; $x < 1000; $x++) {
    for ($y = 0; $y < 1000; $y++) {
        $lit = false;
        foreach ($lines as $index => $line) {
            if (isAffectedByLine($x, $y, $lineCoords[$index])) {
                $lit = newStatusByLine($line, $lit);
            }
        }
        if ($lit) {
            $totalLit++;
        }
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
        return !$currentStatus;
    }
    if (substr($line, 0, 7) === 'turn on') {
        return true;
    } else {
        return false;
    }
}
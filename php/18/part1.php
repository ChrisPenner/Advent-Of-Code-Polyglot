<?php

$input = file_get_contents("input");

$lights = array();

foreach (explode("\n", $input) as $line) {
    $row = array();
    foreach (str_split(trim($line)) as $light) {
        $row[] = ($light == '#');
    }
    $lights[] = $row;
}

for ($i = 0; $i < 100; $i++) {
    $lights = animateLights($lights);
}

$totalLights = 0;
foreach ($lights as $row) {
    foreach ($row as $light) {
        $totalLights += intval($light);
    }
}

echo $totalLights;

function animateLights($lights) {
    $newLights = array();
    foreach ($lights as $rowNumber => $row) {
        $newRow = array();
        foreach ($row as $lightNumber => $light) {
            $neighborsOn = getNeighboursOn($lights, $rowNumber, $lightNumber);

            if ($light && ($neighborsOn != 2 && $neighborsOn != 3)) {
                $newRow[] = false;
            } elseif (!$light && $neighborsOn == 3) {
                $newRow[] = true;
            } else {
                $newRow[] = $light;
            }
        }
        $newLights[] = $newRow;
    }

    return $newLights;
}

function getNeighboursOn($lights, $row, $light) {
    $lightsOn = 0;
    if ($row !== 0) {
        if ($light !== 0) {
            $lightsOn += intval($lights[$row - 1][$light - 1]);
        }
        if($light !== count($lights[0]) - 1) {
            $lightsOn += intval($lights[$row - 1][$light + 1]);
        }
        $lightsOn += intval($lights[$row - 1][$light]);
    }

    if ($row !== count($lights) - 1) {
        if ($light !== 0) {
            $lightsOn += intval($lights[$row + 1][$light - 1]);
        }
        if($light !== count($lights[0]) - 1) {
            $lightsOn += intval($lights[$row + 1][$light + 1]);
        }
        $lightsOn += intval($lights[$row + 1][$light]);
    }

    if ($light !== 0) {
        $lightsOn += intval($lights[$row][$light - 1]);
    }

    if($light !== count($lights[0]) - 1) {
        $lightsOn += intval($lights[$row][$light + 1]);
    }

    return $lightsOn;
}

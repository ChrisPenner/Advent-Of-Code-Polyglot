<?php

$medicin = "CRnSiRnCaPTiMgYCaPTiRnFArSiThFArCaSiThSiThPBCaCaSiRnSiRnTiTiMgArPBCaPMgYPTiRnFArFArCaSiRnBPMgArPRnCaPTiRnFArCaSiThCaCaFArPBCaCaPTiTiRnFArCaSiRnSiAlYSiThRnFArArCaSiRnBFArCaCaSiRnSiThCaCaCaFYCaPTiBCaSiThCaSiThPMgArSiRnCaPBFYCaCaFArCaCaCaCaSiThCaSiRnPRnFArPBSiThPRnFArSiRnMgArCaFYFArCaSiRnSiAlArTiTiTiTiTiTiTiRnPMgArPTiTiTiBSiRnSiAlArTiTiRnPMgArCaFYBPBPTiRnSiRnMgArSiThCaFArCaSiThFArPRnFArCaSiRnTiBSiThSiRnSiAlYCaFArPRnFArSiThCaFArCaCaSiThCaCaCaSiRnPRnCaFArFYPMgArCaPBCaPBSiRnFYPBCaFArCaSiAl";

$input = file_get_contents("input");

$transforms = array();

foreach (explode("\n", $input) as $line) {
    $words = explode(" ", $line);
    $transforms[] = trim($words[0]) . "," . trim($words[2]);
}

$steps = 0;
$tmpMedicin = $medicin;
$lastMedicin = "";

while ($lastMedicin != $tmpMedicin) {
    $lastMedicin = $tmpMedicin;
    foreach ($transforms as $key => $transform) {
        list($to, $from) = explode(",", $transform);
        if (strpos($tmpMedicin, $from) !== false) {
            $tmpMedicin = preg_replace('/' . $from . '/', $to, $tmpMedicin, 1);
            $steps++;
        }
    }
}

echo $steps;

function getMinSteps($medicin, $transforms) {
    if ($medicin == 'e') {
        return 0;
    }
    $minSteps = 1000000;
    foreach ($transforms as $key => $transform) {
        if ($GLOBALS['medicin'] === $medicin) {
            echo $transform . "\n";
        }
        list($to, $from) = explode(",", $transform);
        $start = 0;
        $positions = array();
        while(($pos = strpos($medicin, $from, $start)) !== false) {
            $positions[] = $pos;
            $start = $pos + 1;
        }

        foreach ($positions as $position) {
            $newMedicin = substr_replace($medicin, $to, $position, strlen($from));
            $steps = getMinSteps($newMedicin, $transforms) + 1;

            if ($steps < $minSteps) {
                $minSteps = $steps;
            }
        }
    }

    return $minSteps;
}

function getMinStepsAlt($medicin, $transforms, $targetMedicin) {
    if (strlen($medicin) > strlen($targetMedicin) + 2) {
        return 1000;
    }

    if ($medicin == $targetMedicin) {
        return 0;
    }

    $minSteps = 10000000;
    foreach ($transforms as $key => $transform) {
        list($from, $to) = explode(",", $transform);
        $start = 0;
        $positions = array();
        while(($pos = strpos($medicin, $from, $start)) !== false) {
            $positions[] = $pos;
            $start = $pos + 1;
        }

        foreach ($positions as $position) {
            $newMedicin = substr_replace($medicin, $to, $position, strlen($from));
            $steps = getMinStepsAlt($newMedicin, $transforms, $targetMedicin) + 1;

            if ($steps < $minSteps) {
                $minSteps = $steps;
            }
        }
    }

    return $minSteps;
}
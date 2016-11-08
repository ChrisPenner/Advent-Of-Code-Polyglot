<?php

$medicin = "CRnSiRnCaPTiMgYCaPTiRnFArSiThFArCaSiThSiThPBCaCaSiRnSiRnTiTiMgArPBCaPMgYPTiRnFArFArCaSiRnBPMgArPRnCaPTiRnFArCaSiThCaCaFArPBCaCaPTiTiRnFArCaSiRnSiAlYSiThRnFArArCaSiRnBFArCaCaSiRnSiThCaCaCaFYCaPTiBCaSiThCaSiThPMgArSiRnCaPBFYCaCaFArCaCaCaCaSiThCaSiRnPRnFArPBSiThPRnFArSiRnMgArCaFYFArCaSiRnSiAlArTiTiTiTiTiTiTiRnPMgArPTiTiTiBSiRnSiAlArTiTiRnPMgArCaFYBPBPTiRnSiRnMgArSiThCaFArCaSiThFArPRnFArCaSiRnTiBSiThSiRnSiAlYCaFArPRnFArSiThCaFArCaCaSiThCaCaCaSiRnPRnCaFArFYPMgArCaPBCaPBSiRnFYPBCaFArCaSiAl";

$input = file_get_contents("input");

$transforms = array();

foreach (explode("\n", $input) as $line) {
    $words = explode(" ", $line);
    $transforms[] = trim($words[0]) . "," . trim($words[2]);
}

$transformedMedicin = array();

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
        $transformedMedicin[md5($newMedicin)] = true;
    }
}

echo count($transformedMedicin);

